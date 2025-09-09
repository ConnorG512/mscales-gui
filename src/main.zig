const Raylib = @import("cimport/raylib.zig").Raylib;
const AppManager = @import("application/app-manager.zig").AppManager;

pub fn main() !void {

    var app_manager: AppManager = undefined;
    try app_manager.initApp();
    defer app_manager.cleanupApp();
    
    while (!Raylib.WindowShouldClose()) {
        app_manager.updateApp();
    }
}

