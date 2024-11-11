//
//  GameView.swift
//  Timeti_v1
//
//  Created by Juliana Pereira de Magalhães on 10/11/24.
//

import SwiftUI

struct GameView: View {
    @StateObject private var viewModel = GameViewModel()
    
    var body: some View {
        VStack {
            HStack {
                Text("Placar Esquerda: \(viewModel.leftScore)")
                Spacer()
                Text("Placar Direita: \(viewModel.rightScore)")
            }
            .padding()
            
            HStack(spacing: 40) {
                ForEach(0..<viewModel.cards.count) { index in
                    CardView(card: viewModel.cards[index], index: index) { tappedIndex in
                        viewModel.incrementScore(for: tappedIndex)
                    }
                    .onTapGesture {
                        viewModel.flipCard(at: index)
                    }
                }
            }
            .padding()
        }
    }
}
