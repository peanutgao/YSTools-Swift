//
//  QRCodeUtil.swift
//  YSTools-Swift
//
//  Created by Joseph Koh on 2019/7/4.
//  Copyright © 2019 Joseph Koh. All rights reserved.
//

import UIKit

class QRCodeUtil {
    
    public static func createQRForString(qrString: String?, logoImageName: String?) -> UIImage? {
        guard let qrString = qrString  else {
            return nil
        }
        
        let stringData = qrString.data(using: .utf8, allowLossyConversion: false)
        // 创建一个二维码的滤镜
        let qrFilter = CIFilter(name: "CIQRCodeGenerator")!
        qrFilter.setValue(stringData, forKey: "inputMessage")
        qrFilter.setValue("Q", forKey: "inputCorrectionLevel")   // L、M、Q、H 纠正模式，分别代表了7%、15%、25%、30%的错误恢复能力。
        let outputImage = qrFilter.outputImage
        
        // 创建一个颜色滤镜,黑白色
        let colorFilter = CIFilter(name: "CIFalseColor")!
        colorFilter.setDefaults()
        colorFilter.setValue(outputImage, forKey: "inputImage")
        colorFilter.setValue(CIColor(red: 0, green: 0, blue: 0), forKey: "inputColor0")
        colorFilter.setValue(CIColor(red: 1, green: 1, blue: 1), forKey: "inputColor1")
        
        // 返回二维码image
        let codeImage = UIImage(ciImage: colorFilter.outputImage!.transformed(by: CGAffineTransform(scaleX: 5, y: 5)))
        
        // 通常,二维码都是定制的,中间都会放想要表达意思的图片
        if let logoImageName = logoImageName, let iconImage = UIImage(named: logoImageName) {
            let rect = CGRect(x:0,
                              y:0,
                              width:codeImage.size.width,
                              height:codeImage.size.height)
            UIGraphicsBeginImageContext(rect.size)
            
            codeImage.draw(in: rect)
            let avatarSize = CGSize(width:rect.size.width * 0.25,
                                    height:rect.size.height * 0.25)
            let x = (rect.width - avatarSize.width) * 0.5
            let y = (rect.height - avatarSize.height) * 0.5
            iconImage.draw(in: CGRect(x:x,
                                      y:y,
                                      width:avatarSize.width,
                                      height:avatarSize.height))
            let resultImage = UIGraphicsGetImageFromCurrentImageContext()
            
            UIGraphicsEndImageContext()
            
            return resultImage
        }
        
        return codeImage
    }
    
}

