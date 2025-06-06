//
// *************************************************
// Created by Joseph Koh on 2023/12/8.
// Author: Joseph Koh
// Email: Joseph0750@gmail.com
// Create Date: 2023/12/8 14:20
// *************************************************
//

import UIKit

public extension UIViewController {
    func removeSelfFromNavigationStack() {
        if let navigationStack = navigationController?.viewControllers,
           let index = navigationStack.firstIndex(of: self) {
            var newStack = navigationStack
            newStack.remove(at: index)
            navigationController?.setViewControllers(newStack, animated: false)
        }
    }
    
    func pushAndRemoveSelf(_ viewController: UIViewController, animated: Bool = true) {
        guard let navigationController = self.navigationController else {
            return
        }
        var viewControllers = navigationController.viewControllers
        viewControllers.removeAll { $0 === self }
        viewControllers.append(viewController)
        navigationController.setViewControllers(viewControllers, animated: animated)
    }

}
