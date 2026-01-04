//
//  TapAreaOverlayViewModel.swift
//  TappableAreaUXTool
//
//  Created by Abhishek kapoor on 04/01/26.
//

import UIKit

struct TapAreaBorder {
    let frame: CGRect
    let color: UIColor
}

final class TapAreaOverlayViewModel {
    func makeBorder(
        from targets: [TapTarget]
    ) -> [TapAreaBorder] {
        targets.map {
            TapAreaBorder(
                frame: $0.frame,
                color: $0.isValid ?
                TapAreaConstants.validBorderColor :
                TapAreaConstants.invalidBorderColor
            )
        }
    }
}
