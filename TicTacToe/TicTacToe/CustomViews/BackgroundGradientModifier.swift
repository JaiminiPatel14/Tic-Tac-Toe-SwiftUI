//
//  BackgroundGradientModifier.swift
//  TicTacToe
//
//  Created by Jaimini Shah on 01/08/25.
//

import SwiftUI

struct BackgroundGradientModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(hex: "#0F2027"),
                        Color(hex: "#203A43"),
                        Color(hex: "#2C5364")
                    ]),
                    startPoint: .bottomTrailing,
                    endPoint: .topLeading
                )
                .ignoresSafeArea()
            )
    }
}
extension View {
    func backgroundGradient() -> some View {
        self.modifier(BackgroundGradientModifier())
    }
}
