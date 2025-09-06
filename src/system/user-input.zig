const Raylib = @import("../cimport/raylib.zig").Raylib;
const std = @import("std");

pub const UserInput = struct {
    pub fn testPrint() void {
        if (Raylib.IsKeyDown(Raylib.KEY_SPACE)) {
            std.log.debug("Space Held!", .{});
        }
    }
};
