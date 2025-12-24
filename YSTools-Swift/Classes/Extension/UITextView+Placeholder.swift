//
//  UITextView+PlaceHolder.swift
//  YSTools-Swift
//
//  Created by Joseph Koh on 2025/12/16.
//

import UIKit

private var kPlaceholderStorageKey: Void?

public extension UITextView {
    
    // MARK: - Public Properties
    
    var placeholderLabel: UILabel {
        return storage.placeholderLabel
    }
    
    var placeholder: String? {
        get { placeholderLabel.text }
        set {
            placeholderLabel.text = newValue
            updatePlaceholderLabel()
        }
    }
    
    var attributedPlaceholder: NSAttributedString? {
        get { placeholderLabel.attributedText }
        set {
            placeholderLabel.attributedText = newValue
            updatePlaceholderLabel()
        }
    }
    
    var placeholderColor: UIColor? {
        get { placeholderLabel.textColor }
        set {
            placeholderLabel.textColor = newValue
        }
    }
    
    static var defaultPlaceholderColor: UIColor {
        return UIColor(red: 0, green: 0, blue: 0.0980392, alpha: 0.22)
    }
    
    // MARK: - Storage
    
    private class PlaceholderStorage {
        let placeholderLabel = UILabel()
        var observers: [NSKeyValueObservation] = []
        
        init() {
            placeholderLabel.numberOfLines = 0
            placeholderLabel.isUserInteractionEnabled = false
            placeholderLabel.textColor = UITextView.defaultPlaceholderColor
        }
    }
    
    private var storage: PlaceholderStorage {
        if let storage = objc_getAssociatedObject(self, &kPlaceholderStorageKey) as? PlaceholderStorage {
            return storage
        }
        
        let storage = PlaceholderStorage()
        objc_setAssociatedObject(self, &kPlaceholderStorageKey, storage, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        
        // Initial Setup
        NotificationCenter.default.addObserver(self, selector: #selector(updatePlaceholderLabel), name: UITextView.textDidChangeNotification, object: self)
        
        // KVO Setup
        // We capture [weak self] to avoid retain cycles.
        // If self is nil, observation stops effectively.
        
        let updateBlock: (UITextView, Any?) -> Void = { [weak self] _, _ in
            self?.updatePlaceholderLabel()
        }
        
        storage.observers.append(observe(\.font, options: [.new], changeHandler: updateBlock))
        storage.observers.append(observe(\.textAlignment, options: [.new], changeHandler: updateBlock))
        storage.observers.append(observe(\.bounds, options: [.new], changeHandler: updateBlock))
        storage.observers.append(observe(\.textContainerInset, options: [.new], changeHandler: updateBlock))
        // Observe 'text' and 'attributedText' via KVO for programmatic changes
        storage.observers.append(observe(\.text, options: [.new], changeHandler: updateBlock))
        storage.observers.append(observe(\.attributedText, options: [.new], changeHandler: updateBlock))

        return storage
    }
    
    // MARK: - Updates
    
    @objc func updatePlaceholderLabel() {
        if !text.isEmpty {
            storage.placeholderLabel.removeFromSuperview()
            return
        }
        
        if storage.placeholderLabel.superview == nil {
            insertSubview(storage.placeholderLabel, at: 0)
        }
        
        storage.placeholderLabel.font = font
        storage.placeholderLabel.textAlignment = textAlignment
        
        let lineFragmentPadding = textContainer.lineFragmentPadding
        let containerInset = textContainerInset
        
        let x = lineFragmentPadding + containerInset.left
        let y = containerInset.top
        let width = bounds.width - x - lineFragmentPadding - containerInset.right
        
        let size = storage.placeholderLabel.sizeThatFits(CGSize(width: width, height: 0))
        storage.placeholderLabel.frame = CGRect(x: x, y: y, width: width, height: size.height)
    }
}
