const Raylib = @import("../cimport/raylib.zig").Raylib;

pub const Audio = struct {
    sample_rate: c_uint = 44100,
    sample_size: c_uint = 16,
    channels: c_uint = 1,

    pub fn init() void {
        Raylib.InitAudioDevice();
    }
    pub fn loadAudioStream(self: *Audio) Raylib.AudioStream {
        return Raylib.LoadAudioStream(self.sample_rate, self.sample_size, self.channels);
    }
};
