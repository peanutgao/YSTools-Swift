//
//  UITextField+Extension.swift
//  SCDoctor
//
//  Created by Joseph Koh on 2019/6/26.
//  Copyright © 2019 Joseph Koh. All rights reserved.
//

import UIKit

public extension UISearchBar {
    
    public func getTextField() -> UITextField? { return value(forKey: "searchField") as? UITextField }
    
    public func setClearButton(color: UIColor) {
        getTextField()?.setClearButton(color: color)
    }
}

public extension UITextField {
    
//    var clearButton: UIButton? {
//        return value(forKey: "clearButton") as? UIButton
//    }
//
//    var clearButtonTintColor: UIColor? {
//        get {
//            return clearButton?.tintColor
//        }
//        set {
//            let image =  clearButton?.imageView?.image?.withRenderingMode(.alwaysTemplate)
//            clearButton?.setImage(image, for: .normal)
//            clearButton?.tintColor = newValue
//        }
//    }
    private class ClearButtonImage {
        static private var _image: UIImage?
        static private var semaphore = DispatchSemaphore(value: 1)
        static func getImage(closure: @escaping (UIImage?)->()) {
            DispatchQueue.global(qos: .userInteractive).async {
                semaphore.wait()
                DispatchQueue.main.async {
                    if let image = _image { closure(image); semaphore.signal(); return }
                    guard let window = UIApplication.shared.windows.first else { semaphore.signal(); return }
                    let searchBar = UISearchBar(frame: CGRect(x: 0, y: -200, width: UIScreen.main.bounds.width, height: 44))
                    window.rootViewController?.view.addSubview(searchBar)
                    searchBar.text = "txt"
                    searchBar.layoutIfNeeded()
                    _image = searchBar.getTextField()?.getClearButton()?.image(for: .normal)
                    closure(_image)
                    searchBar.removeFromSuperview()
                    semaphore.signal()
                }
            }
        }
    }
    
    func setClearButton(color: UIColor) {
        ClearButtonImage.getImage { [weak self] image in
            guard   let image = image,
                let button = self?.getClearButton() else { return }
            button.imageView?.tintColor = color
            button.setImage(image.withRenderingMode(.alwaysTemplate), for: .normal)
        }
    }
    
    func getClearButton() -> UIButton? { return value(forKey: "clearButton") as? UIButton }
}
