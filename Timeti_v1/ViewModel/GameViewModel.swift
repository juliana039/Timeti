//
//  GameViewModel.swift
//  Timeti_v1
//
//  Created by Juliana Pereira de Magalhães on 10/11/24.
//

import SwiftUI


class GameViewModel: ObservableObject {
    @Published var cards: [CardModel] = []
    @Published var currentCards: [CardModel] = []
    @Published var leftScore: Int = 0
    @Published var rightScore: Int = 0
    @Published var gameFinished: Bool = false
    
    init() {
        loadCards()
        drawNewCards()
    }
    
    private func loadCards() {
        let cardData = loadCardsData()
        cards = cardData.map { linha in
            CardModel(images: linha.map { "\($0)" })
        }
    }
    
    func drawNewCards() {
        guard cards.count >= 2 else {
            gameFinished = true
            return
        }
        
        currentCards = []
        for _ in 0..<2 {
            if let card = cards.randomElement() {
                currentCards.append(card)
                cards.removeAll { $0.id == card.id }
            }
        }
    }
    
    func flipCurrentCards() {
        guard !currentCards.isEmpty else { return }  // Certifica que há cartas para virar
        
        for index in currentCards.indices {
            withAnimation(.easeInOut(duration: 0.5)) {
                currentCards[index].rotation += 180
                currentCards[index].isFlipped.toggle()
                currentCards[index].frontOpacity = currentCards[index].isFlipped ? 0 : 1
                currentCards[index].backOpacity = currentCards[index].isFlipped ? 1 : 0
            }
        }
    }

    
    func checkForMatch() -> String? {
        guard currentCards.count == 2 else { return nil }
        
        let card1Images = Set(currentCards[0].images)
        let card2Images = Set(currentCards[1].images)
        
        // Verifica a interseção entre as duas listas de imagens
        return card1Images.intersection(card2Images).first
    }
    
    func handleTap(on imageName: String, for index: Int) {
        // Verifica se a imagem clicada é a repetida
        if let matchingImage = checkForMatch(), imageName == matchingImage {
            incrementScore(for: index)
        } else {
            // Vibra o dispositivo
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.error)
        }
    }
    
    func incrementScore(for index: Int) {
        if index == 0 {
            leftScore += 1
        } else if index == 1 {
            rightScore += 1
        }
        
        withAnimation(.easeInOut(duration: 0.5)) {
            for i in currentCards.indices {
                currentCards[i].offsetX = UIScreen.main.bounds.width * (i == 0 ? -1 : 1) * 1.5
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
            self.drawNewCards()
        }
    }
}
