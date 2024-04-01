//
// *************************************************
// Created by Joseph Koh on 2023/11/22.
// Author: Joseph Koh
// Email: Joseph0750@gmail.com
// Create Date: 2023/11/22 00:58
// *************************************************
//

import UIKit

extension UIImage {
    static func image(withColor color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) -> UIImage? {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
