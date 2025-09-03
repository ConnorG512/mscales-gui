const r = @import("../cimport/raylib.zig").Raylib;

pub const Window = struct {

    pub fn initWindow (width: c_int, height: c_int, title: [:0]const u8) void {
        createWindow(width, height, title);
        allowResize();
        setTargetFramerate(60);
    }
    fn createWindow(width: c_int, height: c_int, title: [:0]const u8) void {
       r.InitWindow(width, height, title);
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
