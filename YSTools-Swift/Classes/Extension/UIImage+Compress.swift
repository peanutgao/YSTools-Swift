//
// *************************************************
// Created by Joseph Koh on 2023/11/27.
// Author: Joseph Koh
// Email: Joseph0750@gmail.com
// Create Date: 2023/11/27 16:30
// *************************************************
//

import UIKit

public extension UIImage {
    func compress(to maxLength: Int = 300 * 1024) -> Data? {
        // Compression by quality
        var compression: CGFloat = 1
        let data = jpegData(compressionQuality: compression)
        guard var imageData = data, imageData.count > maxLength else {
            return data
        }

        // Adjusting quality to compress image
        var max: CGFloat = 1
        var min: CGFloat = 0
        for _ in 0 ..< 6 {
            compression = (max + min) / 2
            imageData = jpegData(compressionQuality: compression)!
            if imageData.count < Int(Double(maxLength) * 0.9) {
                min = compression
            } else if imageData.count > maxLength {
                max = compression
            } else {
                break
            }
        }

        // If still above the limit after adjusting quality, adjust the size
        var resultImage = UIImage(data: imageData)!
        var lastDataLength = 0
        while imageData.count > maxLength, imageData.count != lastDataLength {
            lastDataLength = imageData.count
            let ratio = CGFloat(maxLength) / CGFloat(imageData.count)
            let size = CGSize(width: resultImage.size.width * sqrt(ratio),
                              height: resultImage.size.height * sqrt(ratio))

            UIGraphicsBeginImageContext(size)
            resultImage.draw(in: CGRect(origin: .zero, size: size))
            resultImage = UIGraphicsGetImageFromCurrentImageContext() ?? resultImage
            UIGraphicsEndImageContext()
            imageData = resultImage.jpegData(compressionQuality: compression)!
        }

        return imageData
    }
}
