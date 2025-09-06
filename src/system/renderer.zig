const Raylib = @import("../cimport/raylib.zig").Raylib;
const LuaState = @import("../system/lua-instance.zig").LuaInstance;

pub const Renderer = struct {
    current_background_color: Raylib.Color = undefined,

    pub fn beginDraw() void {
        Raylib.BeginDrawing();
    }
    pub fn clearBackground(self: *Renderer) void {
        Raylib.ClearBackground(self.current_background_color);
    }
    pub fn endDrawing() void {
        Raylib.EndDrawing();
    }
    pub fn initBackgroundFromLuaFile(self: *Renderer, lua_state: *LuaState) !void {
       self.current_background_color.a = 255;
       self.current_background_color.r = @intFromFloat(try lua_state.readGlobalFromFile(
               "scripts/config.lua", 
               "BackgroundR"));
       self.current_background_color.g = @intFromFloat(try lua_state.readGlobalFromFile(
               "scripts/config.lua", 
               "BackgroundG"));
       self.current_background_color.b = @intFromFloat(try lua_state.readGlobalFromFile(
               "scripts/config.lua", 
               "BackgroundB"));
    }
};
