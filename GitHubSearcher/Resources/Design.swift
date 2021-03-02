//
//  Design.swift
//  GitHubSearcher
//
//  Created by Roman Mishchenko on 02.03.2021.
//

import UIKit

struct Design {
    struct Spacing {
        static let d2: CGFloat = 2.0
        static let d4: CGFloat = 4.0
        static let d8: CGFloat = 8.0
        static let d10: CGFloat = 10.0
        static let d12: CGFloat = 12.0
        static let d16: CGFloat = 16.0
        static let d20: CGFloat = 20.0
        static let d24: CGFloat = 24.0
        static let d28: CGFloat = 28.0
        static let d32: CGFloat = 32.0
        static let d36: CGFloat = 36.0
        static let d40: CGFloat = 40.0
    }
    
    struct Color {
        static let white = UIColor.white
        static let black = UIColor.black
        static let blue = UIColor(hex: "#00D4FF")
    }
}


extension UIColor {
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat

        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])

            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255

                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }

        return nil
    }
}
