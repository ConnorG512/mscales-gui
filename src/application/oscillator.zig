const Audio = @import("../system/audio.zig").Audio;
const LuaState = @import("../system/lua-instance.zig").LuaInstance;
const UserInput = @import("../system/user-input.zig").UserInput;
const Raylib = @import("../cimport/raylib.zig").Raylib;
const std = @import("std");

var phase: f32 = 0.0;

const frequency: f32 = 440.0;
var audioFrequency: f32 = 440.0;
const old_frequency: f32 = 1.0;
var sineIdx: f32 = 0.0;
var sample_rate: f32 = 44100;
var base_amplitude: f32 = 32000.0;

pub fn initFromLuaFile(lua_instance: *LuaState) !void {
    sample_rate = @floatCast(try lua_instance.readGlobalFromFile(
        "scripts/config.lua", 
        "SampleRate"));
    base_amplitude = @floatCast(try lua_instance.readGlobalFromFile(
        "scripts/config.lua", 
        "BaseAmplitude"));
}

pub fn writeDataToSoundBuffer(raw_buffer: ?*anyopaque, frames: c_uint) callconv(.c) void {
    const sound_buffer: [*]i16 = @ptrCast(@alignCast(raw_buffer));

    audioFrequency = frequency + (audioFrequency - frequency ) * 0.95;
    const incr = audioFrequency / sample_rate;

    for (sound_buffer[0..frames]) |*sample| {
        sample.* = @intFromFloat(base_amplitude * std.math.sin( 2 * std.math.pi * sineIdx ));
        sineIdx += incr;
        if (sineIdx > 1.0) sineIdx -= 1.0;
    }
}
