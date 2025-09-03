const std = @import("std");
const Lua = @import("cimport/lua.zig").Lua;

const LuaError = error {
    CouldNotCreateState,
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

};
