const Raylib = @import("../cimport/raylib.zig").Raylib;
const Audio = @import("../system/audio.zig").Audio;
const std = @import("std");
const Oscilator = @import("../application/oscillator.zig");

pub fn triggerSound(keypress: c_uint) void {
    if (testForHeldKey(keypress)) {
        Oscilator.current_sound_status = Oscilator.SoundStatus.SineWave;
    } else {
        Oscilator.current_sound_status = Oscilator.SoundStatus.NoSound;
    }
}
fn testForHeldKey(key: c_uint) bool {
    const is_key_down: bool = Raylib.IsKeyDown(@intCast(key));
    return is_key_down;
}
