const Audio = @import("../system/audio.zig").Audio;
const LuaState = @import("../system/lua-instance.zig").LuaInstance;
const UserInput = @import("../system/user-input.zig").UserInput;
const Raylib = @import("../cimport/raylib.zig").Raylib;
const std = @import("std");

var oscliator_instance_ptr: ?*Oscillator = null;

pub const SoundStatus = enum {
    NoSound,
    SineWave,
};

pub const Oscillator = struct {
    phase: f32 = 0.0,
    audioFrequency: f32 = 440.0,
    sineIdx: f32 = 0.0,
    sample_rate: f32 = 44100,
    base_amplitude: f32 = 32000.0,
    current_sound_status: SoundStatus = .NoSound,

    pub fn initFromLuaFile(self: *Oscillator, lua_instance: *LuaState) !void {
        self.sample_rate = @floatCast(try lua_instance.readGlobalFromFile(
            "scripts/config.lua", 
            "SampleRate"));
        self.base_amplitude = @floatCast(try lua_instance.readGlobalFromFile(
            "scripts/config.lua", 
            "BaseAmplitude"));
        oscliator_instance_ptr = self;
        std.log.debug("Oscillator ptr: [{*}]", .{oscliator_instance_ptr});
    }

    pub fn setupPlayAudio(self: *Oscillator, chosen_sound_status: SoundStatus, chosen_frequency: f32) void {
        self.audioFrequency = chosen_frequency;
        self.current_sound_status = chosen_sound_status;
    }

    pub fn writeDataToSoundBuffer(raw_buffer: ?*anyopaque, frames: c_uint) callconv(.c) void {
        std.debug.assert(oscliator_instance_ptr != null);
        const sound_buffer: [*]i16 = @ptrCast(@alignCast(raw_buffer));

        switch (oscliator_instance_ptr.?.current_sound_status) {
            .NoSound => {
               noSound(sound_buffer[0..frames]);
            },
            .SineWave => {
                oscliator_instance_ptr.?.playSine(sound_buffer[0..frames]);
            },
        }
    }

    pub fn playSine (self: *Oscillator, sound_buffer: []i16) void {
        const incr = self.audioFrequency / self.sample_rate;

        for (sound_buffer[0..]) |*sample| {
            sample.* = @intFromFloat(self.base_amplitude * std.math.sin( 2 * std.math.pi * self.sineIdx ));
            self.sineIdx += incr;
            if (self.sineIdx > 1.0) self.sineIdx -= 1.0;
        }
    }

    pub fn noSound(sound_buffer: []i16) void {
        for (sound_buffer[0..]) |*sample| {
            sample.* = @intFromFloat( 0x00 );
        }
    }
};

