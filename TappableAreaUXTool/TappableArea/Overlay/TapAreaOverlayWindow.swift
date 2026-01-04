//
//  TapAreaOverlayWindow.swift
//  TappableAreaUXTool
//
//  Created by Abhishek kapoor on 04/01/26.
//

import UIKit

final class TapAreaOverlayWindow: UIWindow {
    
    let renderer: TapAreaRenderer

    override init(windowScene: UIWindowScene) {
        let root = TapAreaOverlayRootViewController()
        self.renderer = TapAreaRenderer(containerView: root.view)
        
        super.init(windowScene: windowScene)
        
        backgroundColor = .clear
        windowLevel = .alert + 1
        isHidden = false
        rootViewController = root
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
          guard let rootView = rootViewController?.view else {
              return nil
          }
 
          let convertedPoint = rootView.convert(point, from: self)
 
          let hitView = rootView.hitTest(convertedPoint, with: event)

          if hitView is DebugTappableButton  {
              return hitView
          }

          return nil
      }
}
