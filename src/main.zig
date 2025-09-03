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

    try lua_instance.openFile("scripts/config.lua");
    lua_instance.pCallK();
    _ = lua_instance.getGlobal("Width");

    const screen_width: c_int = @intFromFloat(lua_instance.toNumber(-1));

    Window.initWindow(screen_width, 1080, "Mscales GUI");
    defer Window.closeWindow();

    while (!Raylib.WindowShouldClose()) {
        Renderer.beginDraw(); 
        Renderer.clearBackground( ColorBackground.Green); 
        Renderer.endDrawing();
    }
}

