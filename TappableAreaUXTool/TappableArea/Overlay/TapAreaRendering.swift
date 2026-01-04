//
//  TapAreaRendering.swift
//  TappableAreaUXTool
//
//  Created by Abhishek kapoor on 04/01/26.
//

import Foundation

protocol TapAreaRendering: AnyObject {
    func render(targets: [TapTarget])
    func clear()
}
