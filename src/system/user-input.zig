const Raylib = @import("../cimport/raylib.zig").Raylib;
const std = @import("std");

pub fn testForPressedKey(key: c_uint) bool {
   if (Raylib.IsKeyDown(@intCast(key))) {
       std.log.debug("Pressed!", .{});
       return true;
   } 
   return false;
}
