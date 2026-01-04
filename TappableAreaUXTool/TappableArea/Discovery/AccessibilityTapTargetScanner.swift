//
//  AccessibilityTapTargetScanner.swift
//  TappableAreaUXTool
//
//  Created by Abhishek kapoor on 04/01/26.
//


import UIKit


final class AccessibilityTapTargetScanner {

    func discover(in window: UIWindow) -> [TapTarget] {
        let elements = collectElements(from: window)
        return elements.compactMap(makeTapTarget)
    }

    // MARK: - Traversal

    private func collectElements(from root: Any) -> [UIAccessibilityElement] {
        var result: [UIAccessibilityElement] = []

        if let element = root as? UIAccessibilityElement,
           element.isAccessibilityElement {
            result.append(element)
        }

        if let container = root as? NSObject,
           container.responds(to: #selector(NSObject.accessibilityElementCount)) {
            let count = container.accessibilityElementCount()
            for index in 0..<count {
                if let child = container.accessibilityElement(at: index) {
                    result.append(contentsOf: collectElements(from: child))
                }
            }
        }

        return result
    }

    // MARK: - Mapping

    private func makeTapTarget(from element: UIAccessibilityElement) -> TapTarget? {
        let frame = element.accessibilityFrame

        guard frame.width > 0, frame.height > 0 else { return nil }
        guard isInteractive(element) else { return nil }

        let isValid =
            frame.width >= TapAreaConstants.minimumTapSize.width &&
            frame.height >= TapAreaConstants.minimumTapSize.height

        return TapTarget(
            frame: frame,
            isValid: isValid,
            source: .accessibility,
            label: element.accessibilityLabel
        )
    }

    private func isInteractive(_ element: UIAccessibilityElement) -> Bool {
        let traits = element.accessibilityTraits
        return traits.contains(.button)
            || traits.contains(.link)
            || traits.contains(.header)
    }
}
