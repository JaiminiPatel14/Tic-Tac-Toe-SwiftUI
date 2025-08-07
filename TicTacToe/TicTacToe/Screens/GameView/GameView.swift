//
//  GameView.swift
//  TicTacToe
//
//  Created by Jaimini Shah on 18/07/25.
//

import SwiftUI

struct GameView: View {
    let playerSymbol: String
    private var playerSymbol2: String {
        playerSymbol == "X" ? "O" : "X"
    }
    private let winningCombinations: [[Int]] = [
        [0, 1, 2], [3, 4, 5], [6, 7, 8], // rows
        [0, 3, 6], [1, 4, 7], [2, 5, 8], // columns
        [0, 4, 8], [2, 4, 6]             // diagonals
    ]
    @State private var board = Array(repeating: "", count: 9)
    @State private var currentPlayer: String
    @State private var winner: String? = nil
    @State private var isDraw = false
    @State private var showResultPopup = false
    @Binding var showGame: Bool
    
    init(playerSymbol: String, showGame: Binding<Bool>) {
        self.playerSymbol = playerSymbol
        self._showGame = showGame
        _currentPlayer = State(initialValue: playerSymbol)
    }
    
    var body: some View {
        ZStack{
            VStack(spacing: 0) {
                headerView
                VStack {
                    Spacer()
                    boardGrid
                        .padding(.bottom, 20)
                    HStack {
                        Spacer()
                        resetButtonView
                    }
                    Spacer()
                }
            }
            .padding(30)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .backgroundGradient()
            .navigationBarBackButtonHidden(true)
            .toolbar(.hidden, for: .navigationBar)
            .blur(radius: showResultPopup ? 10 : 0)
            // Result Popup with animation
            if showResultPopup {
                resultPopup
                    .transition(.scale.combined(with: .opacity))
                    .animation(.spring(response: 0.4, dampingFraction: 0.5), value: showResultPopup)
            }
        }
    }
    
    private var headerView: some View {
        VStack{
            Text("SCORE")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(.white)
                .padding([.bottom], 20)
            
            HStack {
                Text("YOU : \(playerSymbol)")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundStyle(currentPlayer == playerSymbol ? Color.yellow : Color.yellow.opacity(0.5))
                
                Spacer()
                
                Text("Player : \(playerSymbol2)")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundStyle(currentPlayer == playerSymbol2 ? Color.mint : Color.mint.opacity(0.5))
            }
        }
    }
    
    private var boardGrid: some View {
        VStack(spacing: 10) {
            ForEach(0..<3, id: \.self) { row in
                HStack(spacing: 10) {
                    ForEach(0..<3, id: \.self) { column in
                        let index = row * 3 + column
                        cellView(at: index)
                    }
                }
            }
        }
    }

    private func cellView(at index: Int) -> some View {
        Button(action: {
            handleTap(at: index)
        }) {
            Text(board[index])
                .font(.system(size: 50))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.white.opacity(0.1))
                .foregroundColor(board[index] == "X" ? .yellow : board[index] == "O" ? .mint : .clear)
                .cornerRadius(10)
        }
        .aspectRatio(1, contentMode: .fit)
    }
    private var resetButtonView: some View {
        Button(action: {
            resetGame()
        }) {
            Image("Reset")
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30) // adjust size as needed
                .foregroundColor(.white).opacity(0.8)
        }
        .padding(.trailing, 0.5)
    }
    private var resultPopup: some View {
        ZStack{
            VStack(spacing: 30) {
                Text(winner != nil ? "\(winner!) Wins!" : "It's a Draw!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .scaleEffect(showResultPopup ? 1 : 0.8)

                HStack(spacing: 20){
                    Button(action: {
                        resetGame()
                    }) {
                        Text("Play Again")
                            .font(.title2)
                            .padding()
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .background(Color(hex: "#2193b0"))
                            .foregroundColor(.white)
                            .clipShape(Capsule())
                            .shadow(color: Color.black.opacity(0.5), radius: 5, x: 0, y: 5)
                    }
                    
                    
                    Button(action: {
                        resetGame()
                        showGame = false
                    }) {
                        Text("Home")
                            .font(.title2)
                            .padding()
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .background(Color(hex: "#2193b0"))
                            .foregroundColor(.white)
                            .clipShape(Capsule())
                        
                            .shadow(color: Color.black.opacity(0.5), radius: 5, x: 0, y: 5)
                    }
                }
                .padding(.horizontal, 20)
            }
        }
        .padding(.vertical, 40)
        .frame(maxWidth: .infinity)
        .background(Color.black.opacity(0.3))
        .cornerRadius(20)
        .padding(.horizontal, 20)
        
        
        
    }
    //MARK: - ACTIONS
    private func handleTap(at index: Int) {
        guard board[index].isEmpty else { return }
        board[index] = currentPlayer
        if checkWin(for: currentPlayer) {
            winner = currentPlayer
                showResultPopup = true
            return
        }
        if !board.contains("") {
            isDraw = true
                showResultPopup = true
            return
        }
        
        currentPlayer = currentPlayer == "X" ? "O" : "X"
    }
    private func checkWin(for symbol: String) -> Bool {
        for combo in winningCombinations {
            if combo.allSatisfy({ board[$0] == symbol }) {
                return true
            }
        }
        return false
    }
    private func resetGame() {
        board = Array(repeating: "", count: 9)
        currentPlayer = playerSymbol
        winner = nil
        isDraw = false
        showResultPopup = false
    }
}

#Preview {
    GameView(playerSymbol: "X", showGame: .constant(false))
}
