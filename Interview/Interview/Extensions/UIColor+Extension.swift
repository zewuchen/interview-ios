//
//  UIColor+Extension.swift
//  Interview
//
//  Created by Rafael Ramos on 05/09/24.
//

import Foundation
import UIKit

extension UIColor {
    private func getLuminanceFromRGBValues() -> Double {
        // 2. Extract RGB values
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        self.getRed(&red, green: &green, blue: &blue, alpha: nil)

        // 3. Compute luminance.
        return 0.2126 * Double(red) + 0.7152 * Double(green) + 0.0722 * Double(blue)
    }
    
    private func isLight() -> Bool {
        return getLuminanceFromRGBValues() > 0.5
    }
    
    func adaptedTextColor() -> UIColor {
        return isLight() ? .black : .white
    }
}
