const std = @import("std");
const Raylib = @import("../cimport/raylib.zig").Raylib;

pub const ScreenPositions = enum {
    TopCentre,
    BottomCentre,
    TopLeft, 
    TopRight,
    BottomLeft,
    BottomRight,
};

const Dimensions = struct {
    width: c_int = undefined,
    height: c_int = undefined,
};

pub const TextRendering = struct {
    pub fn drawTextToFixedPosition(
        text: [:0]const u8, 
        size: c_int, 
        screen_offset: c_int,
        position: ScreenPositions, 
        color: Raylib.Color) void {

        var screen_dimensions: Dimensions = .{};
        
        switch (position) {
            .BottomCentre => {
                screen_dimensions.width = @divExact(Raylib.GetScreenWidth(), 2) - @divExact(Raylib.MeasureText(text, size), 2); 
                screen_dimensions.height = Raylib.GetScreenHeight() - screen_offset;
            },
            .TopCentre => {
                screen_dimensions.width = @divExact(Raylib.GetScreenWidth(), 2) - @divExact(Raylib.MeasureText(text, size), 2);  
                screen_dimensions.height = 0 + screen_offset;
            },
            .BottomLeft => {
                screen_dimensions.width = 0 + screen_offset;
                screen_dimensions.height = Raylib.GetScreenHeight() - screen_offset;
            },
            .BottomRight => {
                screen_dimensions.width = Raylib.GetScreenWidth() - (Raylib.MeasureText(text, size) + screen_offset);
                screen_dimensions.height = Raylib.GetScreenHeight() - screen_offset;
            },
            .TopLeft => {
                screen_dimensions.width = 0 + screen_offset;
                screen_dimensions.height = 0 + screen_offset;
            },
            .TopRight => {
                screen_dimensions.width = Raylib.GetScreenWidth() - (Raylib.MeasureText(text, size) + screen_offset);
                screen_dimensions.height = screen_offset;
            },
        }
        Raylib.DrawText(text, screen_dimensions.width, screen_dimensions.height, size, color);
    }
};
