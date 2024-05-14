//
// *************************************************
// Created by Joseph Koh on 2024/5/13.
// Author: Joseph Koh
// Create Time: 2024/5/13 15:45
// *************************************************
//

import UIKit

public extension UIWindow {
    static var keyWindow: UIWindow? {
        UIApplication.shared.windows.filter(\.isKeyWindow).first
    }

    static var topMostWindow: UIWindow? {
        UIApplication.shared.windows.first
    }

    static var topMostViewController: UIViewController? {
        guard let rootViewController = UIApplication.shared.windows.filter(\.isKeyWindow).first?.rootViewController
        else {
            return nil
        }
        return rootViewController.topMostViewController
    }
}
