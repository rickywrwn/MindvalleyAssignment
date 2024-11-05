//
//  UIColor+Extensions.swift
//  MindvalleyAssignment
//
//  Created by ricky wirawan on 05/11/24.
//

import UIKit

// MARK: - Custom Color
extension UIColor {
    static var primaryTextColor: UIColor {
        return UIColor(hex: "#FFFFFF")
    }
    
    static var secondaryTextColor: UIColor {
        return UIColor(hex: "#95989D")
    }
    
    static var channelNavigationTextColor: UIColor {
        return UIColor(hex: "##C1C1C1")
    }
    
    static var channelBackgroundColor: UIColor {
        return UIColor(hex: "#23272F")
    }
    
    static var channelLineDividerColor: UIColor {
        return UIColor(hex: "#3C434E")
    }
}


// MARK: - Hex converter
extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexString = hexString.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        Scanner(string: hexString).scanHexInt64(&rgb)
        
        let r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let b = CGFloat(rgb & 0x0000FF) / 255.0
        
        self.init(red: r, green: g, blue: b, alpha: alpha)
    }
}
