//
//  UITableView+Create.swift
//  TCDoctor
//
//  Created by Joseph Koh on 2019/5/10.
//  Copyright © 2019 Joseph Koh. All rights reserved.
//

import UIKit

public protocol UITableViewCreateProtocol {
    
}

public extension UITableViewCreateProtocol where Self: UITableView {
    @discardableResult
    func ys_dataSource(_ dataSource: UITableViewDataSource) -> Self {
        self.dataSource = dataSource
        return self
    }
    
    @discardableResult
    func ys_delegate(_ delegate: UITableViewDelegate) -> Self {
        self.delegate = delegate
        return self
    }
    
    @discardableResult
    func ys_separatorStyle(_ style: UITableViewCell.SeparatorStyle) -> Self {
        self.separatorStyle = style
        return self
    }
    
    @discardableResult
    func ys_register(_ cellClass: AnyClass, forCellReuseIdentifier identifier: String) -> Self {
        self.register(cellClass, forCellReuseIdentifier: identifier)
        return self
    }
    
    @discardableResult
    func ys_sectionIndexColor(_ color: UIColor) -> Self {
        self.sectionIndexColor = color
        return self
    }
    
    @discardableResult
    func ys_sectionIndexBackgroundColor(_ color: UIColor) -> Self {
        self.sectionIndexBackgroundColor = color
        return self
    }
    
    @discardableResult
    func ys_sectionFooterHeight(_ height: CGFloat) -> Self {
        self.sectionFooterHeight = height
        return self
    }
    
    @discardableResult
    func ys_rowHeight(_ rowHeight: CGFloat) -> Self {
        self.rowHeight = rowHeight
        return self
    }
    
    @discardableResult
    func ys_tableFooterView(_ view: UIView) -> Self {
        self.tableFooterView = view
        return self
    }
    
    @discardableResult
    func ys_tableHeaderView(_ view: UIView) -> Self {
        self.tableHeaderView = view
        return self
    }
    
    @discardableResult
    func ys_estimatedRowHeight(_ height: CGFloat) -> Self {
        self.estimatedRowHeight = height
        return self
    }
    
    @discardableResult
    func ys_estimatedSectionHeaderHeight(_ height: CGFloat) -> Self {
        self.estimatedSectionHeaderHeight = height
        return self
    }
    
}

 extension UITableView: UITableViewCreateProtocol {
   
}



