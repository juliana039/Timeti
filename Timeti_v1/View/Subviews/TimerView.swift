//
//  TimerView.swift
//  Timeti_v1
//
//  Created by Juliana Pereira de Magalhães on 01/12/24.
//

import SwiftUI

struct TimerView: View {
    @ObservedObject var viewModel: TimerViewModel
    
    var body: some View {
        VStack {
            ZStack(alignment: .leading) {
                // Fundo branco da barra
                RoundedRectangle(cornerRadius: 12.5) // Metade da altura para bordas arredondadas
                    .fill(Color.white)
                    .frame(width: 345, height: 25)
                
                // Barra de progresso em rosa
                RoundedRectangle(cornerRadius: 12.5)
                    .fill(Color("timerColor"))
                    .frame(width: (viewModel.progress * 345)-6, height: 20) // Largura proporcional ao progresso
                    .overlay(
                        RoundedRectangle(cornerRadius: 100)
                            .stroke(Color("whiteColor"), lineWidth: 4)
                    )
                    .animation(.easeInOut, value: viewModel.progress)
                    .padding(.horizontal, 6)
            }
            .frame(width: 345, height: 25) // Largura total da barra
            
          
        }
        .padding()
    }
}


#Preview {
    TutorialView()
}
