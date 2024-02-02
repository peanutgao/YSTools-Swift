//
//  UISearchBar+Ext.swift
//  YSTools-Swift
//
//  Created by Joseph Koh on 2019/6/6.
//  Copyright © 2019 Joseph Koh. All rights reserved.
//

public extension UISearchBar {
    func getTextField() -> UITextField? { value(forKey: "searchField") as? UITextField }

    func setClearButton(color: UIColor) {
        getTextField()?.setClearButton(color: color)
    }
}
