//
//  UITextField+Ext.swift
//  YSTools-Swift
//
//  Created by Joseph Koh on 2019/6/26.
//  Copyright © 2019 Joseph Koh. All rights reserved.
//

import UIKit

// MARK: - ClearButtonImage

private enum ClearButtonImage {
    private static var _image: UIImage?
    private static var semaphore = DispatchSemaphore(value: 1)
    static func getImage(closure: @escaping (UIImage?) -> Void) {
        DispatchQueue.global(qos: .userInteractive).async {
            semaphore.wait()
            DispatchQueue.main.async {
                if let image = _image { closure(image); semaphore.signal(); return }
                guard let window = UIApplication.shared.windows.first else { semaphore.signal(); return }
                let searchBar = UISearchBar(frame: CGRect(
                    x: 0,
                    y: -200,
                    width: UIScreen.main.bounds.width,
                    height: 44
                ))
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

public extension UITextField {
    var clearButton: UIButton? {
        value(forKey: "clearButton") as? UIButton
    }

    var clearButtonTintColor: UIColor? {
        get {
            clearButton?.tintColor
        }
        set {
            let image = clearButton?.imageView?.image?.withRenderingMode(.alwaysTemplate)
            clearButton?.setImage(image, for: .normal)
            clearButton?.tintColor = newValue
        }
    }

    func setClearButton(color: UIColor) {
        ClearButtonImage.getImage { [weak self] image in
            guard let image,
                  let button = self?.getClearButton() else { return }
            button.imageView?.tintColor = color
            button.setImage(image.withRenderingMode(.alwaysTemplate), for: .normal)
        }
    }

    func getClearButton() -> UIButton? {
        value(forKey: "clearButton") as? UIButton
    }

    func setLeftView(_ view: UIView, padding: CGFloat) {
        view.translatesAutoresizingMaskIntoConstraints = true

        let outerView = UIView()
        outerView.translatesAutoresizingMaskIntoConstraints = false
        outerView.addSubview(view)

        outerView.frame = CGRect(
            origin: .zero,
            size: CGSize(
                width: view.frame.size.width + padding,
                height: view.frame.size.height + padding
            )
        )

        view.center = CGPoint(
            x: outerView.bounds.size.width / 2,
            y: outerView.bounds.size.height / 2
        )

        leftView = outerView
    }
}
