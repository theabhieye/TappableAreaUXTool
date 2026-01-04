//
//  SwiftUITapTargetScanner.swift
//  TappableAreaUXTool
//
//  Created by Abhishek kapoor on 04/01/26.
//

import UIKit

final class SwiftUITapTargetScanner: TapTargetDiscovering {
    
    private let windowProvider: WindowProviding
    private let gestureInspector: GestureInspecting
    
    init(windowProvider: WindowProviding = UIKitWindowProvider(),
         gestureInspector: GestureInspecting = GestureInspector()) {
        self.windowProvider = windowProvider
        self.gestureInspector = gestureInspector
    }
    
    func discoverTapTargets() -> [TapTarget] {
        guard let window = windowProvider.keyWindow(),
              let rootView = window.rootViewController?.view
        else {
            return []
        }
        var result: [TapTarget] = []
        
        ViewTraversal.traverse(view: rootView) { view in
            guard gestureInspector.isTappable(view: view) else {
                return
            }
            let frameInWindow = view.convert(view.bounds,
                                             to: window)
            
            let minimumSize = TapAreaConstants.minimumTapSize
            
            let isValid = frameInWindow.width >= minimumSize.width &&
            frameInWindow.height >= minimumSize.height
            
            result.append(
                
                TapTarget(frame: frameInWindow,
                          isValid: isValid, source: .uiKit,
                          label: "Test")
            )
        }
        
        return result
    }
}
