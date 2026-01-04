//
//  TapAreaDebug.swift
//  TappableAreaUXTool
//
//  Created by Abhishek kapoor on 04/01/26.
//

import Foundation

public enum TapAreaDebug {
    private static var coordinator: TapAreaDebugCoordinator?
    
    public static func enable() {
        guard coordinator == nil else { return }
        let coordinator = TapAreaDebugCoordinator()
        coordinator.start()
        self.coordinator = coordinator
    }
    
    public static func disable() {
        coordinator?.stop()
        coordinator = nil
    }
}
