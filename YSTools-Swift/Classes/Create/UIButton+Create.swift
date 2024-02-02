//
//  Button+Create.swift
//  YSTools-Swift
//
//  Created by Sallie Xiong on 2019/4/28.
//  Copyright © 2019 Joseph Koh. All rights reserved.
//

import UIKit

// MARK: - UIButtonCreateProtocol

public protocol UIButtonCreateProtocol {}

public extension UIButtonCreateProtocol where Self: UIButton {
    @discardableResult
    func ys_adjustsImageWhenHighlighted(b: Bool) -> Self {
        self.adjustsImageWhenHighlighted = b
        return self
    }

    @discardableResult
    func ys_adjustsImageWhenDisabled(b: Bool) -> Self {
        self.adjustsImageWhenDisabled = b
        return self
    }

    @discardableResult
    func ys_setImage(imgName: String?, state: UIControl.State) -> Self {
        var img: UIImage? = nil
        if let imgName {
            img = UIImage(named: imgName)
        }
        self.setImage(img, for: state)
        return self
    }

    @discardableResult
    func ys_setImage(img: UIImage?, state: UIControl.State) -> Self {
        self.setImage(img, for: state)
        return self
    }

    @discardableResult
    func ys_isSelected(_ isSelected: Bool) -> Self {
        self.isSelected = isSelected
        return self
    }

    @discardableResult
    func ys_setTitle(_ title: String?, state: UIControl.State) -> Self {
        self.setTitle(title, for: state)
        return self
    }

    @discardableResult
    func ys_setTitleFont(_ font: UIFont?) -> Self {
        if let font { self.titleLabel?.font = font }
        return self
    }

    @discardableResult
    func ys_setTitleColor(_ color: UIColor?, state: UIControl.State) -> Self {
        self.setTitleColor(color, for: state)
        return self
    }

    @discardableResult
    func ys_setBackgroundImage(imgName: String?, state: UIControl.State) -> Self {
        if let imgName, let img = UIImage(named: imgName) {
            self.setBackgroundImage(img, for: state)
        } else {
            self.setBackgroundImage(nil, for: state)
        }
        return self
    }

    @discardableResult
    func ys_setBackgroundImage(img: UIImage?, state: UIControl.State) -> Self {
        self.setBackgroundImage(img, for: state)
        return self
    }

    @discardableResult
    func ys_setAttributedTitle(_ title: NSAttributedString?, for state: UIControl.State) -> Self {
        self.setAttributedTitle(title, for: state)
        return self
    }

    @discardableResult
    func ys_contentHorizontalAlignment(_ alignment: UIControl.ContentHorizontalAlignment) -> Self {
        self.contentHorizontalAlignment = alignment
        return self
    }

    @discardableResult
    func ys_contentVerticalAlignment(_ alignment: UIControl.ContentVerticalAlignment) -> Self {
        self.contentVerticalAlignment = alignment
        return self
    }

    @discardableResult
    func ys_contentEdgeInsets(_ insets: UIEdgeInsets = .zero) -> Self {
        self.contentEdgeInsets = insets
        return self
    }
}

// MARK: - UIButton + UIButtonCreateProtocol

extension UIButton: UIButtonCreateProtocol {
    public typealias ActionHandler = (UIButton) -> Void

    private enum EventKeys {
        static var touchDown = "touchDown"
        static var touchDownRepeat = "touchDownRepeat"
        static var touchDragInside = "touchDragInside"
        static var touchDragOutside = "touchDragOutside"
        static var touchDragEnter = "touchDragEnter"
        static var touchDragExit = "touchDragExit"
        static var touchUpInside = "touchUpInside"
        static var touchUpOutside = "touchUpOutside"
        static var touchCancel = "touchCancel"
        static var valueChanged = "valueChanged"
        static var primaryActionTriggered = "primaryActionTriggered"
        static var editingDidBegin = "editingDidBegin"
        static var editingChanged = "editingChanged"
        static var editingDidEnd = "editingDidEnd"
        static var editingDidEndOnExit = "editingDidEndOnExit"
        static var allTouchEvents = "allTouchEvents"
        static var allEditingEvents = "allEditingEvents"
        static var applicationReserved = "applicationReserved"
        static var systemReserved = "systemReserved"
        static var allEvents = "allEvents"
    }

    private enum AssociatedKeys {
        static var kSelMapperKey = "kSelMapperKey"
    }

    private var __selMapper: [String: ActionHandler]? {
        get {
            objc_getAssociatedObject(self, &AssociatedKeys.kSelMapperKey) as? [String: ActionHandler]
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.kSelMapperKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    @discardableResult
    @objc public func ys_action(event: UIControl.Event, acton: ActionHandler?) -> Self {
        guard let action = acton else {
            return self
        }

        var sel: Selector?
        var key: String?
        switch event {
        case .touchDown:
            sel = #selector(__ys_touchDownAction(btn:event:))
            key = EventKeys.touchDown
        case .touchDownRepeat:
            sel = #selector(__ys_touchDownRepeatAction(btn:event:))
            key = EventKeys.touchDownRepeat
        case .touchDragInside:
            sel = #selector(__ys_touchDragInsideAction(btn:event:))
            key = EventKeys.touchDragInside
        case .touchDragOutside:
            sel = #selector(__ys_touchDragOutsideAction(btn:event:))
            key = EventKeys.touchDragOutside
        case .touchDragEnter:
            sel = #selector(__ys_touchDragEnterAction(btn:event:))
            key = EventKeys.touchDragEnter
        case .touchDragExit:
            sel = #selector(__ys_touchDragExitAction(btn:event:))
            key = EventKeys.touchDragExit
        case .touchUpInside:
            sel = #selector(__ys_touchUpInsideAction(btn:event:))
            key = EventKeys.touchUpInside
        case .touchUpOutside:
            sel = #selector(__ys_touchUpOutsideAction(btn:event:))
            key = EventKeys.touchUpOutside
        case .touchCancel:
            sel = #selector(__ys_touchCancelAction(btn:event:))
            key = EventKeys.touchCancel
        case .valueChanged:
            sel = #selector(__ys_valueChangedAction(btn:event:))
            key = EventKeys.valueChanged
        case .primaryActionTriggered:
            sel = #selector(__ys_primaryActionTriggeredAction(btn:event:))
            key = EventKeys.primaryActionTriggered
        case .editingDidBegin:
            sel = #selector(__ys_editingDidBeginAction(btn:event:))
            key = EventKeys.editingDidBegin
        case .editingChanged:
            sel = #selector(__ys_editingChangedAction(btn:event:))
            key = EventKeys.editingChanged
        case .editingDidEnd:
            sel = #selector(__ys_editingDidEndAction(btn:event:))
            key = EventKeys.editingDidEnd
        case .editingDidEndOnExit:
            sel = #selector(__ys_editingDidEndOnExitAction(btn:event:))
            key = EventKeys.editingDidEndOnExit
        case .allTouchEvents:
            sel = #selector(__ys_allTouchEventsAction(btn:event:))
            key = EventKeys.allTouchEvents
        case .allEditingEvents:
            sel = #selector(__ys_allEditingEventsAction(btn:event:))
            key = EventKeys.allEditingEvents
        case .applicationReserved:
            sel = #selector(__ys_applicationReservedAction(btn:event:))
            key = EventKeys.applicationReserved
        case .systemReserved:
            sel = #selector(__ys_systemReservedAction(btn:event:))
            key = EventKeys.systemReserved
        case .allEvents:
            sel = #selector(__ys_allEventsAction(btn:event:))
            key = EventKeys.allEvents

        default:
            break
        }
        if let sel, let key {
            self.addTarget(self, action: sel, for: event)
            if self.__selMapper == nil {
                self.__selMapper = [String: ActionHandler]()
            }
            self.__selMapper![key] = action
        }

        return self
    }

    @objc private func __ys_touchDownAction(btn _: UIButton, event _: UIControl.Event) {
        if let map = self.__selMapper, let action = map[EventKeys.touchDown] {
            action(self)
        }
    }

    @objc private func __ys_touchDownRepeatAction(btn _: UIButton, event _: UIControl.Event) {
        if let map = self.__selMapper, let action = map[EventKeys.touchDownRepeat] {
            action(self)
        }
    }

    @objc private func __ys_touchDragInsideAction(btn _: UIButton, event _: UIControl.Event) {
        if let map = self.__selMapper, let action = map[EventKeys.touchDragInside] {
            action(self)
        }
    }

    @objc private func __ys_touchDragOutsideAction(btn _: UIButton, event _: UIControl.Event) {
        if let map = self.__selMapper, let action = map[EventKeys.touchDragOutside] {
            action(self)
        }
    }

    @objc private func __ys_touchDragEnterAction(btn _: UIButton, event _: UIControl.Event) {
        if let map = self.__selMapper, let action = map[EventKeys.touchDragEnter] {
            action(self)
        }
    }

    @objc private func __ys_touchDragExitAction(btn _: UIButton, event _: UIControl.Event) {
        if let map = self.__selMapper, let action = map[EventKeys.touchDragExit] {
            action(self)
        }
    }

    @objc private func __ys_touchUpInsideAction(btn _: UIButton, event _: UIControl.Event) {
        if let map = self.__selMapper, let action = map[EventKeys.touchUpInside] {
            action(self)
        }
    }

    @objc private func __ys_touchUpOutsideAction(btn _: UIButton, event _: UIControl.Event) {
        if let map = self.__selMapper, let action = map[EventKeys.touchUpOutside] {
            action(self)
        }
    }

    @objc private func __ys_touchCancelAction(btn _: UIButton, event _: UIControl.Event) {
        if let map = self.__selMapper, let action = map[EventKeys.touchCancel] {
            action(self)
        }
    }

    @objc private func __ys_valueChangedAction(btn _: UIButton, event _: UIControl.Event) {
        if let map = self.__selMapper, let action = map[EventKeys.valueChanged] {
            action(self)
        }
    }

    @objc private func __ys_primaryActionTriggeredAction(btn _: UIButton, event _: UIControl.Event) {
        if let map = self.__selMapper, let action = map[EventKeys.primaryActionTriggered] {
            action(self)
        }
    }

    @objc private func __ys_editingDidBeginAction(btn _: UIButton, event _: UIControl.Event) {
        if let map = self.__selMapper, let action = map[EventKeys.editingDidBegin] {
            action(self)
        }
    }

    @objc private func __ys_editingChangedAction(btn _: UIButton, event _: UIControl.Event) {
        if let map = self.__selMapper, let action = map[EventKeys.editingChanged] {
            action(self)
        }
    }

    @objc private func __ys_editingDidEndAction(btn _: UIButton, event _: UIControl.Event) {
        if let map = self.__selMapper, let action = map[EventKeys.editingDidEnd] {
            action(self)
        }
    }

    @objc private func __ys_editingDidEndOnExitAction(btn _: UIButton, event _: UIControl.Event) {
        if let map = self.__selMapper, let action = map[EventKeys.editingDidEndOnExit] {
            action(self)
        }
    }

    @objc private func __ys_allTouchEventsAction(btn _: UIButton, event _: UIControl.Event) {
        if let map = self.__selMapper, let action = map[EventKeys.allTouchEvents] {
            action(self)
        }
    }

    @objc private func __ys_allEditingEventsAction(btn _: UIButton, event _: UIControl.Event) {
        if let map = self.__selMapper, let action = map[EventKeys.allEditingEvents] {
            action(self)
        }
    }

    @objc private func __ys_applicationReservedAction(btn _: UIButton, event _: UIControl.Event) {
        if let map = self.__selMapper, let action = map[EventKeys.applicationReserved] {
            action(self)
        }
    }

    @objc private func __ys_systemReservedAction(btn _: UIButton, event _: UIControl.Event) {
        if let map = self.__selMapper, let action = map[EventKeys.systemReserved] {
            action(self)
        }
    }

    @objc private func __ys_allEventsAction(btn _: UIButton, event _: UIControl.Event) {
        if let map = self.__selMapper, let action = map[EventKeys.allEditingEvents] {
            action(self)
        }
    }
}
