//
// Created by Joseph Koh on 2023/10/26.
//

import UIKit

extension UIImageView {
    /// Aspect ratio of the image
    var imageAspectRatio: CGFloat {
        if let image {
            return image.size.height / image.size.width
        }
        return 1.0
    }
}
