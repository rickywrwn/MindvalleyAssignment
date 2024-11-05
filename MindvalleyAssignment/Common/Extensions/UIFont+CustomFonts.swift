//
//  UIFont+CustomFonts.swift
//  MindvalleyAssignment
//
//  Created by ricky wirawan on 05/11/24.
//

import UIKit


extension UIFont{
    
    public enum RobotoType: String {
        case regular = "-Regular"
        case bold = "-Bold"
    }
    
    static func roboto(type: RobotoType, size: CGFloat) -> UIFont?{
        return UIFont(name: "Roboto\(type.rawValue)", size: size)
    }
    
}
