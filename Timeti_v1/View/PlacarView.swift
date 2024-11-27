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
        HStack(spacing: 16) {
            Text("\(viewModel.leftScore)")
                .font(.title2)
                .frame(width: 30, height: 25)
                .foregroundColor(.white) // Cor do texto
                .padding() // Espaçamento interno
                .background(
                    RoundedRectangle(cornerRadius: 15) // Fundo com cantos arredondados menos pronunciados
                        .fill(Color.blue)
                        .stroke(Color.white, lineWidth: 3)
                )
            Text("\(viewModel.rightScore)")
                .font(.title2)
                .frame(width: 30, height: 25)
                .foregroundColor(.white)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.blue)
                        .stroke(Color.white, lineWidth: 3)
                )
        }
        .padding() // Espaçamento externo
    }


}


#Preview {
    let previewViewModel = GameViewModel()
    previewViewModel.leftScore = 20
    previewViewModel.rightScore = 3
    
    return PlacarView(viewModel: previewViewModel)
}
