const Raylib = @import("../cimport/raylib.zig").Raylib;

pub const White = Raylib.Color {
   .a = 255,
   .r = 255,
   .g = 255,
   .b = 255,
};

pub const Black = Raylib.Color {
   .a = 255,
   .r = 0,
   .g = 0,
   .b = 0,
};

pub const MiddleGrey = Raylib.Color {
    .a = 255,
    .r = 255 / 2,
    .g = 255 / 2,
    .b = 255 / 2,
};

pub const DarkGrey = Raylib.Color {
    .a = 255,
    .r = 255 / 4,
    .g = 255 / 4,
    .b = 255 / 4,
};

pub fn createCustomColor(r: u8, g: u8, b: u8) Raylib.Color {
    return .{ .a = 255, .r = r, .g = g, .b = b };
}

