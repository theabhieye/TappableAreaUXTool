//
//  TapTarget.swift
//  TappableAreaUXTool
//
//  Created by Abhishek kapoor on 04/01/26.
//

import UIKit

//public struct TapTarget: Equatable {
//    public let frame: CGRect
//    public let isValid: Bool
//    public let sourceView: UIView?
//
//    
//    public init(frame: CGRect, isValid: Bool, sourceView: UIView?) {
//        self.frame = frame
//        self.isValid = isValid
//        self.sourceView = sourceView
//    }
//}

enum TapTargetSource {
    case accessibility
    case uiKit
}

struct TapTarget {
    let frame: CGRect
    let isValid: Bool
    let source: TapTargetSource
    let label: String?
}
