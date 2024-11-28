//
//  CircularPositions.swift
//  Timeti_v1
//
//  Created by Juliana Pereira de Magalhães on 26/11/24.
//

import SwiftUI

struct CircularCardView: View {
    var card: CardModel
    var onCardTap: () -> Void  // Callback para virar a carta
    var onImageTap: (String) -> Void  // Callback para clique nas imagens
    
    var body: some View {
        ZStack {
            // Rotação 3D apenas para a carta (frente e verso)
            ZStack {
                // Verso da carta
                if !card.isFlipped {
                    Image("CartaCosta1")  // Substitua pelo nome correto do verso
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 300)
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: 0.5)) {
                                onCardTap()  // Ação para virar a carta
                            }
                        }
                } else {
                    // Frente da carta
                    Image("CartaFrente1")  // Substitua pelo nome correto da frente
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 300)
                }
            }
            .rotation3DEffect(
                .degrees(card.isFlipped ? 180 : 0),  // Gira apenas a carta
                axis: (x: 0, y: 1, z: 0)
            )
            
            // Imagens circulares (aparecem com atraso)
            if card.isFlipped && card.showFigures {
                ForEach(0..<card.images.count, id: \.self) { index in
                    Image(card.images[index])
                        .resizable()
                        .scaledToFit()
                        .frame(minWidth: 55, maxWidth: 70, minHeight: 55, maxHeight: 60)
                        .rotationEffect(angleForIndex(index)) // Define a rotação com base no índice

                        .aspectRatio(contentMode: .fit)
                        .position(position(for: index))  // Calcula a posição circular
                        .onTapGesture {
                            withAnimation(.spring()) {
                                onImageTap(card.images[index])  // Ação ao clicar na imagem
                            }
                        }
                        .opacity(card.showFigures ? 1 : 0)  // Controla a opacidade inicial
                        .animation(.easeIn(duration: 0.5), value: card.showFigures)
                }
            }
        }
        .frame(width: 300, height: 300)
        .offset(x: card.offsetX, y: 0)  // Permite animação de saída
        .animation(.easeInOut(duration: 0.5), value: card.offsetX)  // Animação de entrada e saída
    }
    
    // Calcula a posição dos elementos na disposição circular
    func position(for index: Int) -> CGPoint {
        let radius: CGFloat = 100  // Raio do círculo
        let angle = CGFloat(index) * (2 * .pi / CGFloat(card.images.count))  // Ângulo para cada imagem
        let center = CGPoint(x: 155, y: 150)  // Centro da área circular
        let x = center.x + radius * cos(angle)
        let y = center.y + radius * sin(angle)
        return CGPoint(x: x, y: y)
    }
    
    func angleForIndex(_ index: Int) -> Angle {
            switch index {
            case 0: return .degrees(-90)        // Primeira imagem sem rotação
            case 1: return .degrees(-45)     // Segunda imagem inclinada -45 graus
            case 2: return .degrees(0)     // Terceira imagem inclinada -90 graus
            case 3: return .degrees(45)    // Quarta imagem inclinada -135 graus
            case 4: return .degrees(90)    // Quinta imagem inclinada -180 graus
            case 5: return .degrees(135)     // Sexta imagem inclinada 135 graus
            case 6: return .degrees(180)      // Sétima imagem inclinada 90 graus
            case 7: return .degrees(-135)      // Oitava imagem inclinada 45 graus
            default: return .degrees(-90)      // Padrão: sem rotação
            }
        }
}


#Preview {
    CircularCardView(
        card: CardModel(
            images: ["1", "2", "3", "4", "5", "6", "7", "8"],
            isFlipped: true,
            showFigures: true
        ),
        onCardTap: {
            // Callback para teste de virada
            print("Card tapped!")
        },
        onImageTap: { imageName in
            // Callback para teste de clique em imagem
            print("Tapped on image: \(imageName)")
        }
    )
    .previewLayout(.sizeThatFits)
    .padding() // Espaçamento ao redor da view no preview
}
