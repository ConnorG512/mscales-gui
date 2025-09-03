const std = @import("std");
const Lua = @import("../cimport/lua.zig").Lua;

const LuaError = error {
    CouldNotCreateState,
    CouldNotOpenLuaFile,
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

    pub fn getField(self: *LuaInstance, index: c_int, name: [:0]const u8) void {
        Lua.lua_getfield(self.lua_state, index, name);
    }

    pub fn pushGlobal(self: *LuaInstance, global_name: [:0]const u8) void {
        Lua.lua_getglobal(self.lua_state, global_name);
    }

    pub fn popFromStack(self: *LuaInstance, stack_elem: anytype) void {
        Lua.lua_pop(self.lua_state, stack_elem);
    }

    pub fn openFile(self: *LuaInstance, filename: [:0]const u8) !void {
        const result: c_int = Lua.luaL_loadfilex(self.lua_state, filename.ptr, null); 
        if (result != Lua.LUA_OK) {
            std.log.debug("Lua load file result: {d}", .{ result });
            return error.FailedToOpenLuaFile;
        }
    }

    pub fn closeLua(self: *LuaInstance) void {
        Lua.lua_close(self.lua_state);
    }
};
