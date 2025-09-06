const r = @import("../cimport/raylib.zig").Raylib;
const LuaState = @import("../system/lua-instance.zig").LuaInstance;

pub const Window = struct {
    window_height: c_int = undefined,
    window_width: c_int = undefined,
    target_framerate: c_int = undefined,

    pub fn initWindowFromLuaFile (self: *Window, lua_instance: *LuaState) !void {
        allowResize();
        try self.readLuaWindowProperties(lua_instance);
        self.createWindow("MScales GUI");
        setTargetFramerate(self.target_framerate);
    }
    fn createWindow(self: *Window, title: [:0]const u8) void {
       r.InitWindow(self.window_width, self.window_height, title);
    }

    fn readLuaWindowProperties(self: *Window, lua_instance: *LuaState) !void {
        self.window_width = @intFromFloat(try lua_instance.readGlobalFromFile(
                "scripts/config.lua", 
                "Width"));
        self.window_height = @intFromFloat(try lua_instance.readGlobalFromFile(
                "scripts/config.lua", 
                "Height"));
        self.target_framerate = @intFromFloat(try lua_instance.readGlobalFromFile(
                "scripts/config.lua", 
                "TargetFramerate")); 
    } 
    
    pub fn setTargetFramerate(target_fps: c_int) void {
        r.SetTargetFPS(target_fps);
    }
    
    pub fn closeWindow() void {
        r.CloseWindow();
    }

    fn allowResize() void {
        r.SetConfigFlags(r.FLAG_WINDOW_RESIZABLE);
    }
};
