//
// *************************************************
// Created by Joseph Koh on 2023/12/22.
// Author: Joseph Koh
// Email: Joseph0750@gmail.com
// Create Time: 2023/12/22 13:41
// *************************************************
//

import UIKit

extension UITableView {
    /**
     *  Calculate the size of tableHeaderView
        *  Usage Example:
        1.  tableView.tableHeaderView = headerView
        2.  call sizeTableHeaderViewToFit() in viewDidLayoutSubviews
         override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            sizeHeaderToFit()
        }
     */
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
}
