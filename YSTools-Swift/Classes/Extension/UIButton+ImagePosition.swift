//
//  UIButton+ImagePosition.swift
//  YSTools-Swift
//
//  Created by Joseph Koh on 2019/5/9.
//  Copyright © 2019 Joseph Koh. All rights reserved.
//

import UIKit

extension UIButton {
    public enum ImagePositionType: Int{
        case left
        case right
        case top
        case bottom
    }
}

extension UIButton {
    
    @discardableResult
    public func ys_setImagePosition(_ position: ImagePositionType, withMargin margin: CGFloat) -> Self {
        setTitle(currentTitle, for: .normal)
        setImage(currentImage, for: .normal)

        let imageWidth = imageView?.image?.size.width ?? 0
        let imageHeight = imageView?.image?.size.height ?? 0
        let labelWidth = self.textSize().width
        let labelHeight = self.textSize().height

        let imageOffsetX = (imageWidth + labelWidth) * 0.5 - imageWidth * 0.5
        let imageOffsetY = imageHeight * 0.5 + margin * 0.5;
        let labelOffsetX = (imageWidth + labelWidth * 0.5) - (imageWidth + labelWidth) * 0.5
        let labelOffsetY = labelHeight * 0.5 + margin * 0.5

        let tempWidth = max(labelWidth, imageWidth)
        let changedWidth = labelWidth + imageWidth - tempWidth;
        let tempHeight = max(labelHeight, imageHeight)
        let changedHeight = labelHeight + imageHeight + margin - tempHeight


        switch position {
        case .left:
            self.imageEdgeInsets = UIEdgeInsets(top: 0, left: -margin*0.5, bottom: 0, right: margin*0.5)
            self.titleEdgeInsets = UIEdgeInsets(top: 0, left: margin*0.5, bottom: 0, right: -margin*0.5)
            self.contentEdgeInsets = UIEdgeInsets(top: 0, left: margin*0.5, bottom: 0, right: margin*0.5)

        case .right:
            self.imageEdgeInsets = UIEdgeInsets(top: 0, left: labelWidth + margin*0.5, bottom: 0, right: -(labelWidth + margin*0.5))
            self.titleEdgeInsets = UIEdgeInsets(top: 0, left: -(imageWidth + margin*0.5), bottom: 0, right: imageWidth + margin*0.5)
            self.contentEdgeInsets = UIEdgeInsets(top: 0, left: margin*0.5, bottom: 0, right: margin*0.5)

        case .top:
            self.imageEdgeInsets = UIEdgeInsets(top: -imageOffsetY, left: imageOffsetX, bottom: imageOffsetY, right: -imageOffsetX)
            self.titleEdgeInsets = UIEdgeInsets(top: labelOffsetY, left: -labelOffsetX, bottom: -labelOffsetY, right: labelOffsetX)
            self.contentEdgeInsets = UIEdgeInsets(top: imageOffsetY, left: -changedWidth*0.5, bottom: changedHeight-imageOffsetY, right: -changedWidth*0.5)

        case .bottom:
            self.imageEdgeInsets = UIEdgeInsets(top: imageOffsetY, left: imageOffsetX, bottom: -imageOffsetY, right: -imageOffsetX)
            self.titleEdgeInsets = UIEdgeInsets(top: -labelOffsetY, left: -labelOffsetX, bottom: labelOffsetY, right: labelOffsetX)
            self.contentEdgeInsets = UIEdgeInsets(top: changedHeight-imageOffsetY, left: -changedWidth*0.5, bottom: imageOffsetY, right: -changedWidth*0.5)
        }
        return self
    }
}

fileprivate extension UIButton {
    func textSize() -> CGSize {
        let str = titleLabel?.text as NSString?
        let size = str?.boundingRect(with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude),
                                     options: NSStringDrawingOptions.usesLineFragmentOrigin,
                                     attributes: [.font: titleLabel?.font as Any],
                                     context: nil).size
        guard let strSize = size else {
            return CGSize.zero
        }

        return CGSize(width: ceil(strSize.width), height: ceil(strSize.height))
    }
}
