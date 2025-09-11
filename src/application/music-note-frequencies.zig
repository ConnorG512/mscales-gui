const Raylib = @import("../cimport/raylib.zig").Raylib;

const NoteTemplate = struct {
    frequency: f32,
    input_button: c_int,
    note_name: [:0]const u8,
};

const NoteFrequencies = struct {
    pub const c6: f32 = 261.63 * 4;
    pub const cs6: f32 = 277.18 * 4;
    pub const d6: f32 = 293.66 * 4;
    pub const ds6: f32 = 311.13 * 4;
    pub const e6: f32 = 329.63 * 4;
    pub const f6: f32 = 349.23 * 4;
    pub const fs6: f32 = 369.99 * 4;
    pub const g6: f32 = 392.00 * 4;
    pub const gs6: f32 = 415.30 * 4;
    pub const a6: f32 = 440.00 * 4;
    pub const as6: f32 = 466.16 * 4;
    pub const b6: f32 = 493.88 * 4;
    pub const c7: f32 = 523.25 * 4;
};

pub const OctaveFour = [_]NoteTemplate {
    .{ .frequency = NoteFrequencies.c6, .input_button = Raylib.KEY_Z, .note_name = "C" },
    .{ .frequency = NoteFrequencies.cs6, .input_button = Raylib.KEY_S, .note_name = "C#/Db" },
    .{ .frequency = NoteFrequencies.d6, .input_button = Raylib.KEY_X, .note_name = "D" },
    .{ .frequency = NoteFrequencies.ds6, .input_button = Raylib.KEY_D, .note_name = "D#/Eb" },
    .{ .frequency = NoteFrequencies.e6, .input_button = Raylib.KEY_C, .note_name = "E" },
    .{ .frequency = NoteFrequencies.f6, .input_button = Raylib.KEY_V, .note_name = "F" },
    .{ .frequency = NoteFrequencies.fs6, .input_button = Raylib.KEY_G, .note_name = "F#/Gb" },
    .{ .frequency = NoteFrequencies.g6, .input_button = Raylib.KEY_B, .note_name = "G" },
    .{ .frequency = NoteFrequencies.gs6, .input_button = Raylib.KEY_H, .note_name = "G#/Fb" },
    .{ .frequency = NoteFrequencies.a6, .input_button = Raylib.KEY_N, .note_name = "A" },
    .{ .frequency = NoteFrequencies.as6, .input_button = Raylib.KEY_J, .note_name = "A#/Bb" },
    .{ .frequency = NoteFrequencies.b6, .input_button = Raylib.KEY_M, .note_name = "B" },
    .{ .frequency = NoteFrequencies.c7, .input_button = Raylib.KEY_COMMA, .note_name = "C" },
};

