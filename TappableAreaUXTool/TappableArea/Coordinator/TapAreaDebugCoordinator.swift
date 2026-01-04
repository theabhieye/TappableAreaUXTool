//
//  TapAreaDebugCoordinator.swift
//  TappableAreaUXTool
//
//  Created by Abhishek kapoor on 04/01/26.
//

import Foundation
import UIKit

final class TapAreaDebugCoordinator {
    private let tapTargetDiscoverer: TapTargetDiscovering
    private let windowProvider: WindowProviding
    
    private var renderer: TapAreaRendering?
    private var overlayWindow: TapAreaOverlayWindow?
    private var isRunning = false
//    private let refiner = TapTargetRefiner()
    private let accessibilityScanner = AccessibilityTapTargetScanner()

    init(tapTargetDiscoverer: TapTargetDiscovering = SwiftUITapTargetScanner(),
         windowProvider: WindowProviding = UIKitWindowProvider()
    ) {
        self.tapTargetDiscoverer = tapTargetDiscoverer
        self.windowProvider = windowProvider
    }
    
    func start() {
        guard !isRunning else { return }
        isRunning = true
        setupOverlay()
        refresh()
    }
    
    func stop() {
        guard isRunning else { return }
        isRunning = false
        renderer?.clear()
        renderer = nil
        
        overlayWindow?.isHidden = true
        overlayWindow = nil
    }
    
    private func refresh() {
        guard isRunning else { return }
//        let rawTargets = tapTargetDiscoverer.discoverTapTargets()
//        let refinedTargets = refiner.refine(targets: rawTargets)
//
//        renderer?.render(targets: refinedTargets)
        
        guard
            isRunning,
            let window = windowProvider.keyWindow()
        else { return }

        // 1️⃣ Accessibility targets (highest confidence)
        let accessibilityTargets =
            accessibilityScanner.discover(in: window)

        // 2️⃣ UIKit fallback targets
        let uiKitTargets =
            tapTargetDiscoverer.discoverTapTargets()

        // 3️⃣ Merge (Accessibility wins)
        let finalTargets =
            accessibilityTargets.isEmpty
                ? uiKitTargets
                : accessibilityTargets

        renderer?.render(targets: finalTargets)


    }
    
    private func setupOverlay() {
        guard let windowScene = windowProvider
            .keyWindow()?
            .windowScene else {
            return
        }
        
        let overlay = TapAreaOverlayWindow(windowScene: windowScene)

        self.renderer = overlay.renderer

        if let root = overlay.rootViewController as? TapAreaOverlayRootViewController {
            root.onRefreshTapped = { [weak self] in
                // First removing then again again so we get top of root always
                self?.stop()
                self?.start()
            }
            
            root.onCloseTapped = {
                TapAreaDebug.disable()
            }
        }
        overlayWindow = overlay
    }
}
