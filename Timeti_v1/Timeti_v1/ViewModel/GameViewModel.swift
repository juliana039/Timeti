//
//  GameViewModel.swift
//  Timeti_v1
//
//  Created by Juliana Pereira de Magalhães on 10/11/24.
//

import SwiftUI

class GameViewModel: ObservableObject {
    @Published var cards: [CardModel] = [CardModel(), CardModel()]
    @Published var leftScore: Int = 0
    @Published var rightScore: Int = 0

    func flipCard(at index: Int) {
        guard index < cards.count else { return }
        
        withAnimation(.easeInOut(duration: 0.5)) {
            cards[index].rotation += 180
            cards[index].isFlipped.toggle()
        }
        
        withAnimation(.easeInOut(duration: 0.5).delay(0.25)) {
            cards[index].frontOpacity = cards[index].isFlipped ? 0 : 1
            cards[index].backOpacity = cards[index].isFlipped ? 1 : 0
        }
    }
    
    func incrementScore(for index: Int) {
        if index == 0 {
            leftScore += 1
        } else if index == 1 {
            rightScore += 1
        }
        
        // Animação de mover a carta para fora da tela
        withAnimation(.easeInOut(duration: 0.5)) {
            cards[index].offsetX = UIScreen.main.bounds.width * (index == 0 ? -1 : 1) * 1.5  // Move para fora da tela
        }
        
        // Após a animação, reseta a carta e coloca uma nova
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
            withAnimation {
                self.cards[index].offsetX = 0  // Retorna para a posição original
                self.cards[index].isFlipped = false  // Reseta o estado da carta
                self.cards[index].frontOpacity = 1.0
                self.cards[index].backOpacity = 0.0
            }
        }
    }
}
