//
//  Colors.swift
//  elise_test
//
//  Created by Tabber on 2023/11/26.
//

import SwiftUI

struct Colors {
    static var textBlack: Color = Color(hex: "#000000")
    static var titleImageBackgroundGray: Color = Color(hex: "#3A3A4C")
    static var tagsGray: Color = Color(hex: "#E4E4E4")
    static var applyPurple: Color = Color(hex: "#5A2ECC")
    static var logoBackgroundGray: Color = Color(hex: "#F3F3F3")
    static var lecturePurple: Color = Color(hex: "#524FA1")
    static var lineGray: Color = Color(hex: "#AEAEAE")
    static var lectureDisableRed: Color = Color(hex: "#F44336")
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
