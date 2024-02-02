//
//  GroupTableSeparatorFix.swift
//  GroupTableSeparatorFix
//
//  Created by DianQK on 27/03/2017.
//  Copyright © 2017 dianqk. All rights reserved.
//

import UIKit

// MARK: - GroupTableSeparatorFix

public class GroupTableSeparatorFix {
    /// You should add in appdelegate
    ///  ```swift
    ///  func application(_ application: UIApplication,didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey:
    /// Any]?) -> Bool {
    ///         GroupTableSeparatorFix.removeFirstAndLastSeparatorLine()
    ///  }
    ///  ```
    private static let removeFirstAndLastSeparatorLine: () = {
        guard let method = class_getInstanceMethod(UITableViewCell.self, #selector(UITableViewCell.layoutSubviews)),
              let otherMethod = class_getInstanceMethod(
                  UITableViewCell.self,
                  #selector(UITableViewCell.fix_layoutSubviews)
              )
        else {
            print("GroupTableSeparatorFix: Failure to remove first and last separator line")
            return
        }
        method_exchangeImplementations(method, otherMethod)
    }()

    public class func removeFirstAndLastSeparatorLine(_: Void = ()) {
        _ = removeFirstAndLastSeparatorLine
    }
}

extension UITableViewCell {
    public var shouldRemoveFirstAndLastSeparatorLine: Bool {
        true
    }

    @objc fileprivate dynamic func fix_layoutSubviews() {
        guard shouldRemoveFirstAndLastSeparatorLine else {
            fix_layoutSubviews()
            return
        }
        if separatorInset.left == 0.0 {
            separatorInset.left = CGFloat.leastNonzeroMagnitude
        }
        fix_layoutSubviews()
        for view in subviews where view != contentView {
            if view.frame.height <= 0.5 {
                view.isHidden = view.frame.origin.x == 0 && view.frame.width == self.frame.width
            }
        }
    }
}
