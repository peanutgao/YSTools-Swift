//
//  String+Class.swift
//  YSTools-Swift
//
//  Created by Joseph Koh on 2019/4/29.
//  Copyright © 2019 Joseph Koh. All rights reserved.
//

import UIKit

extension String {
    public func size(
        font: UIFont,
        size: CGSize = CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
    ) -> CGSize {
        return self.size(attributes: [NSAttributedString.Key.font: font], size: size)
    }
    
    
    public func size(attributes: [NSAttributedString.Key : Any]? = nil,
                           size: CGSize = CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)) -> CGSize {

        let size = self.boundingRect(with: size,
                                    options: .usesLineFragmentOrigin,
                                    attributes: attributes,
                                    context: nil).size
        return CGSize(width: ceil(Double(size.width)), height: ceil(Double(size.height)))
    }
}
