//
// *************************************************
// Created by Joseph Koh on 2023/12/8.
// Author: Joseph Koh
// Email: Joseph0750@gmail.com
// Create Time: 2023/12/8 14:20
// *************************************************
//

import UIKit

public extension UIViewController {
    func removeSelfFromNavigationStack() {
        if let navigationStack = navigationController?.viewControllers,
           let index = navigationStack.firstIndex(of: self)
        {
            var newStack = navigationStack
            newStack.remove(at: index)
            navigationController?.setViewControllers(newStack, animated: false)
        }
    }
}
