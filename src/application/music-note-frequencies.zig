const Raylib = @import("../cimport/raylib.zig").Raylib;

const NoteTemplate = struct {
    frequency: f32,
    input_button: c_int,
};

const NoteFrequencies = struct {
    pub const c4: f32 = 261.63;
    pub const cs4: f32 = 277.18;
    pub const d4: f32 = 293.66;
    pub const ds4: f32 = 311.13;
    pub const e4: f32 = 329.63;
    pub const f4: f32 = 349.23;
    pub const fs4: f32 = 369.99;
    pub const g4: f32 = 392.00;
    pub const gs4: f32 = 415.30;
    pub const a4: f32 = 440.00;
    pub const as4: f32 = 466.16;
    pub const b4: f32 = 493.88;
    pub const c5: f32 = 523.25;
};

pub const OctaveFour = [_]NoteTemplate {
    .{ .frequency = NoteFrequencies.c4, .input_button = Raylib.KEY_Z },
    .{ .frequency = NoteFrequencies.cs4, .input_button = Raylib.KEY_S },
    .{ .frequency = NoteFrequencies.d4, .input_button = Raylib.KEY_X },
    .{ .frequency = NoteFrequencies.ds4, .input_button = Raylib.KEY_D },
    .{ .frequency = NoteFrequencies.e4, .input_button = Raylib.KEY_C },
    .{ .frequency = NoteFrequencies.f4, .input_button = Raylib.KEY_V },
    .{ .frequency = NoteFrequencies.fs4, .input_button = Raylib.KEY_G },
    .{ .frequency = NoteFrequencies.g4, .input_button = Raylib.KEY_B },
    .{ .frequency = NoteFrequencies.gs4, .input_button = Raylib.KEY_H },
    .{ .frequency = NoteFrequencies.a4, .input_button = Raylib.KEY_N },
    .{ .frequency = NoteFrequencies.as4, .input_button = Raylib.KEY_J },
    .{ .frequency = NoteFrequencies.b4, .input_button = Raylib.KEY_M },
    .{ .frequency = NoteFrequencies.c5, .input_button = Raylib.KEY_COMMA },
};

