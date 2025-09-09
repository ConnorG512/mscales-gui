const Raylib = @import("../cimport/raylib.zig").Raylib;

const NoteTemplate = struct {
    frequency: f32,
    input_button: c_int,
};

pub const OctaveFour = [_]NoteTemplate {
    .{ .frequency = 261.63, .input_button = Raylib.KEY_C },
    .{ .frequency = 293.66, .input_button = Raylib.KEY_D },
    .{ .frequency = 329.63, .input_button = Raylib.KEY_E },
    .{ .frequency = 349.23, .input_button = Raylib.KEY_F },
    .{ .frequency = 392.00, .input_button = Raylib.KEY_G },
    .{ .frequency = 440.00, .input_button = Raylib.KEY_A },
    .{ .frequency = 493.88, .input_button = Raylib.KEY_B },
};


