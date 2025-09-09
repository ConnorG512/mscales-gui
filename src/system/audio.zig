const std = @import("std");

const Raylib = @import("../cimport/raylib.zig").Raylib;
const LuaState = @import("../system/lua-instance.zig").LuaInstance;
const Oscillator = @import("../application/oscillator.zig");

pub const Audio = struct {
    sample_rate: c_uint = undefined,
    sample_size: c_uint = undefined,
    channels: c_uint = undefined,
    audio_stream: Raylib.AudioStream = undefined,
    audio_stream_buffer_size: c_int = undefined,

    pub fn initAudioFromLuaFile(self: *Audio, lua_instance: *LuaState) !void {
        try self.loadLuaData(lua_instance); 
        Raylib.InitAudioDevice();
        Raylib.SetAudioStreamBufferSizeDefault(self.audio_stream_buffer_size);
        
        self.loadAudioStream();
        Raylib.SetAudioStreamCallback(self.audio_stream, Oscillator.writeDataToSoundBuffer);
        Raylib.PlayAudioStream(self.audio_stream);
    } 

    pub fn closeAudio() void {
        Raylib.CloseAudioDevice();
    }

    fn loadAudioStream(self: *Audio) void {
        self.audio_stream = Raylib.LoadAudioStream(self.sample_rate, self.sample_size, self.channels);
        std.log.debug("Audio stream:\n\tSample Rate:{d}\n\tSample Size:{d}\n\tChannels:{d}.", .{
            self.sample_rate, self.sample_size, self.channels});
    }

    pub fn updateAudioStream(self: *Audio, audio_buffer: [512]i16) void {
        Raylib.UpdateAudioStream(self.audio_stream, audio_buffer[0..], audio_buffer.len);
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
        self.audio_stream_buffer_size = @intFromFloat(try lua_instance.readGlobalFromFile(
            "scripts/config.lua", 
            "AudioStreamBufferSize"));
    } 

    pub fn playAudioStream(self: *Audio) void {
        Raylib.PlayAudioStream(self.audio_stream);
    }
};
