const std = @import("std");

const Raylib = @import("../cimport/raylib.zig").Raylib;
const LuaState = @import("../system/lua-instance.zig").LuaInstance;

pub const Audio = struct {
    sample_rate: c_uint = undefined,
    sample_size: c_uint = undefined,
    channels: c_uint = undefined,
    audio_stream :Raylib.AudioStream,

    pub fn initAudioFromLuaFile(self: *Audio, lua_instance: *LuaState) !void {
        Raylib.InitAudioDevice();
        try self.loadLuaData(lua_instance); 
        self.loadAudioStream();
    } 

    pub fn closeAudio() void {
        Raylib.CloseAudioDevice();
    }

    fn loadAudioStream(self: *Audio) void {
        self.audio_stream = Raylib.LoadAudioStream(self.sample_rate, self.sample_size, self.channels);
        std.log.debug("Audio stream:\n\tSample Rate:{d}\n\tSample Size:{d}\n\tChannels:{d}.", .{
            self.sample_rate, self.sample_size, self.channels});
    }

    fn loadLuaData(self: *Audio, lua_instance: *LuaState) !void {
        self.sample_rate = @intFromFloat(try lua_instance.readGlobalFromFile(
            "scripts/config.lua", 
            "SampleRate"));
        self.sample_size = @intFromFloat(try lua_instance.readGlobalFromFile(
            "scripts/config.lua", 
            "SampleSize"));
        self.channels= @intFromFloat(try lua_instance.readGlobalFromFile(
            "scripts/config.lua", 
            "Channels"));
    } 
};
