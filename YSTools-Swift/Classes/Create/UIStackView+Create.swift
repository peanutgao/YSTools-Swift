//
// *************************************************
// Created by Joseph Koh on 2024/4/1.
// Author: Joseph Koh
// Create Time: 2024/4/1 13:02
// *************************************************
//

import UIKit

// MARK: - UIStackViewCreateProtocol

public protocol UIStackViewCreateProtocol {}

public extension UIStackViewCreateProtocol where Self: UIStackView {
    /// 设置轴向 (水平/垂直)
    @discardableResult
    func ys_axis(_ axis: NSLayoutConstraint.Axis) -> Self {
        self.axis = axis
        return self
    }

    /// 设置分布方式
    @discardableResult
    func ys_distribution(_ distribution: UIStackView.Distribution) -> Self {
        self.distribution = distribution
        return self
    }

    /// 设置对齐方式
    @discardableResult
    func ys_alignment(_ alignment: UIStackView.Alignment) -> Self {
        self.alignment = alignment
        return self
    }

    /// 设置子视图间距
    @discardableResult
    func ys_spacing(_ spacing: CGFloat) -> Self {
        self.spacing = spacing
        return self
    }

    /// 设置基线相对排列
    @discardableResult
    func ys_isBaselineRelativeArrangement(_ isBaselineRelativeArrangement: Bool) -> Self {
        self.isBaselineRelativeArrangement = isBaselineRelativeArrangement
        return self
    }

    /// 设置是否相对于布局边距排列
    @discardableResult
    func ys_isLayoutMarginsRelativeArrangement(_ isLayoutMarginsRelativeArrangement: Bool) -> Self {
        self.isLayoutMarginsRelativeArrangement = isLayoutMarginsRelativeArrangement
        return self
    }

    /// 设置布局边距
    @discardableResult
    func ys_layoutMargins(_ layoutMargins: UIEdgeInsets) -> Self {
        self.layoutMargins = layoutMargins
        return self
    }
    
    /// 设置布局边距 (便捷方法)
    @discardableResult
    func ys_layoutMargins(top: CGFloat = 0, left: CGFloat = 0, bottom: CGFloat = 0, right: CGFloat = 0) -> Self {
        self.layoutMargins = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
        return self
    }
    
    /// 设置布局边距 (统一值)
    @discardableResult
    func ys_layoutMargins(_ value: CGFloat) -> Self {
        self.layoutMargins = UIEdgeInsets(top: value, left: value, bottom: value, right: value)
        return self
    }

    /// 添加排列子视图
    @discardableResult
    func ys_addArrangedSubview(_ view: UIView) -> Self {
        self.addArrangedSubview(view)
        return self
    }

    /// 添加多个排列子视图
    @discardableResult
    func ys_addArrangedSubviews(_ views: [UIView]) -> Self {
        views.forEach({ addArrangedSubview($0) })
        return self
    }
    
    /// 添加多个排列子视图 (可变参数)
    @discardableResult
    func ys_addArrangedSubviews(_ views: UIView...) -> Self {
        views.forEach({ addArrangedSubview($0) })
        return self
    }
    
    /// 在指定位置插入排列子视图
    @discardableResult
    func ys_insertArrangedSubview(_ view: UIView, at index: Int) -> Self {
        self.insertArrangedSubview(view, at: index)
        return self
    }
    
    /// 移除排列子视图
    @discardableResult
    func ys_removeArrangedSubview(_ view: UIView) -> Self {
        self.removeArrangedSubview(view)
        view.removeFromSuperview()
        return self
    }
    
    /// 移除所有排列子视图
    @discardableResult
    func ys_removeAllArrangedSubviews() -> Self {
        arrangedSubviews.forEach {
            self.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }
        return self
    }
    
    /// 设置指定子视图的自定义间距 (iOS 11+)
    @available(iOS 11.0, *)
    @discardableResult
    func ys_setCustomSpacing(_ spacing: CGFloat, after arrangedSubview: UIView) -> Self {
        self.setCustomSpacing(spacing, after: arrangedSubview)
        return self
    }
    
    /// 设置所有子视图隐藏状态
    @discardableResult
    func ys_setArrangedSubviewsHidden(_ hidden: Bool) -> Self {
        arrangedSubviews.forEach { $0.isHidden = hidden }
        return self
    }
}

// MARK: - UIStackView + UIStackViewCreateProtocol

extension UIStackView: UIStackViewCreateProtocol {}