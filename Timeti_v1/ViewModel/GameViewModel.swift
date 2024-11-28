//
//  GameViewModel.swift
//  Timeti_v1
//
//  Created by Juliana Pereira de Magalhães on 10/11/24.
//

import SwiftUI

class GameViewModel: ObservableObject {
    @Published var cards: [CardModel] = []  // Lista de todas as cartas carregadas
    @Published var currentCards: [CardModel] = []  // Duas cartas ativas
    @Published var deck: [CardModel] = []  // Baralho embaralhado
    @Published var leftScore: Int = 0  // Placar do lado esquerdo
    @Published var rightScore: Int = 0  // Placar do lado direito
    @Published var gameFinished: Bool = false  // Indica se o jogo terminou
    
    init() {
        startNewGame()  // Inicia um novo jogo ao carregar o ViewModel
    }
    
    private func loadCards() {
        let cardData = loadCardsData()  // Carrega as 57 cartas do JSON
        cards = cardData.map { linha in
            CardModel(images: linha.map { "\($0)" }.shuffled())  // Embaralha as imagens ao criar a carta
        }
    }

    
    private func shuffleDeck() {
        deck = cards.shuffled()  // Embaralha todas as 57 cartas
    }
    
    func startNewGame() {
        loadCards()  // Carrega as cartas novamente
        shuffleDeck()  // Embaralha o baralho
        leftScore = 0  // Reinicia o placar
        rightScore = 0
        gameFinished = false
        drawNewCards()  // Sorteia as primeiras cartas
    }
    
    func drawNewCards() {
        guard deck.count >= 2 else {  // Verifica se há pelo menos 2 cartas no baralho
            gameFinished = true  // Fim do jogo se não houver mais cartas suficientes
            return
        }
        
        // Sorteia 2 cartas do baralho
        currentCards = []
        for _ in 0..<2 {
            currentCards.append(deck.removeFirst())  // Remove a carta do topo do baralho
        }
    }
    
    func flipCurrentCards() {
        for index in currentCards.indices {
            withAnimation(.easeInOut(duration: 0.5)) {
                currentCards[index].isFlipped.toggle()
            }
            
            // Atraso para exibir as figuras
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                withAnimation(.easeIn) {
                    self.currentCards[index].showFigures = true
                }
            }
        }
    }

    
    func checkForMatch() -> String? {
        guard currentCards.count == 2 else { return nil }
        
        let card1Images = Set(currentCards[0].images)
        let card2Images = Set(currentCards[1].images)
        
        return card1Images.intersection(card2Images).first  // Retorna a imagem repetida
    }
    
    func handleTap(on imageName: String, for index: Int) {
        if let matchingImage = checkForMatch(), imageName == matchingImage {
            incrementScore(for: index)
        } else {
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.error)  // Vibração ao clicar na imagem errada
        }
    }
    
    func incrementScore(for index: Int) {
        if index == 0 {  // Carta da direita
            rightScore += 1
        } else if index == 1 {  // Carta da esquerda
            leftScore += 1
        }
        
        // Anima a saída das cartas
        withAnimation(.easeInOut(duration: 0.5)) {
            for i in currentCards.indices {
                currentCards[i].offsetX = UIScreen.main.bounds.width * (i == 0 ? 1 : -1) * 1.5
            }
        }
        
        // Após a animação, sorteia novas cartas
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
            for i in self.currentCards.indices {
                self.currentCards[i].offsetX = 0  // Reseta o offset
            }
            self.drawNewCards()
        }
    }



}
