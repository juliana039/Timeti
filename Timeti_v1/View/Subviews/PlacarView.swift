//
//  PlacarView.swift
//  Timeti_v1
//
//  Created by Juliana Pereira de Magalhães on 27/11/24.
//


import SwiftUI

struct PlacarView: View {
    @ObservedObject var viewModel: GameViewModel
    
    var body: some View {
        VStack{
            HStack(spacing: 16) {
                Text("\(viewModel.leftScore)")
                    .font(.system(size: 23, weight: .bold))
                    .frame(width: 30, height: 25)
                    .foregroundColor(.white) // Cor do texto
                    .padding() // Espaçamento interno
                    .background(
                        Circle()
                            .fill(Color("pointsColor"))
                            .stroke(Color("whiteColor"), lineWidth: 3)
                    ).rotationEffect(.degrees(180))
                Spacer()
            }.padding(.bottom, 25)
                .padding(.horizontal, 20)
            HStack(spacing: 16) {
                Spacer()
                Text("\(viewModel.rightScore)")
                    .font(.system(size: 23, weight: .bold))
                    .frame(width: 30, height: 25)
                    .foregroundColor(.white) // Cor do texto
                    .padding() // Espaçamento interno
                    .background(
                        Circle()
                            .fill(Color("pointsColor"))
                            .stroke(Color("whiteColor"), lineWidth: 3)
                    )
                
            }.padding(.top, 25)
                .padding(.horizontal, 20)
            
        }
    }
    
    
}


#Preview {
    let previewViewModel = GameViewModel()
    previewViewModel.leftScore = 20
    previewViewModel.rightScore = 3
    
    return PlacarView(viewModel: previewViewModel)
}
