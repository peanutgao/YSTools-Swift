//
// *************************************************
// Created by Joseph Koh on 2023/12/22.
// Author: Joseph Koh
// Email: Joseph0750@gmail.com
// Create Date: 2023/12/22 13:41
// *************************************************
//

import UIKit

public extension UITableView {
    func sizeTableHeaderViewToFit() {
        guard let headerView = tableHeaderView else {
            return
        }
        let height = headerView.systemLayoutSizeFitting(CGSize(width: bounds.size.width, height: CGFloat.infinity))
            .height
        var frame = headerView.frame
        frame.size.height = height
        headerView.frame = frame

        headerView.setNeedsLayout()
        headerView.layoutIfNeeded()
        tableHeaderView = headerView
    }
    
    func sizeTableFooterViewToFit() {
        guard let footerView = tableFooterView else {
            return
        }
        setNeedsLayout()
        layoutIfNeeded()
        
        let height = footerView.systemLayoutSizeFitting(CGSize(width: bounds.size.width, height: CGFloat.infinity))
            .height
        var frame = footerView.frame
        frame.size.height = height
        footerView.frame = frame

        footerView.setNeedsLayout()
        footerView.layoutIfNeeded()
        tableFooterView = footerView
    }
}
