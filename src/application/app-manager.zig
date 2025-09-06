const Window = @import("../system/window.zig").Window;
const Raylib = @import("../cimport/raylib.zig").Raylib;
const Renderer = @import("../system/renderer.zig").Renderer;
const LuaState = @import("../system/lua-instance.zig").LuaInstance;
const Color = @import("../theming/colors.zig");
const TextRender = @import("../system/text-rendering.zig");
const Audio = @import("../system/audio.zig").Audio;
const MusicScale = @import("music-scales.zig");

pub const AppManager = struct {
    lua_instance: LuaState = undefined,
    audio_manager: Audio = undefined,
    window: Window = undefined,
    renderer: Renderer = undefined,

    pub fn initApp(self: *AppManager) !void {
        try self.lua_instance.initLua();

        Window.initWindow(
            @intFromFloat(try self.lua_instance.readGlobalFromFile("scripts/config.lua", "Width")), 
            @intFromFloat(try self.lua_instance.readGlobalFromFile("scripts/config.lua", "Height")), 
            "Mscales GUI");

        Audio.init();
        self.audio_manager.sample_rate = @intFromFloat(try self.lua_instance.readGlobalFromFile(
                "scripts/config.lua", 
                "SampleRate"));
        self.audio_manager.sample_size = @intFromFloat(try self.lua_instance.readGlobalFromFile(
                "scripts/config.lua", 
                "SampleSize"));
        self.audio_manager.channels = @intFromFloat(try self.lua_instance.readGlobalFromFile(
                "scripts/config.lua", 
                "Channels"));

        try self.renderer.initBackgroundFromLuaFile(&self.lua_instance);

    }
    
    pub fn updateApp(self: *AppManager) void {
        
        Renderer.beginDraw();
        self.renderer.clearBackground();
        TextRender.TextRendering.drawTextToFixedPosition(
            MusicScale.CMajor.title, 
            32, 16, 
            .TopCentre, 
            Color.MiddleGrey );

        Renderer.endDrawing(); 
    }
    
    pub fn cleanupApp(self: *AppManager) void {
        self.lua_instance.closeLua();
        Window.closeWindow();
    }
};
