const std = @import("std");
const Window = @import("system/window.zig").Window;
const Raylib = @import("cimport/raylib.zig").Raylib;
const Renderer = @import("system/renderer.zig").Renderer;
const LuaState = @import("system/lua-instance.zig").LuaInstance;
const ColorBackground = @import("theming/background_colors.zig");

pub fn main() !void {
    var lua_instance: LuaState = .{};
    try lua_instance.initLua();
    defer lua_instance.closeLua();

    const screen_width: c_int = @intFromFloat(try lua_instance.readGlobalFromFile("scripts/config.lua", "Width"));
    const screen_height: c_int = @intFromFloat(try lua_instance.readGlobalFromFile("scripts/config.lua", "Height"));

    Window.initWindow(screen_width, screen_height, "Mscales GUI");
    defer Window.closeWindow();

    while (!Raylib.WindowShouldClose()) {
        Renderer.beginDraw(); 
        Renderer.clearBackground(ColorBackground.DarkGrey); 
        Raylib.DrawText("Hello", 800, 600, 32, ColorBackground.MiddleGrey);
        Renderer.endDrawing();
    }
}

