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
    ///   - borderWidth: Border width for section groups (default: 0)
    ///   - borderColor: Border color for section groups (default: .clear)
    func applyGroupedSectionStyle(
        cornerRadius: CGFloat = 15,
        backgroundColor: UIColor = .white,
        horizontalPadding: CGFloat = 0,
        borderWidth: CGFloat = 0,
        borderColor: UIColor = .clear
    ) {
        self.backgroundColor = .clear
        self.separatorStyle = .none
        
        // Store configuration
        objc_setAssociatedObject(self, &AssociatedKeys.cornerRadius, cornerRadius, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        objc_setAssociatedObject(self, &AssociatedKeys.backgroundColor, backgroundColor, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        objc_setAssociatedObject(self, &AssociatedKeys.horizontalPadding, horizontalPadding, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        objc_setAssociatedObject(self, &AssociatedKeys.borderWidth, borderWidth, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        objc_setAssociatedObject(self, &AssociatedKeys.borderColor, borderColor, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
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
    
    var sectionBorderWidth: CGFloat {
        return objc_getAssociatedObject(self, &AssociatedKeys.borderWidth) as? CGFloat ?? 0
    }
    
    var sectionBorderColor: UIColor {
        return objc_getAssociatedObject(self, &AssociatedKeys.borderColor) as? UIColor ?? .clear
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
        
        // Determine corner radius and border based on position
        if numberOfRows == 1 {
            // Single cell in section - all corners rounded, full border
            backgroundView.layer.cornerRadius = tableView.sectionCornerRadius
            backgroundView.layer.maskedCorners = [
                .layerMinXMinYCorner, .layerMaxXMinYCorner,
                .layerMinXMaxYCorner, .layerMaxXMaxYCorner
            ]
            // Full border for single cell
            backgroundView.layer.borderWidth = tableView.sectionBorderWidth
            backgroundView.layer.borderColor = tableView.sectionBorderColor.cgColor
        } else if indexPath.row == 0 {
            // First cell - top corners rounded, no bottom border
            backgroundView.layer.cornerRadius = tableView.sectionCornerRadius
            backgroundView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            // Use a custom border view to avoid bottom border
            addSectionBorder(to: backgroundView, 
                           position: .first,
                           width: tableView.sectionBorderWidth, 
                           color: tableView.sectionBorderColor)
        } else if indexPath.row == numberOfRows - 1 {
            // Last cell - bottom corners rounded, no top border
            backgroundView.layer.cornerRadius = tableView.sectionCornerRadius
            backgroundView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            // Use a custom border view to avoid top border
            addSectionBorder(to: backgroundView, 
                           position: .last,
                           width: tableView.sectionBorderWidth, 
                           color: tableView.sectionBorderColor)
        } else {
            // Middle cell - no corners rounded, only side borders
            backgroundView.layer.cornerRadius = 0
            // Use a custom border view with only left and right borders
            addSectionBorder(to: backgroundView, 
                           position: .middle,
                           width: tableView.sectionBorderWidth, 
                           color: tableView.sectionBorderColor)
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
            backgroundView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
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
    static var borderWidth: UInt8 = 4
    static var borderColor: UInt8 = 5
}

// MARK: - Helper Methods

private extension UITableViewCell {
    
    enum CellPosition {
        case first, middle, last
    }
    
    func addSectionBorder(to view: UIView, position: CellPosition, width: CGFloat, color: UIColor) {
        guard width > 0 else { return }
        
        // Remove existing custom border layers
        view.layer.sublayers?.removeAll { $0.name?.hasPrefix("sectionBorder") == true }
        
        // Store border info for layout updates
        objc_setAssociatedObject(view, &BorderAssociatedKeys.position, position, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        objc_setAssociatedObject(view, &BorderAssociatedKeys.width, width, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        objc_setAssociatedObject(view, &BorderAssociatedKeys.color, color, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        
        // Create a custom border view
        let borderView = SectionBorderView()
        borderView.position = position
        borderView.borderWidth = width
        borderView.borderColor = color
        borderView.backgroundColor = .clear
        borderView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(borderView)
        NSLayoutConstraint.activate([
            borderView.topAnchor.constraint(equalTo: view.topAnchor),
            borderView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            borderView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            borderView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

// MARK: - Custom Border View

private class SectionBorderView: UIView {
    var position: UITableViewCell.CellPosition = .middle
    var borderWidth: CGFloat = 0
    var borderColor: UIColor = .clear
    
    override func draw(_ rect: CGRect) {
        guard borderWidth > 0, borderColor != .clear else { return }
        
        let context = UIGraphicsGetCurrentContext()
        context?.setStrokeColor(borderColor.cgColor)
        context?.setLineWidth(borderWidth)
        
        let halfWidth = borderWidth / 2
        
        switch position {
        case .first:
            // Draw top, left, right borders
            context?.move(to: CGPoint(x: 0, y: halfWidth))
            context?.addLine(to: CGPoint(x: rect.width, y: halfWidth)) // Top
            context?.move(to: CGPoint(x: halfWidth, y: 0))
            context?.addLine(to: CGPoint(x: halfWidth, y: rect.height)) // Left
            context?.move(to: CGPoint(x: rect.width - halfWidth, y: 0))
            context?.addLine(to: CGPoint(x: rect.width - halfWidth, y: rect.height)) // Right
        case .middle:
            // Draw left, right borders only
            context?.move(to: CGPoint(x: halfWidth, y: 0))
            context?.addLine(to: CGPoint(x: halfWidth, y: rect.height)) // Left
            context?.move(to: CGPoint(x: rect.width - halfWidth, y: 0))
            context?.addLine(to: CGPoint(x: rect.width - halfWidth, y: rect.height)) // Right
        case .last:
            // Draw bottom, left, right borders
            context?.move(to: CGPoint(x: 0, y: rect.height - halfWidth))
            context?.addLine(to: CGPoint(x: rect.width, y: rect.height - halfWidth)) // Bottom
            context?.move(to: CGPoint(x: halfWidth, y: 0))
            context?.addLine(to: CGPoint(x: halfWidth, y: rect.height)) // Left
            context?.move(to: CGPoint(x: rect.width - halfWidth, y: 0))
            context?.addLine(to: CGPoint(x: rect.width - halfWidth, y: rect.height)) // Right
        }
        
        context?.strokePath()
    }
}

// MARK: - Border Associated Keys

private struct BorderAssociatedKeys {
    static var position: UInt8 = 10
    static var width: UInt8 = 11
    static var color: UInt8 = 12
}
