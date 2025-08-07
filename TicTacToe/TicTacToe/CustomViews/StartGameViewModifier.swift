//
//  StartGameViewModifier.swift
//  TicTacToe
//
//  Created by Jaimini Shah on 01/08/25.
//
import SwiftUI

struct StartGameButtonModifier: ViewModifier {
    let disabled: Bool
    
    func body(content: Content) -> some View {
        content
            .disabled(disabled)
            .font(.title2)
            .padding()
            .background(disabled ? Color(.gray) : Color(hex: "#2193b0"))
            .foregroundColor(.white)
            .clipShape(Capsule())
            .shadow(color: Color.black.opacity(0.5), radius: 5, x: 0, y: 5)
    }
}
