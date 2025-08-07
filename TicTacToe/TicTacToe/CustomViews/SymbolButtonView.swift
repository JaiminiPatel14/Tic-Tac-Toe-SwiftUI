//
//  SymbolButtonView.swift
//  TicTacToe
//
//  Created by Jaimini Shah on 01/08/25.
//
import SwiftUI

struct SymbolButton: View {
    let symbol: String
    var symbolColor: Color {
        let baseColor = symbol == "X" ? Color.yellow : Color.mint
        return isSelected ? baseColor : baseColor.opacity(0.5)
    }
    let isSelected: Bool
    let onTap: () -> Void

    var body: some View {
        Button(action: {
            onTap()
            UIImpactFeedbackGenerator(style: .medium).impactOccurred() // optional haptic
        }) {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .strokeBorder(symbolColor, lineWidth: isSelected ? 3 : 1.5) // Draw the border
                    .frame(width: 120, height: 120)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.white.opacity(isSelected ? 0.1 : 0)) // Fill background color
                    )
                
                Text(symbol)
                    .font(.system(size: 60, weight: .bold, design: .rounded))
                    .foregroundColor(symbolColor)
            }
            .scaleEffect(isSelected ? 1.1 : 1.0)
            .animation(isSelected ? .interpolatingSpring(stiffness: 200, damping: 10) : nil, value: isSelected)
        }
    }
}
