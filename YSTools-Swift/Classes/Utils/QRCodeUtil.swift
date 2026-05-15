//
//  QRCodeUtil.swift
//  YSTools-Swift
//
//  Created by Joseph Koh on 2019/7/4.
//  Copyright © 2019 Joseph Koh. All rights reserved.
//

import UIKit

public enum QRCodeUtil {
    public static func createQRForString(qrString: String?, logoImageName: String?) -> UIImage? {
        guard let qrString else {
            return nil
        }

        guard let stringData = qrString.data(using: .utf8, allowLossyConversion: false) else {
            return nil
        }
        // 创建一个二维码的滤镜
        guard let qrFilter = CIFilter(name: "CIQRCodeGenerator") else { return nil }
        qrFilter.setValue(stringData, forKey: "inputMessage")
        qrFilter.setValue("Q", forKey: "inputCorrectionLevel") // L、M、Q、H 纠正模式，分别代表了7%、15%、25%、30%的错误恢复能力。
        let outputImage = qrFilter.outputImage

        // 创建一个颜色滤镜,黑白色
        guard let colorFilter = CIFilter(name: "CIFalseColor") else { return nil }
        colorFilter.setDefaults()
        colorFilter.setValue(outputImage, forKey: "inputImage")
        colorFilter.setValue(CIColor(red: 0, green: 0, blue: 0), forKey: "inputColor0")
        colorFilter.setValue(CIColor(red: 1, green: 1, blue: 1), forKey: "inputColor1")

        // 返回 CG-backed image so downstream JPEG/PNG encoding behaves consistently.
        guard let coloredImage = colorFilter.outputImage?.transformed(by: CGAffineTransform(scaleX: 5, y: 5)) else {
            return nil
        }
        let extent = coloredImage.extent.integral
        let context = CIContext(options: nil)
        guard let cgImage = context.createCGImage(coloredImage, from: extent) else {
            return nil
        }
        let codeImage = UIImage(cgImage: cgImage)

        // 通常,二维码都是定制的,中间都会放想要表达意思的图片
        if let logoImageName, let iconImage = UIImage(named: logoImageName) {
            let rect = CGRect(x: 0,
                              y: 0,
                              width: codeImage.size.width,
                              height: codeImage.size.height)
            let renderer = UIGraphicsImageRenderer(size: rect.size)
            return renderer.image { _ in
                codeImage.draw(in: rect)
                let avatarSize = CGSize(width: rect.size.width * 0.25,
                                        height: rect.size.height * 0.25)
                let x = (rect.width - avatarSize.width) * 0.5
                let y = (rect.height - avatarSize.height) * 0.5
                iconImage.draw(in: CGRect(x: x,
                                          y: y,
                                          width: avatarSize.width,
                                          height: avatarSize.height))
            }
        }

        return codeImage
    }
}
