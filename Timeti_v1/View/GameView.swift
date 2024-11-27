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
                    
                    Button(action: {
                        viewModel.startNewGame()  // Reinicia o jogo
                    }) {
                        Text("Jogar Novamente")
                            .font(.title)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding(.top, 20)
                }
            } else {
                VStack {
                    // Placar no topo
                    HStack {
                        Text("Placar Esquerda: \(viewModel.leftScore)")
                        Spacer()
                        Text("Placar Direita: \(viewModel.rightScore)")
                    }
                    .padding()
                    
                    Spacer()
                    
                    // Cartas posicionadas
                    ZStack {
                        // Primeira carta (direita)
                        if viewModel.currentCards.count > 0 {
                            CircularCardView(
                                card: viewModel.currentCards[1],
                                onCardTap: {
                                    viewModel.flipCurrentCards()
                                },
                                onImageTap: { imageName in
                                    viewModel.handleTap(on: imageName, for: 0)
                                }
                            )
                            .offset(x: UIScreen.main.bounds.width * 0.25)  // Animação inicial para direita
                            .animation(.easeInOut(duration: 0.5))  // Animação de entrada
                        }
                        
                        // Segunda carta (esquerda)
                        if viewModel.currentCards.count > 1 {
                            CircularCardView(
                                card: viewModel.currentCards[0],
                                onCardTap: {
                                    viewModel.flipCurrentCards()
                                },
                                onImageTap: { imageName in
                                    viewModel.handleTap(on: imageName, for: 1)
                                }
                            )
                            .offset(x: -UIScreen.main.bounds.width * 0.25)  // Animação inicial para esquerda
                            .animation(.easeInOut(duration: 0.5))  // Animação de entrada
                        }
                    }
                    
                    Spacer()
                }
            }
        }
    }
}
