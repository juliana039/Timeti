//
//  CardView.swift
//  Timeti_v1
//
//  Created by Juliana Pereira de Magalhães on 10/11/24.
//
import SwiftUI

struct CardView: View {
    var card: CardModel
    var index: Int
    var onButtonTap: (Int) -> Void
    
    var body: some View {
        ZStack {
            Image("CartaCosta1")
                .resizable()
                .scaledToFit()
                .frame(width: 250, height: 250)
                .opacity(card.frontOpacity)
            
            Image("CartaFrente1")
                .resizable()
                .scaledToFit()
                .frame(width: 250, height: 250)
                .opacity(card.backOpacity)
            
            if card.isFlipped {
                VStack {
                    HStack(spacing: 10) {
                        ForEach(0..<4) { _ in
                            CircleButton(action: { onButtonTap(index) })
                        }
                    }
                    Spacer().frame(height: 20)
                    HStack(spacing: 10) {
                        ForEach(0..<4) { _ in
                            CircleButton(action: { onButtonTap(index) })
                        }
                    }
                }
            }
        }
        .rotation3DEffect(
            .degrees(card.rotation),
            axis: (x: 0, y: 1, z: 0)
        )
        .offset(x: card.offsetX, y: 0)  // Aplica o deslocamento horizontal para fora da tela
        .animation(.easeInOut(duration: 0.5), value: card.offsetX)  // Anima a mudança de posição
    }
}


