//
// *************************************************
// Created by Joseph Koh on 2023/11/22.
// Author: Joseph Koh
// Email: Joseph0750@gmail.com
// Create Date: 2023/11/22 00:58
// *************************************************
//

import UIKit

/// UITableView extension for applying true grouped section style
/// This creates a single rounded card for each section, similar to iOS Settings app
public extension UITableView {

    /// Configures the table view for true grouped section style
    /// - Parameters:
    ///   - cornerRadius: Corner radius for section groups (default: 15)
    ///   - backgroundColor: Background color for section groups (default: .white)
    ///   - sectionSpacing: Spacing between sections (default: 15)
    ///   - horizontalPadding: Left and right padding for section groups (default: 15)
    func applyGroupedSectionStyle(
        cornerRadius: CGFloat = 15,
        backgroundColor: UIColor = .white,
        sectionSpacing: CGFloat = 15,
        horizontalPadding: CGFloat = 15
    ) {
        self.backgroundColor = .clear
        self.separatorStyle = .none
        
        // Store configuration
        objc_setAssociatedObject(self, &AssociatedKeys.cornerRadius, cornerRadius, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        objc_setAssociatedObject(self, &AssociatedKeys.backgroundColor, backgroundColor, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        objc_setAssociatedObject(self, &AssociatedKeys.sectionSpacing, sectionSpacing, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        objc_setAssociatedObject(self, &AssociatedKeys.horizontalPadding, horizontalPadding, .OBJC_ASSOCIATION_COPY_NONATOMIC)
    }
    
    // MARK: - Getters
    
    var sectionCornerRadius: CGFloat {
        return objc_getAssociatedObject(self, &AssociatedKeys.cornerRadius) as? CGFloat ?? 15
    }
    
    var sectionBackgroundColor: UIColor {
        return objc_getAssociatedObject(self, &AssociatedKeys.backgroundColor) as? UIColor ?? .white
    }
    
    var sectionSpacing: CGFloat {
        return objc_getAssociatedObject(self, &AssociatedKeys.sectionSpacing) as? CGFloat ?? 15
    }
    
    var sectionHorizontalPadding: CGFloat {
        return objc_getAssociatedObject(self, &AssociatedKeys.horizontalPadding) as? CGFloat ?? 15
    }
}

public extension UITableViewCell {

    /// Applies grouped section style to cell based on its position in section
    /// - Parameters:
    ///   - tableView: The table view containing this cell
    ///   - indexPath: The index path of this cell
    func applyGroupedSectionStyle(in tableView: UITableView, at indexPath: IndexPath) {
        self.backgroundColor = .clear
        
        // Remove old background
        self.backgroundView?.subviews.forEach { $0.removeFromSuperview() }
        
        let numberOfRows = tableView.numberOfRows(inSection: indexPath.section)
        
        // Create background view
        let backgroundView = UIView()
        backgroundView.backgroundColor = tableView.sectionBackgroundColor
        backgroundView.layer.masksToBounds = true
        
        // Determine corner radius based on position
        if numberOfRows == 1 {
            // Single cell in section - all corners rounded
            backgroundView.layer.cornerRadius = tableView.sectionCornerRadius
            backgroundView.layer.maskedCorners = [
                .layerMinXMinYCorner, .layerMaxXMinYCorner,
                .layerMinXMaxYCorner, .layerMaxXMaxYCorner
            ]
        } else if indexPath.row == 0 {
            // First cell - top corners rounded
            backgroundView.layer.cornerRadius = tableView.sectionCornerRadius
            backgroundView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        } else if indexPath.row == numberOfRows - 1 {
            // Last cell - bottom corners rounded
            backgroundView.layer.cornerRadius = tableView.sectionCornerRadius
            backgroundView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        } else {
            // Middle cell - no corners rounded
            backgroundView.layer.cornerRadius = 0
        }
        
        // Create container for horizontal padding
        let containerView = UIView()
        containerView.backgroundColor = .clear
        containerView.addSubview(backgroundView)
        
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: containerView.topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: tableView.sectionHorizontalPadding),
            backgroundView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -tableView.sectionHorizontalPadding)
        ])
        
        self.backgroundView = containerView
    }
}

// MARK: - Associated Keys

private struct AssociatedKeys {
    static var cornerRadius: UInt8 = 0
    static var backgroundColor: UInt8 = 1
    static var sectionSpacing: UInt8 = 2
    static var horizontalPadding: UInt8 = 3
}
