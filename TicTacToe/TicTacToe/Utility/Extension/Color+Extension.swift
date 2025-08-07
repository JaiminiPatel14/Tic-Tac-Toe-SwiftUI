//
//  Color+Extension.swift
//  TicTacToe
//
//  Created by Jaimini Shah on 01/08/25.
//

import SwiftUI

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        var rgbValue: UInt64 = 0
        Scanner(string: hex.hasPrefix("#") ? String(hex.dropFirst()) : hex)
            .scanHexInt64(&rgbValue)

        let r = Double((rgbValue >> 16) & 0xFF) / 255.0
        let g = Double((rgbValue >> 8) & 0xFF) / 255.0
        let b = Double(rgbValue & 0xFF) / 255.0

        self.init(red: r, green: g, blue: b)
    }
}
