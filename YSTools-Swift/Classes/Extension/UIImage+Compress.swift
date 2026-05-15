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
        guard maxLength > 0 else {
            return jpegData(compressionQuality: 1)
        }

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
            guard let data = jpegData(compressionQuality: compression) else { break }
            imageData = data
            if imageData.count < Int(Double(maxLength) * 0.9) {
                min = compression
            } else if imageData.count > maxLength {
                max = compression
            } else {
                break
            }
        }

        // If still above the limit after adjusting quality, adjust the size
        guard var resultImage = UIImage(data: imageData) else { return imageData }
        var lastDataLength = 0
        while imageData.count > maxLength, imageData.count != lastDataLength {
            lastDataLength = imageData.count
            let ratio = CGFloat(maxLength) / CGFloat(imageData.count)
            let size = CGSize(width: resultImage.size.width * sqrt(ratio),
                              height: resultImage.size.height * sqrt(ratio))
            guard size.width > 0, size.height > 0, size.width.isFinite, size.height.isFinite else {
                break
            }

            let renderer = UIGraphicsImageRenderer(size: size)
            resultImage = renderer.image { _ in
                resultImage.draw(in: CGRect(origin: .zero, size: size))
            }
            guard let data = resultImage.jpegData(compressionQuality: compression) else { break }
            imageData = data
        }

        return imageData
    }

    /// Async wrapper running compress on background queue.
    /// - Important: CIImage-backed images (e.g. those returned from CIFilter,
    ///   `QRCodeUtil.createQRForString`) cannot safely be rasterised off the
    ///   main thread because the underlying CIContext / Metal pipeline is not
    ///   guaranteed thread-safe. Such inputs are rendered on the main actor
    ///   instead. CGImage-backed images go to a global background queue.
    func compressAsync(to maxLength: Int = 300 * 1024) async -> Data? {
        if cgImage == nil {
            return await MainActor.run { self.compress(to: maxLength) }
        }
        return await withCheckedContinuation { continuation in
            DispatchQueue.global(qos: .userInitiated).async {
                continuation.resume(returning: self.compress(to: maxLength))
            }
        }
    }
}
