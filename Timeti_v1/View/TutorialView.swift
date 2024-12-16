//
//  TutorialView.swift
//  Timeti_v1
//
//  Created by Juliana Pereira de Magalhães on 05/12/24.
//

import SwiftUI

struct TutorialView: View {
    @AppStorage("hasSeenTutorial") private var hasSeenTutorial: Bool = false
    @Binding var isNavigatingToGame: Bool // Controle de navegação para GameView

    var body: some View {
        ZStack {
            Constants.backgroundColor
                .ignoresSafeArea()

            VStack {
                Text("Bem-vindo ao Tutorial!")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding()

                TimerView(viewModel: TimerViewModel())

                Spacer()

                Button(action: {
                    hasSeenTutorial = true
                    isNavigatingToGame = true // Dispara a navegação para o jogo
                }) {
                    Text("Jogar")
                        .font(.title)
                        .padding()
                        .frame(width: 200, height: 50)
                        .background(Color("buttonColor"))
                        .foregroundColor(.white)
                        .cornerRadius(25)
                }
            }
        }
    }
}

