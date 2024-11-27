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
        ZStack {
            Color(red: 0.812, green: 0.847, blue: 0.894)
                .ignoresSafeArea()
            
            if viewModel.gameFinished {
                VStack {
                    Text("Jogo Finalizado!")
                        .font(.largeTitle)
                        .padding()
                    Text("Placar Final:")
                        .font(.title2)
                    Text("Esquerda: \(viewModel.leftScore)")
                    Text("Direita: \(viewModel.rightScore)")
                }
            } else {
                VStack {
                    HStack {
                        Text("Placar Esquerda: \(viewModel.leftScore)")
                        Spacer()
                        Text("Placar Direita: \(viewModel.rightScore)")
                    }
                    .padding()
                    
                    HStack(spacing: 40) {
                        ForEach(0..<viewModel.currentCards.count, id: \.self) { index in
                            CardView(
                                card: viewModel.currentCards[index],
                                index: index,
                                onImageTap: { imageName, tappedIndex in
                                    viewModel.handleTap(on: imageName, for: tappedIndex)
                                },
                                onCardTap: {
                                    viewModel.flipCurrentCards()
                                }
                            )
                        }
                    }
                    .padding()
                }
            }
        }
    }
}
