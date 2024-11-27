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
    var onImageTap: (String, Int) -> Void  // Callback para ação ao clicar nas imagens
    var onCardTap: () -> Void  // Callback para virar a carta
    
    var body: some View {
        ZStack {
            // Verso da carta
            if !card.isFlipped {
                Image("CartaCosta1")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250, height: 250)
                    .onTapGesture {
                        onCardTap()  // Virar as cartas ao tocar
                    }
            }
            
            // Frente da carta
            if card.isFlipped {
                VStack {
                    Image("CartaFrente1")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 250, height: 250)
                    
                    HStack(spacing: 10) {
                        ForEach(card.images, id: \.self) { imageName in
                            Button(action: {
                                onImageTap(imageName, index)
                            }) {
                                Image(imageName)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 50)
                            }
                        }
                    }
                }
                .frame(width: 250, height: 250)
            }
        }
        .rotation3DEffect(
            .degrees(card.rotation),
            axis: (x: 0, y: 1, z: 0)
        )
        .offset(x: card.offsetX, y: 0)  // Aplica deslocamento horizontal para a animação de saída
        .animation(.easeInOut(duration: 0.5), value: card.offsetX)  // Anima a mudança de posição
        .frame(width: 250, height: 250)
    }
}
