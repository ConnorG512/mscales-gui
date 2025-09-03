const Raylib = @import("../cimport/raylib.zig").Raylib;

pub const Renderer = struct {
    pub fn beginDraw() void {
        Raylib.BeginDrawing();
    }
    pub fn clearBackground(color: Raylib.Color) void {
        Raylib.ClearBackground(color);
    }
    pub fn endDrawing() void {
        Raylib.EndDrawing();
    }
};
