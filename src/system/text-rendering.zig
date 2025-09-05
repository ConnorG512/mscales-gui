const std = @import("std");
const Raylib = @import("../cimport/raylib.zig").Raylib;

const Vector2 = @import("../util/vector2.zig");

pub const ScreenPositions = enum {
    TopCentre,
    BottomCentre,
    TopLeft, 
    TopRight,
    BottomLeft,
    BottomRight,
};

pub const TextRendering = struct {
    pub fn drawTextToFixedPosition(
        text: [:0]const u8, 
        size: c_int, 
        screen_offset: c_int,
        position: ScreenPositions, 
        color: Raylib.Color) void {

        var screen_dimensions: Vector2.vectorTwo(c_int) = .{ .x = 0, .y = 0 }; 
        
        switch (position) {
            .BottomCentre => {
                screen_dimensions.x = @divExact(Raylib.GetScreenWidth(), 2) - @divExact(Raylib.MeasureText(text, size), 2); 
                screen_dimensions.y = Raylib.GetScreenHeight() - screen_offset;
            },
            .TopCentre => {
                screen_dimensions.x = @divExact(Raylib.GetScreenWidth(), 2) - @divExact(Raylib.MeasureText(text, size), 2);  
                screen_dimensions.y = 0 + screen_offset;
            },
            .BottomLeft => {
                screen_dimensions.x = 0 + screen_offset;
                screen_dimensions.y = Raylib.GetScreenHeight() - screen_offset;
            },
            .BottomRight => {
                screen_dimensions.x = Raylib.GetScreenWidth() - (Raylib.MeasureText(text, size) + screen_offset);
                screen_dimensions.y = Raylib.GetScreenHeight() - screen_offset;
            },
            .TopLeft => {
                screen_dimensions.x = 0 + screen_offset;
                screen_dimensions.y = 0 + screen_offset;
            },
            .TopRight => {
                screen_dimensions.x = Raylib.GetScreenWidth() - (Raylib.MeasureText(text, size) + screen_offset);
                screen_dimensions.y = screen_offset;
            },
        }
        Raylib.DrawText(text, screen_dimensions.x, screen_dimensions.y, size, color);
    }
};
