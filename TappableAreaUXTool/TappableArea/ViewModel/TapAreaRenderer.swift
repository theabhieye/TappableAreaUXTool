//
//  TapAreaRenderer.swift
//  TappableAreaUXTool
//
//  Created by Abhishek kapoor on 04/01/26.
//

import UIKit

final class TapAreaRenderer: TapAreaRendering {
 
    private weak var containerView: UIView?
    private var boarderLayers: [CAShapeLayer] = []
    
    init(containerView: UIView) {
        self.containerView = containerView
    }
    
    func render(targets: [TapTarget]) {
        clear()
        let viewModel = TapAreaOverlayViewModel()
        let borders = viewModel.makeBorder(from: targets)
        
        borders.forEach { border in
            let layer = CAShapeLayer()
            layer.frame = border.frame
            layer.path = UIBezierPath(rect: layer.bounds).cgPath
            layer.strokeColor = border.color.cgColor
            
            layer.fillColor = UIColor.clear.cgColor
            layer.lineWidth = TapAreaConstants.boarderWidth
            
            containerView?.layer.addSublayer(layer)
            boarderLayers.append(layer)
        }
    }
    
    func clear() {
        boarderLayers.forEach { $0.removeFromSuperlayer() }
        boarderLayers.removeAll()
    }
    
}
