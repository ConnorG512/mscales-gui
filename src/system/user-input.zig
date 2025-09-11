const Raylib = @import("../cimport/raylib.zig").Raylib;
const std = @import("std");
const Oscilator = @import("../application/oscillator.zig");

const NoteFrequencies = @import("../application/music-note-frequencies.zig");

pub fn triggerSoundOnInput() [:0]const u8 {
    for (NoteFrequencies.OctaveFour) |note| {
        if (Raylib.IsKeyDown(note.input_button)) {
            Oscilator.setupPlayAudio(.SineWave, note.frequency);
            return note.note_name;
        }
    }
    Oscilator.setupPlayAudio(.NoSound, 440);
    return "";
}

pub fn changeOctave() void {
    if (Raylib.IsKeyPressed(Raylib.KEY_EQUAL)) {

    }
    if (Raylib.IsKeyPressed(Raylib.KEY_MINUS)) {

    }
}

