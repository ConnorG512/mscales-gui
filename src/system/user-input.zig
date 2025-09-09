const Raylib = @import("../cimport/raylib.zig").Raylib;
const std = @import("std");
const Oscilator = @import("../application/oscillator.zig");

const NoteFrequencies = @import("../application/music-note-frequencies.zig");

pub fn triggerSoundOnInput() void {
    for (NoteFrequencies.OctaveFour) |note| {
        if (Raylib.IsKeyDown(note.input_button)) {
            Oscilator.setupPlayAudio(.SineWave, note.frequency);
        }
    }
}

