const std = @import("std");
const Window = @import("system/window.zig").Window;
const Raylib = @import("cimport/raylib.zig").Raylib;
const Renderer = @import("system/renderer.zig").Renderer;
const LuaState = @import("system/lua-instance.zig").LuaInstance;

pub fn main() !void {
    var lua_instance: LuaState = .{};
    try lua_instance.initLua();

    Window.initialiseWindow(1920, 1080, "Mscales GUI");
    defer Window.closeWindow();
    Window.setTargetFramerate(60);

    while (!Raylib.WindowShouldClose()) {
        Renderer.beginDraw(); 
        Renderer.clearBackground( .{ .r = 20, .b = 40, .g = 60, .a = 255 }); 
        Renderer.endDrawing();
    }
}

