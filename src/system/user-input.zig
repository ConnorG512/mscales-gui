const Raylib = @import("../cimport/raylib.zig").Raylib;
const Audio = @import("../system/audio.zig").Audio;
const std = @import("std");
const Oscilator = @import("../application/oscillator.zig");

pub fn triggerSoundOnInput() void {
    if (Raylib.IsKeyDown(Raylib.KEY_C)) {
        Oscilator.setupPlayAudio(Oscilator.SoundStatus.SineWave, 261.63);
    }
    if (Raylib.IsKeyDown(Raylib.KEY_D)) {
        Oscilator.setupPlayAudio(Oscilator.SoundStatus.SineWave, 293.66);
    }
    if (Raylib.IsKeyDown(Raylib.KEY_E)) {
        Oscilator.setupPlayAudio(Oscilator.SoundStatus.SineWave, 329.63);
    }
    if (Raylib.IsKeyDown(Raylib.KEY_F)) {
        Oscilator.setupPlayAudio(Oscilator.SoundStatus.SineWave, 349.23);
    }
    if (Raylib.IsKeyDown(Raylib.KEY_G)) {
        Oscilator.setupPlayAudio(Oscilator.SoundStatus.SineWave, 392.00);
    }
    if (Raylib.IsKeyDown(Raylib.KEY_A)) {
        Oscilator.setupPlayAudio(Oscilator.SoundStatus.SineWave, 440.00);
    }
    if (Raylib.IsKeyDown(Raylib.KEY_B)) {
        Oscilator.setupPlayAudio(Oscilator.SoundStatus.SineWave, 493.88);
    } 
}

