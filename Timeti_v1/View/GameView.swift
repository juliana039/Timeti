//
//  GameView.swift
//  Timeti_v1
//
//  Created by Juliana Pereira de Magalhães on 10/11/24.
//

import SwiftUI

struct GameView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var viewModel = GameViewModel()
    @StateObject private var timerViewModel = TimerViewModel() // Instanciado uma vez
    
    @State private var showWinnerAnimation = false // Controla a exibição da animação de vitória
    @State private var winnerSide: String = "" // Lado vencedor ("Cima", "Baixo" ou "Empate")
    
    var body: some View {
        ZStack {
            Constants.backgroundColor
                .ignoresSafeArea()
                //.blur(radius: showWinnerAnimation ? 10 : 0) // Fundo com blur ao finalizar
            Image("padraoBack")
                .resizable()
                .scaledToFill()
                //.frame(width: 200, height: 200)
            
            if showWinnerAnimation {
                ZStack {
                    Color.black.opacity(0.5) // Fundo semi-transparente
                        .edgesIgnoringSafeArea(.all)
                    
                    VStack(spacing: 20) {
                        if winnerSide == "Empate" {
                            // Conteúdo para empate
                            Image("empate")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 200, height: 200)
                            
                            Text("Empate! Que tal uma revanche?")
                                .font(.title)
                                .foregroundColor(.white)
                                .padding(.bottom, 50)
                        } else {
                            // Conteúdo para vitória
                            Image("parabens")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 200, height: 200)
                            
                            Text("Parabéns, você ganhou!")
                                .font(.title)
                                .foregroundColor(.white)
                                .padding(.bottom, 50)
                        }
                        
                        Button(action: {
                            resetGame() // Reinicia o jogo e o cronômetro
                        }) {
                            Text("Reiniciar")
                                .font(.title)
                                .padding()
                                .frame(width: 330, height: 64)
                                .background(Color("buttonColor"))
                                .foregroundColor(.white)
                                .cornerRadius(100)
                                .overlay(  // Adiciona a borda
                                    RoundedRectangle(cornerRadius: 100)
                                        .stroke(Color("whiteColor"), lineWidth: 4)
                                )
                        }.padding(.bottom, 40)
                    }
                    .rotationEffect(winnerSide == "Baixo" ? .degrees(180) : winnerSide == "Empate" ? .degrees(-90) : .degrees(0)) // Rotaciona para "Baixo" ou lateral no empate
                }
            }
else {
                ZStack {
                    VStack {
                        PlacarView(viewModel: viewModel)
                            .padding(.horizontal, 10)
                            .offset(y: 0)
                    }
                    
                    ZStack {
                        // Carta superior
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
                            .rotationEffect(.degrees(180))
                            .offset(y: -UIScreen.main.bounds.height * 0.24)
                        }
                        
                        TimerView(viewModel: timerViewModel) // Compartilha o mesmo ViewModel
                        
                        // Carta inferior
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
                            .rotationEffect(.degrees(0))
                            .offset(y: UIScreen.main.bounds.height * 0.24)
                        }
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                        .foregroundColor(Color("buttonColor"))
                }
            }
        }
        .onReceive(timerViewModel.$isFinished) { isFinished in
            if isFinished {
                determineWinner()
            }
        }
    }
    
    private func determineWinner() {
        // Determina o lado vencedor com base no placar
        if viewModel.leftScore > viewModel.rightScore {
            winnerSide = "Baixo"
        } else if viewModel.rightScore > viewModel.leftScore {
            winnerSide = "Cima"
        } else {
            winnerSide = "Empate" // Tratamento especial para empate
        }
        
        // Exibe a animação de vencedor
        withAnimation {
            showWinnerAnimation = true
        }
    }
    
    private func resetGame() {
        // Reinicia o jogo e o cronômetro
        viewModel.startNewGame()
        timerViewModel.resetTimer() // Reinicia o cronômetro
        timerViewModel.startTimer() // Garante que o cronômetro comece novamente
        withAnimation {
            showWinnerAnimation = false
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
