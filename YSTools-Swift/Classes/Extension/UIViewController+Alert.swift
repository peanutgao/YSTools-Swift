//
//  UIViewController+Alert.swift
//  YSTools-Swift
//
//  Created by Joseph Koh on 2025/12/16.
//

import UIKit

public extension UIViewController {
    
    /// Shows a simple alert with a title, message, and an OK button.
    /// - Parameters:
    ///   - title: The title of the alert.
    ///   - message: The message of the alert.
    ///   - buttonTitle: The title of the button (default is "OK").
    ///   - handler: Closure to execute when the button is tapped.
    func showAlert(title: String?, message: String?, buttonTitle: String = "OK", handler: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: buttonTitle, style: .default) { _ in
            handler?()
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    /// Shows an alert with a title, message, and two buttons (Confirm/Cancel).
    /// - Parameters:
    ///   - title: The title of the alert.
    ///   - message: The message of the alert.
    ///   - confirmTitle: The title of the confirm button (default is "Confirm").
    ///   - cancelTitle: The title of the cancel button (default is "Cancel").
    ///   - confirmHandler: Closure to execute when the confirm button is tapped.
    ///   - cancelHandler: Closure to execute when the cancel button is tapped.
    func showConfirmAlert(title: String?,
                          message: String?,
                          confirmTitle: String = "Confirm",
                          cancelTitle: String = "Cancel",
                          confirmHandler: (() -> Void)? = nil,
                          cancelHandler: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: confirmTitle, style: .default) { _ in
            confirmHandler?()
        }
        
        let cancelAction = UIAlertAction(title: cancelTitle, style: .cancel) { _ in
            cancelHandler?()
        }
        
        alert.addAction(cancelAction)
        alert.addAction(confirmAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    /// Shows an action sheet with multiple actions.
    /// - Parameters:
    ///   - title: The title of the action sheet.
    ///   - message: The message of the action sheet.
    ///   - actions: An array of tuples containing the title and handler for each action.
    ///   - cancelTitle: The title of the cancel button (default is "Cancel").
    func showActionSheet(title: String?,
                         message: String?,
                         actions: [(title: String, style: UIAlertAction.Style, handler: (() -> Void)?)],
                         cancelTitle: String = "Cancel") {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        
        for actionData in actions {
            let action = UIAlertAction(title: actionData.title, style: actionData.style) { _ in
                actionData.handler?()
            }
            alert.addAction(action)
        }
        
        let cancelAction = UIAlertAction(title: cancelTitle, style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        
        // iPad support
        if let popoverController = alert.popoverPresentationController {
            popoverController.sourceView = self.view
            popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
        }
        
        present(alert, animated: true, completion: nil)
    }
}
