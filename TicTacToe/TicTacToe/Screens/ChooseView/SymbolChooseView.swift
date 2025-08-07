//
//  SymbolChooseView.swift
//  TicTacToe
//
//  Created by Jaimini Shah on 18/07/25.
//

import SwiftUI

struct SymbolChooseView: View {
    
    @State private var selectedSymbol: String? = nil
    @State private var showGame = false
    @Namespace private var ns
    
    var body: some View {
        NavigationStack {
            ZStack {
                contentView
                if showGame {
                    GameView(playerSymbol: selectedSymbol ?? "X", showGame: $showGame)
                        .navigationBarBackButtonHidden(true)
                        .toolbar(.hidden, for: .navigationBar)
                        .transition(.asymmetric(
                            insertion: .offset(x: 300, y: 0),
                            removal: .offset(x: -300, y: 0)
                        ))
                }
            }
            .animation(.interpolatingSpring(
                mass: 0.5,
                stiffness: 100,
                damping: 20,
                initialVelocity: 0
            ), value: showGame)
        }
    }
    var contentView: some View {
        VStack(spacing: 50) {
            Spacer()
            
            Text("Choose your symbol")
                .foregroundColor(.white)
                .font(.largeTitle)
                .bold()
                .padding(.bottom, 30)
            
            Spacer().frame(height: 0)
            
            HStack() {
                Spacer()
                SymbolButton(symbol: "X", isSelected: selectedSymbol == "X") {
                    selectedSymbol = "X"
                }
                Spacer()
                SymbolButton(symbol: "O", isSelected: selectedSymbol == "O") {
                    selectedSymbol = "O"
                }
                Spacer()
            }
            .padding(.bottom, 20)
            
            Button("Start Game") {
                withAnimation(.bouncy()) {
                    showGame = true
                }
                
            }
            .modifier(StartGameButtonModifier(disabled: selectedSymbol == nil))
            Spacer()
        }
        .backgroundGradient()
    }
}
#Preview {
    SymbolChooseView()
}
