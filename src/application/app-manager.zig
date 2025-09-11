const Window = @import("../system/window.zig").Window;
const Raylib = @import("../cimport/raylib.zig").Raylib;
const Renderer = @import("../system/renderer.zig").Renderer;
const LuaState = @import("../system/lua-instance.zig").LuaInstance;
const Color = @import("../theming/colors.zig");
const TextRender = @import("../system/text-rendering.zig");
const Audio = @import("../system/audio.zig").Audio;
const MusicScale = @import("music-scales.zig");
const UserInput = @import("../system/user-input.zig");
const Oscillator = @import("../application/oscillator.zig").Oscillator;

const std = @import("std");

pub const AppManager = struct {
    lua_instance: LuaState = undefined,
    audio_manager: Audio = undefined,
    window: Window = undefined,
    renderer: Renderer = undefined,
    oscillator: Oscillator = undefined,

    pub fn initApp(self: *AppManager) !void {
        try self.lua_instance.initLua();
        try self.window.initWindowFromLuaFile(&self.lua_instance);
        try self.renderer.initBackgroundFromLuaFile(&self.lua_instance);
        try self.audio_manager.initAudioFromLuaFile(&self.lua_instance);
        try self.oscillator.initFromLuaFile(&self.lua_instance);
    }
    
    pub fn updateApp(self: *AppManager) void {

        const current_note_string: [:0]const u8 = UserInput.triggerSoundOnInput(&self.oscillator);
        const current_octave: c_int = UserInput.changeOctave();

        Renderer.beginDraw();
        defer Renderer.endDrawing(); 

        self.renderer.clearBackground();

        TextRender.TextRendering.drawTextToFixedPosition(
            MusicScale.CMajor.title, 
            32,
            16, 
            .TopCentre, 
            Color.MiddleGrey );
        
        TextRender.TextRendering.drawTextToFixedPosition(
            current_note_string, 
            64, 
            0, 
            .Centre, 
            Color.MiddleGrey );

        TextRender.TextRendering.drawOctaveText(current_octave, Color.MiddleGrey);

    }
    
    pub fn cleanupApp(self: *AppManager) void {
        Audio.closeAudio();
        Window.closeWindow();
        self.lua_instance.closeLua();
    }
};
