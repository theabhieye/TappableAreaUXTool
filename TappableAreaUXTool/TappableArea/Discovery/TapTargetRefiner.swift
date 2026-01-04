//
//  TapTargetRefiner.swift
//  TappableAreaUXTool
//
//  Created by Abhishek kapoor on 04/01/26.
//


import UIKit

//final class TapTargetRefiner {
//
//    func refine(targets: [TapTarget]) -> [TapTarget] {
//        targets.flatMap { target in
//            guard let sourceView = target.sourceView else {
//                return [target]
//            }
//
//            let refined = extractLeafTargets(from: sourceView)
//
//            // If we found meaningful children, replace the parent
//            if refined.isEmpty == false {
//                return refined
//            }
//
//            // Otherwise keep the original target
//            return [target]
//        }
//    }
//
//    // MARK: - Private
//
//    private func extractLeafTargets(from view: UIView) -> [TapTarget] {
//        var results: [TapTarget] = []
//
//        for subview in view.subviews {
//            guard isValidVisualLeaf(subview) else { continue }
//
//            let frameInWindow = subview.convert(subview.bounds, to: nil)
//
//            let isValid =
//                frameInWindow.width >= TapAreaConstants.minimumTapSize.width &&
//                frameInWindow.height >= TapAreaConstants.minimumTapSize.height
//
//            results.append(
//                TapTarget(
//                    frame: frameInWindow,
//                    isValid: isValid,
//                    sourceView: subview
//                )
//            )
//        }
//
//        return results
//    }
//
//    private func isValidVisualLeaf(_ view: UIView) -> Bool {
//        guard
//            view.isHidden == false,
//            view.alpha > 0.01,
//            view.bounds.width >= 20,
//            view.bounds.height >= 20
//        else {
//            return false
//        }
//
//        // Ignore layout-only views
//        if view is UIStackView { return false }
//
//        // If it has visible children, it's not a leaf
//        let hasVisibleChildren = view.subviews.contains {
//            $0.isHidden == false && $0.alpha > 0.01
//        }
//
//        return hasVisibleChildren == false
//    }
//}


import UIKit

//final class TapTargetRefiner {
//
//    func refine(targets: [TapTarget]) -> [TapTarget] {
//        targets.flatMap { target in
//            guard let sourceView = target.sourceView else {
//                return [target]
//            }
//
//            // 1️⃣ Try UIKit leaf refinement
//            let leafTargets = extractLeafTargets(from: sourceView)
//            if leafTargets.isEmpty == false {
//                return leafTargets
//            }
//
//            // 2️⃣ Try text-based refinement (SwiftUI Text)
//            let textTargets = extractTextTargets(from: sourceView)
//            if textTargets.isEmpty == false {
//                return textTargets
//            }
//
//            // 3️⃣ Fallback: keep original
//            return [target]
//        }
//    }
//
//    // MARK: - UIKit leaf refinement
//
//    private func extractLeafTargets(from view: UIView) -> [TapTarget] {
//        var results: [TapTarget] = []
//
//        for subview in view.subviews {
//            guard isValidVisualLeaf(subview) else { continue }
//
//            let frameInWindow = subview.convert(subview.bounds, to: nil)
//            results.append(makeTarget(frame: frameInWindow, source: subview))
//        }
//
//        return results
//    }
//
//    private func isValidVisualLeaf(_ view: UIView) -> Bool {
//        guard
//            view.isHidden == false,
//            view.alpha > 0.01,
//            view.bounds.width >= 20,
//            view.bounds.height >= 20
//        else { return false }
//
//        if view is UIStackView { return false }
//
//        let hasVisibleChildren = view.subviews.contains {
//            $0.isHidden == false && $0.alpha > 0.01
//        }
//
//        return hasVisibleChildren == false
//    }
//
//    // MARK: - Text-based refinement (SwiftUI Text)
//
//    private func extractTextTargets(from view: UIView) -> [TapTarget] {
//        let labels = view.findSubviews(ofType: UILabel.self)
//
//        return labels.compactMap { label in
//            let frameInWindow = label.convert(label.bounds, to: nil)
//
//            guard frameInWindow.width > 0, frameInWindow.height > 0 else {
//                return nil
//            }
//
//            return makeTarget(frame: frameInWindow, source: label)
//        }
//    }
//
//    // MARK: - Helpers
//
//    private func makeTarget(frame: CGRect, source: UIView) -> TapTarget {
//        let isValid =
//            frame.width >= TapAreaConstants.minimumTapSize.width &&
//            frame.height >= TapAreaConstants.minimumTapSize.height
//
//        return TapTarget(
//            frame: frame,
//            isValid: isValid,
//            sourceView: source
//        )
//    }
//}
//
//extension UIView {
//    func findSubviews<T: UIView>(ofType type: T.Type) -> [T] {
//        var result: [T] = []
//
//        for subview in subviews {
//            if let match = subview as? T {
//                result.append(match)
//            }
//            result.append(contentsOf: subview.findSubviews(ofType: type))
//        }
//
//        return result
//    }
//}
//
