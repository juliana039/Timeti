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
                ZStack {
                    VStack {
                        PlacarView(viewModel: viewModel)
                            //.padding()
                            //.padding(.top, 0)
                            .padding(.horizontal, 10)

                        Spacer()
                    }
                    
                    // Cartas posicionadas no centro
                    ZStack {
                        // Carta da direita
                        if viewModel.currentCards.count > 0 {
                            withAnimation(.easeInOut(duration: 0.5)) {
                                CircularCardView(
                                    card: viewModel.currentCards[1],
                                    onCardTap: {
                                        viewModel.flipCurrentCards()
                                    },
                                    onImageTap: { imageName in
                                        viewModel.handleTap(on: imageName, for: 0)
                                    }
                                )
                                .offset(x: UIScreen.main.bounds.width * 0.25)  // Posiciona à direita
                            }
                        }
                        
                        // Carta da esquerda
                        if viewModel.currentCards.count > 1 {
                            withAnimation(.easeInOut(duration: 0.5)) {
                                CircularCardView(
                                    card: viewModel.currentCards[0],
                                    onCardTap: {
                                        viewModel.flipCurrentCards()
                                    },
                                    onImageTap: { imageName in
                                        viewModel.handleTap(on: imageName, for: 1)
                                    }
                                )
                                .offset(x: -UIScreen.main.bounds.width * 0.25)  // Posiciona à esquerda
                            }
                        }
                    }
                }

            }//else
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        let previewViewModel = GameViewModel()
        previewViewModel.leftScore = 25
        previewViewModel.rightScore = 2
        previewViewModel.currentCards = [
            CardModel(images: ["1", "2", "3", "4", "5", "6", "7", "8"], isFlipped: true),
            CardModel(images: ["8", "12", "13", "14", "15", "16", "17", "18"], isFlipped: true)
        ]
        
        return GameView()
            .environmentObject(previewViewModel) 
    }
}
