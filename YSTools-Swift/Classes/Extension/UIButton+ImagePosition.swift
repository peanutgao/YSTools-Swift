//
//  UIButton+ImagePosition.swift
//  YSTools-Swift
//
//  Created by Joseph Koh on 2019/5/9.
//  Copyright © 2019 Joseph Koh. All rights reserved.
//

import ObjectiveC
import UIKit

// MARK: - UIButton.ImagePositionType

extension UIButton {
  public enum ImagePositionType: Int {
    case left
    case right
    case top
    case bottom
  }
}

extension UIButton {
  @discardableResult
  public func ys_setImagePosition(_ position: ImagePositionType, withMargin margin: CGFloat) -> Self
  {
    UIButton.ys_swizzleLayoutIfNeeded()
    ys_positionRaw = position.rawValue
    ys_margin = margin
    setNeedsLayout()
    ys_applyImagePositionIfNeeded()
    return self
  }
}

extension UIButton {
  fileprivate func ys_currentTextSize() -> CGSize {
    if let label = titleLabel {
      let size = label.intrinsicContentSize
      if size.width.isFinite, size.height.isFinite {
        return CGSize(width: ceil(size.width), height: ceil(size.height))
      }
    }
    return .zero
  }
}

// MARK: - 关联属性 & 动态布局

private var ysPositionKey: UInt8 = 0
private var ysMarginKey: UInt8 = 0
private var ysDidSwizzleKey: UInt8 = 0

extension UIButton {
  fileprivate var ys_positionRaw: Int? {
    get { objc_getAssociatedObject(self, &ysPositionKey) as? Int }
    set {
      objc_setAssociatedObject(self, &ysPositionKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
  }
  fileprivate var ys_margin: CGFloat {
    get { (objc_getAssociatedObject(self, &ysMarginKey) as? CGFloat) ?? 0 }
    set {
      objc_setAssociatedObject(self, &ysMarginKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
  }

  fileprivate static func ys_swizzleLayoutIfNeeded() {
    let did = objc_getAssociatedObject(self, &ysDidSwizzleKey) as? Bool ?? false
    guard !did else { return }
    guard
      let original = class_getInstanceMethod(UIButton.self, #selector(UIButton.layoutSubviews)),
      let swizzled = class_getInstanceMethod(UIButton.self, #selector(UIButton.ys_layoutSubviews))
    else { return }
    method_exchangeImplementations(original, swizzled)
    objc_setAssociatedObject(self, &ysDidSwizzleKey, true, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
  }

  @objc fileprivate func ys_layoutSubviews() {
    ys_layoutSubviews()
    ys_applyImagePositionIfNeeded()
  }

  fileprivate func ys_applyImagePositionIfNeeded() {
    guard let raw = ys_positionRaw, let position = ImagePositionType(rawValue: raw) else { return }
    let margin = ys_margin

    let imageWidth = imageView?.image?.size.width ?? 0
    let imageHeight = imageView?.image?.size.height ?? 0
    let textSize = ys_currentTextSize()
    let labelWidth = textSize.width
    let labelHeight = textSize.height

    if imageWidth == 0, imageHeight == 0, labelWidth == 0, labelHeight == 0 { return }

    let imageOffsetX = (imageWidth + labelWidth) * 0.5 - imageWidth * 0.5
    let imageOffsetY = imageHeight * 0.5 + margin * 0.5
    let labelOffsetX = (imageWidth + labelWidth * 0.5) - (imageWidth + labelWidth) * 0.5
    let labelOffsetY = labelHeight * 0.5 + margin * 0.5

    let tempWidth = max(labelWidth, imageWidth)
    let changedWidth = labelWidth + imageWidth - tempWidth
    let tempHeight = max(labelHeight, imageHeight)
    let changedHeight = labelHeight + imageHeight + margin - tempHeight

    switch position {
    case .left:
      self.imageEdgeInsets = UIEdgeInsets(
        top: 0, left: -margin * 0.5, bottom: 0, right: margin * 0.5)
      self.titleEdgeInsets = UIEdgeInsets(
        top: 0, left: margin * 0.5, bottom: 0, right: -margin * 0.5)
      self.contentEdgeInsets = UIEdgeInsets(
        top: 0, left: margin * 0.5, bottom: 0, right: margin * 0.5)

    case .right:
      self.imageEdgeInsets = UIEdgeInsets(
        top: 0,
        left: labelWidth + margin * 0.5,
        bottom: 0,
        right: -(labelWidth + margin * 0.5)
      )
      self.titleEdgeInsets = UIEdgeInsets(
        top: 0,
        left: -(imageWidth + margin * 0.5),
        bottom: 0,
        right: imageWidth + margin * 0.5
      )
      self.contentEdgeInsets = UIEdgeInsets(
        top: 0, left: margin * 0.5, bottom: 0, right: margin * 0.5)

    case .top:
      self.imageEdgeInsets = UIEdgeInsets(
        top: -imageOffsetY,
        left: imageOffsetX,
        bottom: imageOffsetY,
        right: -imageOffsetX
      )
      self.titleEdgeInsets = UIEdgeInsets(
        top: labelOffsetY,
        left: -labelOffsetX,
        bottom: -labelOffsetY,
        right: labelOffsetX
      )
      self.contentEdgeInsets = UIEdgeInsets(
        top: imageOffsetY,
        left: -changedWidth * 0.5,
        bottom: changedHeight - imageOffsetY,
        right: -changedWidth * 0.5
      )

    case .bottom:
      self.imageEdgeInsets = UIEdgeInsets(
        top: imageOffsetY,
        left: imageOffsetX,
        bottom: -imageOffsetY,
        right: -imageOffsetX
      )
      self.titleEdgeInsets = UIEdgeInsets(
        top: -labelOffsetY,
        left: -labelOffsetX,
        bottom: labelOffsetY,
        right: labelOffsetX
      )
      self.contentEdgeInsets = UIEdgeInsets(
        top: changedHeight - imageOffsetY,
        left: -changedWidth * 0.5,
        bottom: imageOffsetY,
        right: -changedWidth * 0.5
      )
    }
  }
}
