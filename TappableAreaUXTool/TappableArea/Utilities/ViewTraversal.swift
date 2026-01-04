//
//  ViewTraversal.swift
//  TappableAreaUXTool
//
//  Created by Abhishek kapoor on 04/01/26.
//

import UIKit

enum ViewTraversal {
    static func traverse(
        view: UIView,
        visit: (UIView) -> Void
    ) {
        visit(view)
        // making a recursive call for each subview
        // underline to the view
        view.subviews.forEach {
            traverse(view: $0, visit: visit)
        }
    }
}
