const std = @import("std");
const Window = @import("system/window.zig").Window;
const Raylib = @import("cimport/raylib.zig").Raylib;
const Renderer = @import("system/renderer.zig").Renderer;
const LuaState = @import("system/lua-instance.zig").LuaInstance;
const ColorBackground = @import("theming/background_colors.zig");
const TextRender = @import("system/text_rendering.zig");

pub fn main() !void {
    var lua_instance: LuaState = .{};
    try lua_instance.initLua();
    defer lua_instance.closeLua();

    const screen_resolution: [2]c_int = .{
        @intFromFloat(try lua_instance.readGlobalFromFile("scripts/config.lua", "Width")),
        @intFromFloat(try lua_instance.readGlobalFromFile("scripts/config.lua", "Height")),
    };

    Window.initWindow(screen_resolution[0], screen_resolution[1], "Mscales GUI");
    defer Window.closeWindow();

    while (!Raylib.WindowShouldClose()) {
        Renderer.beginDraw(); 
        Renderer.clearBackground(ColorBackground.DarkGrey); 
        TextRender.TextRendering.drawTextToFixedPosition("PLACEHOLDER", 32, TextRender.ScreenPositions.TopCentre, ColorBackground.MiddleGrey);
        Renderer.endDrawing();
    }
}

