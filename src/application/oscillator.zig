const Audio = @import("../system/audio.zig").Audio;

pub const Oscillator = struct {
    current_frequency: f32 = 440.0,

    pub fn generateSound(self: *Oscillator, audio_manager: *Audio) void {
        
        const frequency: f32 = 440.0;
        self.current_frequency = frequency + ( self.current_frequency + frequency ) * 0.95;

        const incr = self.current_frequency / audio_manager.*.sample_rate;

    }
};
