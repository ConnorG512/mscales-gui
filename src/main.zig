const std = @import("std");
const Window = @import("system/window.zig").Window;
const Raylib = @import("cimport/raylib.zig").Raylib;
const Renderer = @import("system/renderer.zig").Renderer;
const LuaState = @import("system/lua-instance.zig").LuaInstance;
const Color = @import("theming/colors.zig");
const TextRender = @import("system/text-rendering.zig");
const Audio = @import("system/audio.zig").Audio;

const MusicScale = @import("music-scales.zig");

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

    const background_color: Raylib.Color = Color.createCustomColor(
        @intFromFloat(try lua_instance.readGlobalFromFile("scripts/config.lua", "BackgroundR")), 
        @intFromFloat(try lua_instance.readGlobalFromFile("scripts/config.lua", "BackgroundG")), 
        @intFromFloat(try lua_instance.readGlobalFromFile("scripts/config.lua", "BackgroundB")), 
    );

    Audio.init();
    var application_audio = Audio {
        .sample_rate = @intFromFloat(try lua_instance.readGlobalFromFile("scripts/config.lua", "SampleRate")),
        .sample_size = @intFromFloat(try lua_instance.readGlobalFromFile("scripts/config.lua", "SampleSize")),
        .channels = @intFromFloat(try lua_instance.readGlobalFromFile("scripts/config.lua", "Channels")),
    };
    const audio_stream = application_audio.loadAudioStream();

    while (!Raylib.WindowShouldClose()) {
        Raylib.PlayAudioStream(audio_stream);

        Renderer.beginDraw(); 
        Renderer.clearBackground(background_color); 
        TextRender.TextRendering.drawTextToFixedPosition(MusicScale.CMajor.title, 32, 32, TextRender.ScreenPositions.TopCentre, Color.MiddleGrey);
        TextRender.TextRendering.drawTextToFixedPosition(MusicScale.CMajor.scale_type, 16, 64, TextRender.ScreenPositions.TopCentre, Color.MiddleGrey);
        Renderer.endDrawing();
    }
}

