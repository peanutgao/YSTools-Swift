//
// *************************************************
// Created by Joseph Koh on 2024/4/1.
// Author: Joseph Koh
// Create Time: 2024/4/1 13:02
// *************************************************
//

import UIKit

public protocol UIStackViewCreateProtocol {
}

public extension UIStackViewCreateProtocol where Self: UIStackView {
    @discardableResult
    func ys_axis(_ axis: NSLayoutConstraint.Axis) -> Self {
        self.axis = axis
        return self
    }

    @discardableResult
    func ys_distribution(_ distribution: UIStackView.Distribution) -> Self {
        self.distribution = distribution
        return self
    }

    @discardableResult
    func ys_alignment(_ alignment: UIStackView.Alignment) -> Self {
        self.alignment = alignment
        return self
    }

    @discardableResult
    func ys_spacing(_ spacing: CGFloat) -> Self {
        self.spacing = spacing
        return self
    }

    @discardableResult
    func ys_isBaselineRelativeArrangement(_ isBaselineRelativeArrangement: Bool) -> Self {
        self.isBaselineRelativeArrangement = isBaselineRelativeArrangement
        return self
    }

    @discardableResult
    func ys_isLayoutMarginsRelativeArrangement(_ isLayoutMarginsRelativeArrangement: Bool) -> Self {
        self.isLayoutMarginsRelativeArrangement = isLayoutMarginsRelativeArrangement
        return self
    }

    @discardableResult
    func ys_layoutMargins(_ layoutMargins: UIEdgeInsets) -> Self {
        self.layoutMargins = layoutMargins
        return self
    }

    @discardableResult
    func ys_addArrangedSubview(_ view: UIView) -> Self {
        self.addArrangedSubview(view)
        return self
    }

    @discardableResult
    func ys_addArrangedSubviews(_ views: [UIView]) -> Self {
        views.forEach({ addArrangedSubview($0) })
        return self
    }
}

extension UIStackView: UIStackViewCreateProtocol {
}