const std = @import("std");
const c =  @cImport({
    @cInclude("raylib.h");
    @cInclude("lua.h");
});
pub fn main() !void {
    c.InitWindow(1920, 1080, "Hello");

    while (!c.WindowShouldClose()) {

    }

    c.CloseWindow();
}

