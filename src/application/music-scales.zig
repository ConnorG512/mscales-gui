pub const MusicScale = struct {
    title: [:0]const u8,
    scale_type: [:0]const u8,
    chromatic_scale: [12][]const u8,
};

const general_chromatic_scale_sharp: [12][]const u8 = .{ "C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B" };

pub const CMajor = MusicScale {
  .title = "C Major",
  .scale_type = "Major / Ionian",
  .chromatic_scale = general_chromatic_scale_sharp,
};
