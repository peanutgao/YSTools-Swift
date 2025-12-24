//
//  PreviewHelper.swift
//  YSTools-Swift
//
//  Created by Joseph on 2025/12/15.
//

// MARK: - Usage
// Steps:
// 1. 在 SwiftUI 预览文件中 `import SwiftUI` 和 `@testable import <YourModule>`。
// 2. 用 `UIViewPreview` 包装任意 UIView：
//    struct MyViewPreview: PreviewProvider {
//        static var previews: some View {
//            UIViewPreview({
//                let label = UILabel()
//                label.text = "Hello"
//                return label
//            }, width: 320)
//            .previewLayout(.sizeThatFits)
//        }
//    }
// 3. 用 `CellPreview` 预览 UITableViewCell：
//    struct MyCellPreview: PreviewProvider {
//        static var previews: some View {
//            CellPreview({ MyCell(style: .default, reuseIdentifier: nil) }, width: 320)
//            .previewLayout(.sizeThatFits)
//        }
//    }
// 4. 如果使用 Xcode 15 的 `#Preview` 宏，可改为：
//    #Preview {
//        UIViewPreview({
//            let label = UILabel()
//            label.text = "Hello"
//            return label
//        }, width: 320)
//        .previewLayout(.sizeThatFits)
//    }
// 5. 预览 UIViewController：
//    #Preview {
//        ViewControllerPreview({
//            let vc = MyViewController()
//            vc.view.backgroundColor = .systemBackground
//            return vc
//        }, width: 360)
//        .previewLayout(.sizeThatFits)
//    }
#if DEBUG
    import UIKit
    import SwiftUI

    /// SwiftUI preview helper that wraps a `UIView`.
    @available(iOS 13.0, *)
    @MainActor
    public struct UIViewPreview<View: UIView>: UIViewRepresentable {
        private let builder: () -> View
        private let width: CGFloat?
        private let height: CGFloat?

        /// - Parameters:
        ///   - builder: View factory executed once for the preview.
        ///   - width: Optional fixed width; defaults to 375 if nil.
        ///   - height: Optional fixed height; auto-computed if nil.
        public init(_ builder: @escaping () -> View, width: CGFloat? = nil, height: CGFloat? = nil) {
            self.builder = builder
            self.width = width
            self.height = height
        }

        public func makeUIView(context: Context) -> UIView {
            let view = builder()
            let targetWidth = width ?? 375
            // Use Auto Layout fitting to avoid clipped content in preview.
            let fittingSize = CGSize(width: targetWidth, height: UIView.layoutFittingCompressedSize.height)
            let fittedHeight = height ?? view.systemLayoutSizeFitting(fittingSize).height
            view.frame = CGRect(x: 0, y: 0, width: targetWidth, height: max(1, fittedHeight))
            view.setNeedsLayout()
            view.layoutIfNeeded()
            return view
        }

        public func updateUIView(_ uiView: UIView, context: Context) {
            // Keep preview lightweight; add state resets here if needed.
        }
    }

    /// SwiftUI preview helper for `UITableViewCell` subclasses.
    @available(iOS 13.0, *)
    @MainActor
    public struct CellPreview<Cell: UITableViewCell>: UIViewRepresentable {
        private let cellBuilder: () -> Cell
        private let width: CGFloat?
        private let height: CGFloat?

        /// - Parameters:
        ///   - cellBuilder: Cell factory executed once for the preview.
        ///   - width: Optional fixed width; defaults to 375 if nil.
        ///   - height: Optional fixed height; auto-computed if nil.
        public init(_ cellBuilder: @escaping () -> Cell, width: CGFloat? = nil, height: CGFloat? = nil) {
            self.cellBuilder = cellBuilder
            self.width = width
            self.height = height
        }

        public func makeUIView(context: Context) -> UIView {
            let cell = cellBuilder()
            let targetWidth = width ?? 375

            cell.contentView.translatesAutoresizingMaskIntoConstraints = false
            cell.frame = CGRect(origin: .zero, size: CGSize(width: targetWidth, height: height ?? 0))
            cell.setNeedsLayout()
            cell.layoutIfNeeded()

            let fittingSize = CGSize(width: targetWidth, height: UIView.layoutFittingCompressedSize.height)
            let fittedHeight = height ?? cell.systemLayoutSizeFitting(fittingSize).height
            cell.frame.size.height = max(1, fittedHeight)

            // Return the whole cell so background, selection style, etc. are visible.
            return cell
        }

        public func updateUIView(_ uiView: UIView, context: Context) {
            // Keep preview lightweight; add state resets here if needed.
        }
    }

    /// SwiftUI preview helper for `UIViewController` subclasses.
    @available(iOS 13.0, *)
    @MainActor
    public struct ViewControllerPreview<VC: UIViewController>: UIViewControllerRepresentable {
        private let builder: () -> VC
        private let width: CGFloat?
        private let height: CGFloat?

        /// - Parameters:
        ///   - builder: Controller factory executed once for the preview.
        ///   - width: Optional fixed width; defaults to 375 if nil.
        ///   - height: Optional fixed height; auto-computed if nil.
        public init(_ builder: @escaping () -> VC, width: CGFloat? = nil, height: CGFloat? = nil) {
            self.builder = builder
            self.width = width
            self.height = height
        }

        public func makeUIViewController(context: Context) -> VC {
            let vc = builder()
            let targetWidth = width ?? 375
            vc.loadViewIfNeeded()
            vc.view.setNeedsLayout()
            vc.view.layoutIfNeeded()

            let fittingSize = CGSize(width: targetWidth, height: UIView.layoutFittingCompressedSize.height)
            let fittedHeight = height ?? vc.view.systemLayoutSizeFitting(fittingSize).height
            // If layout returns zero height (e.g., empty vc), fall back to a visible default.
            let finalHeight = max(fittedHeight, height ?? 600, 1)
            vc.view.frame = CGRect(origin: .zero, size: CGSize(width: targetWidth, height: finalHeight))
            vc.preferredContentSize = CGSize(width: targetWidth, height: finalHeight)
            return vc
        }

        public func updateUIViewController(_ uiViewController: VC, context: Context) {
            // Keep preview lightweight; add state resets here if needed.
        }
    }


#endif
