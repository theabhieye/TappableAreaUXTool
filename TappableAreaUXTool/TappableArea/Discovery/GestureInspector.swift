//
//  GestureInspector.swift
//  TappableAreaUXTool
//
//  Created by Abhishek kapoor on 04/01/26.
//

import UIKit

protocol GestureInspecting {
    func isTappable(view: UIView) -> Bool
}

final class GestureInspector: GestureInspecting {
    func isTappable(view: UIView) -> Bool {
        guard view.isUserInteractionEnabled,
              !view.isHidden,
              view.alpha > 0.01
        else {
            return false
        }
        guard let gesture = view.gestureRecognizers,
              gesture.isEmpty == false else {
                  return false
              }
        return true
    }
}
