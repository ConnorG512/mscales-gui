const std = @import("std");
const Window = @import("system/window.zig").Window;
const Raylib = @import("cimport/raylib.zig").Raylib;
const Renderer = @import("system/renderer.zig").Renderer;
const LuaState = @import("system/lua-instance.zig").LuaInstance;
const Color = @import("theming/colors.zig");
const TextRender = @import("system/text_rendering.zig");

const Vec2 = @import("util/vector2.zig");

pub fn main() !void {
    var lua_instance: LuaState = .{};
    try lua_instance.initLua();
    defer lua_instance.closeLua();

    const screen_resolution: Vec2 .vectorTwo(c_int) = .{
        .x = @intFromFloat(try lua_instance.readGlobalFromFile("scripts/config.lua", "Width")),
        .y = @intFromFloat(try lua_instance.readGlobalFromFile("scripts/config.lua", "Height")),
    };

    Window.initWindow(screen_resolution.x, screen_resolution.y, "Mscales GUI");
    defer Window.closeWindow();

    while (!Raylib.WindowShouldClose()) {
        Renderer.beginDraw(); 
        Renderer.clearBackground(Color.DarkGrey); 
        TextRender.TextRendering.drawTextToFixedPosition("PLACEHOLDER", 32, 32, TextRender.ScreenPositions.TopCentre, Color.MiddleGrey);
        Renderer.endDrawing();
    }
}

