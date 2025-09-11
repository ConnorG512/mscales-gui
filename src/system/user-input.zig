const Raylib = @import("../cimport/raylib.zig").Raylib;
const std = @import("std");
const Oscillator = @import("../application/oscillator.zig").Oscillator;

const NoteFrequencies = @import("../application/music-note-frequencies.zig");

pub fn triggerSoundOnInput(oscillator: *Oscillator) [:0]const u8 {
    for (NoteFrequencies.OctaveFour) |note| {
        if (Raylib.IsKeyDown(note.input_button)) {
            Oscillator.setupPlayAudio(oscillator, .SineWave, note.frequency);
            return note.note_name;
        }
    }
    oscillator.setupPlayAudio(.NoSound, 440);
    return "";
}

pub fn changeOctave(oscillator: *Oscillator) c_int {
    if (Raylib.IsKeyPressed(Raylib.KEY_EQUAL)) {

        return oscillator.increaseCurrentOctave();
    }
    if (Raylib.IsKeyPressed(Raylib.KEY_MINUS)) {

        return oscillator.decreaseCurrentOctave();
    }
    return oscillator.current_octave;
}

