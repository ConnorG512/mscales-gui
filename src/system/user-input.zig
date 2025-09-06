const Raylib = @import("../cimport/raylib.zig").Raylib;

pub const UserInput = struct {
    pub fn checkForHeldInput() bool {
        return Raylib.IsKeyDown(Raylib.KEY_SPACE);
    }
};
