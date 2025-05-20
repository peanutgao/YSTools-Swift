//
// *************************************************
// Created by Joseph Koh on 2023/11/22.
// Author: Joseph Koh
// Email: Joseph0750@gmail.com
// Create Date: 2023/11/22 00:58
// *************************************************
//

import UIKit

public extension UITableViewCell {
    /// Usage Example
    /// ```swift
    ///       func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath:
    ///  IndexPath) {
    ///       cell.applyCornerRadius(20, in: tableView, at: indexPath)
    ///       }
    ///
    ///   * set cell padding if need
    ///    class AppPermissionListCell: UITableViewCell {
    ///    override var frame: CGRect {
    ///         get {
    ///             super.frame
    ///         }
    ///         set {
    ///             var frame = newValue
    ///             frame.origin.x += 15
    ///             frame.size.width -= 2 * 15
    ///             super.frame = frame
    ///         }
    ///    }
    ///
    ///  ```
    func applyCornerRadius(
        _ cornerRadius: CGFloat,
        in tableView: UITableView,
        at indexPath: IndexPath,
        cellBackgroundColor: UIColor = UIColor.white
    ) {
        self.backgroundColor = .clear

        let layer = CAShapeLayer()
        let backgroundLayer = CAShapeLayer()
        let pathRef = CGMutablePath()
        let bounds = bounds.insetBy(dx: 0, dy: 0)

        if indexPath.row == 0, indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
            pathRef.addRoundedRect(in: bounds, cornerWidth: cornerRadius, cornerHeight: cornerRadius)
        } else if indexPath.row == 0 {
            pathRef.move(to: CGPoint(x: bounds.minX, y: bounds.maxY))
            pathRef.addArc(tangent1End: CGPoint(x: bounds.minX, y: bounds.minY),
                           tangent2End: CGPoint(x: bounds.midX, y: bounds.minY),
                           radius: cornerRadius)
            pathRef.addArc(tangent1End: CGPoint(x: bounds.maxX, y: bounds.minY),
                           tangent2End: CGPoint(x: bounds.maxX, y: bounds.midY),
                           radius: cornerRadius)
            pathRef.addLine(to: CGPoint(x: bounds.maxX, y: bounds.maxY))
        } else if indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
            pathRef.move(to: CGPoint(x: bounds.minX, y: bounds.minY))
            pathRef.addArc(tangent1End: CGPoint(x: bounds.minX, y: bounds.maxY),
                           tangent2End: CGPoint(x: bounds.midX, y: bounds.maxY),
                           radius: cornerRadius)
            pathRef.addArc(tangent1End: CGPoint(x: bounds.maxX, y: bounds.maxY),
                           tangent2End: CGPoint(x: bounds.maxX, y: bounds.midY),
                           radius: cornerRadius)
            pathRef.addLine(to: CGPoint(x: bounds.maxX, y: bounds.minY))
        } else {
            pathRef.addRect(bounds)
        }

        layer.path = pathRef
        backgroundLayer.path = pathRef
        layer.fillColor = cellBackgroundColor.cgColor

        let roundView = UIView(frame: bounds)
        roundView.layer.insertSublayer(layer, at: 0)
        roundView.backgroundColor = .clear
        backgroundView = roundView
    }
}
