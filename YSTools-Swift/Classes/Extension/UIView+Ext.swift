//
// Created by Joseph Koh on 2023/10/23.
//

import UIKit

public extension UIView {
    func removeAllSubviews() {
        subviews.forEach { $0.removeFromSuperview() }
    }
}
