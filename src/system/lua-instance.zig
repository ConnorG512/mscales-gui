const std = @import("std");
const Lua = @import("../cimport/lua.zig").Lua;

const LuaError = error {
    CouldNotCreateState,
    FailedToOpenLuaFile,
};

pub const LuaInstance = struct {
    lua_state: *Lua.lua_State = undefined,

    pub fn initLua(self: *LuaInstance) LuaError!void {
       try self.createLuaState();
       self.openLibs();
    }

    fn createLuaState(self: *LuaInstance) LuaError!void {
        self.lua_state = Lua.luaL_newstate() orelse return error.CouldNotCreateState;
        std.log.debug("Created lua state! {*}", .{ self.lua_state });
    }

    fn openLibs(self: *LuaInstance) void {
        Lua.luaL_openlibs(self.lua_state);
        std.log.debug("Lua libs opened!", .{});
    }

    pub fn readGlobalFromFile(self: *LuaInstance, file_path: [:0]const u8, target: [:0]const u8) LuaError!f64 {
        try openFile(self, file_path);
        pCallK(self);
        _ = getGlobal(self, target);

        const stack_pos = comptime 1;
        const value_from_file = toNumber(self, -stack_pos);
        popFromStack(self, stack_pos);

        return value_from_file;
    } 

    fn getField(self: *LuaInstance, index: c_int, name: [:0]const u8) void {
        Lua.lua_getfield(self.lua_state, index, name);
    }

    fn getGlobal(self: *LuaInstance, global_name: [:0]const u8) c_int {
        const data_type = Lua.lua_getglobal(self.lua_state, global_name);
        if (data_type == 0) {
            std.log.err("Data type not found in (getGlobal) {d}.", .{ data_type });
        }
        std.log.debug("data_type result (getGlobal) {d}.", .{ data_type });
        return data_type;
    }

    fn popFromStack(self: *LuaInstance, stack_elem: c_int) void {
        Lua.lua_pop(self.lua_state, stack_elem);
    }

    fn pCallK(self:*LuaInstance) void {
        const result = Lua.lua_pcallk(self.lua_state, 0, 0, 0, 0, null);
        std.log.debug("Result (pCallK): {d}.", .{ result });
    }

    fn openFile(self: *LuaInstance, filename: [:0]const u8) LuaError!void {
        const result: c_int = Lua.luaL_loadfilex(self.lua_state, filename.ptr, null); 
        if (result != Lua.LUA_OK) {
            std.log.debug("Lua load file result: {d}", .{ result });
            return error.FailedToOpenLuaFile;
        }
    }

    fn toNumber(self: *LuaInstance, stack_pos: c_int) Lua.lua_Number {
        var result: c_int = 0;
        const lua_number = Lua.lua_tonumberx(self.lua_state, stack_pos, &result);
        std.log.debug("Lua load file result (toNumber): {d}", .{ result });
        return lua_number;
    }

    pub fn closeLua(self: *LuaInstance) void {
        Lua.lua_close(self.lua_state);
    }
};
