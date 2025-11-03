//
//  UITableViewCell+Seperator.swift
//  YSTools-Swift
//
//  Created by Joseph on 2025/5/24.
//

import UIKit

// MARK: - AutoConfigurableSeparator

/// Protocol to indicate if a cell should auto-configure separator
public protocol AutoConfigurableSeparator {
    /// Separator configuration for the cell
    var separatorConfiguration: SeparatorConfiguration { get }
    
    /// Whether to enable auto-configuration of separator
    var shouldAutoConfigureSeparator: Bool { get }
}

public extension AutoConfigurableSeparator {
    /// Default implementation: enable auto-configuration
    var shouldAutoConfigureSeparator: Bool { true }
    
    /// Default separator configuration
    var separatorConfiguration: SeparatorConfiguration { .default }
}

// MARK: - SeparatorConfiguration

/// Configuration for separator line styling
public struct SeparatorConfiguration {
    let color: UIColor
    let height: CGFloat
    let leftInset: CGFloat
    let rightInset: CGFloat
    let isVisible: Bool

    public init(
        color: UIColor = UIColor(red: 248.0 / 255.0, green: 248.0 / 255.0, blue: 248.0 / 255.0, alpha: 1),
        height: CGFloat = 1,
        leftInset: CGFloat = 15,
        rightInset: CGFloat = 15,
        isVisible: Bool = true
    ) {
        self.color = color
        self.height = height
        self.leftInset = leftInset
        self.rightInset = rightInset
        self.isVisible = isVisible
    }

    /// Default separator configuration
    public static let `default` = SeparatorConfiguration()

    /// Hidden separator configuration
    public static let hidden = SeparatorConfiguration(isVisible: false)
}

/// Extension for handling table view cell separator lines
public extension UITableViewCell {
    /// Configures separator line for the cell
    /// - Parameters:
    ///   - config: Separator configuration
    ///   - position: Position of the cell in section (optional, auto-detected if not provided)
    ///   - totalRows: Total number of rows in section (optional, auto-detected if not provided)
    func configureSeparator(
        with config: SeparatorConfiguration = .default,
        position: CellPosition? = nil,
        totalRows: Int? = nil
    ) {
        // Remove existing separator
        removeSeparator()

        // Determine position if not provided
        let cellPosition = position ?? detectCellPosition(totalRows: totalRows)

        // Only add separator if visible and not the last cell
        guard config.isVisible, cellPosition != .last, cellPosition != .single else {
            return
        }

        addSeparator(with: config)
    }

    /// Shows separator with default configuration
    func showSeparator() {
        configureSeparator(with: .default)
    }

    /// Hides separator
    func hideSeparator() {
        configureSeparator(with: .hidden)
    }

    /// Shows separator with custom configuration
    /// - Parameter config: Custom separator configuration
    func showSeparator(with config: SeparatorConfiguration) {
        configureSeparator(with: config)
    }

    /// Automatically configures separator based on cell position in section
    /// - Parameters:
    ///   - tableView: The table view containing this cell
    ///   - indexPath: Index path of the cell
    ///   - config: Separator configuration (default configuration will be used if not provided)
    func autoConfigureSeparator(
        in tableView: UITableView,
        at indexPath: IndexPath,
        with config: SeparatorConfiguration = .default
    ) {
        let totalRows = tableView.numberOfRows(inSection: indexPath.section)
        let position = CellPosition.from(row: indexPath.row, totalRows: totalRows)

        configureSeparator(with: config, position: position, totalRows: totalRows)
    }
    
    /// Automatically configures separator based on protocol conformance
    /// - Parameters:
    ///   - tableView: The table view containing this cell
    ///   - indexPath: Index path of the cell
    /// - Note:
    ///   - Conforms to protocol + enabled: use custom configuration
    ///   - Conforms to protocol + disabled: remove separator
    ///   - Does NOT conform to protocol: use default configuration
    func autoConfigureSeparatorIfNeeded(
        in tableView: UITableView,
        at indexPath: IndexPath
    ) {
        if let configurableCell = self as? AutoConfigurableSeparator {
            // Cell conforms to protocol
            if configurableCell.shouldAutoConfigureSeparator {
                // Explicitly enabled, use custom configuration
                autoConfigureSeparator(
                    in: tableView,
                    at: indexPath,
                    with: configurableCell.separatorConfiguration
                )
            } else {
                // Explicitly disabled, remove separator
                removeSeparator()
            }
        } else {
            // Not conforming to protocol, use default configuration
            autoConfigureSeparator(
                in: tableView,
                at: indexPath,
                with: .default
            )
        }
    }

    // MARK: - Private Methods

    private func addSeparator(with config: SeparatorConfiguration) {
        let separator = UIView()
        separator.backgroundColor = config.color
        separator.tag = SeparatorTag.value

        contentView.addSubview(separator)
        separator.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            separator.heightAnchor.constraint(equalToConstant: config.height),
            separator.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            separator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: config.leftInset),
            separator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -config.rightInset)
        ])
    }

    private func removeSeparator() {
        for view in contentView.subviews where view.tag == SeparatorTag.value {
            view.removeFromSuperview()
        }
    }

    private func detectCellPosition(totalRows: Int?) -> CellPosition {
        guard let tableView = findParentTableView(),
              let indexPath = tableView.indexPath(for: self)
        else {
            return .middle
        }

        let rows = totalRows ?? tableView.numberOfRows(inSection: indexPath.section)
        return CellPosition.from(row: indexPath.row, totalRows: rows)
    }

    private func findParentTableView() -> UITableView? {
        var view: UIView? = superview
        while view != nil {
            if let tableView = view as? UITableView {
                return tableView
            }
            view = view?.superview
        }
        return nil
    }
}

// MARK: - CellPosition

/// Represents the position of a cell within a section
public enum CellPosition {
    case single // Only one cell in section
    case first // First cell in section
    case middle // Middle cell in section
    case last // Last cell in section

    static func from(row: Int, totalRows: Int) -> CellPosition {
        if totalRows == 1 {
            .single
        } else if row == 0 {
            .first
        } else if row == totalRows - 1 {
            .last
        } else {
            .middle
        }
    }
}

// MARK: - SeparatorTag

/// Tag for separator view identification
private enum SeparatorTag {
    static let value = 1999
}
