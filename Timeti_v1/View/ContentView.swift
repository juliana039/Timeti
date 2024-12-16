//
//  ContentView.swift
//  Timeti_v1
//
//  Created by Juliana Pereira de Magalhães on 10/11/24.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("hasSeenTutorial") private var hasSeenTutorial: Bool = false
    @State private var navigateToGameView: Bool = false // Controle para GameView
    @State private var navigateToTutorialView: Bool = false // Controle para TutorialView

    var body: some View {
        NavigationStack {
            ZStack {
                Constants.backgroundColor
                    .ignoresSafeArea()

                VStack {
                    Image("padraoCima")
                        .frame(width: 390, height: 420)
                        .scaledToFit()
                    Spacer()
                    Image("padraoBaixo")
                        .frame(width: 390, height: 440)
                        .scaledToFit()
                }

                VStack(spacing: 10) {
                    Spacer()

                    Image("colorido")
                        .resizable()
                        .frame(width: 390, height: 170)
                        .scaledToFit()

                    // Botão "Jogar"
                    Button(action: {
                        if hasSeenTutorial {
                            navigateToGameView = true
                        } else {
                            navigateToTutorialView = true
                        }
                    }) {
                        Text("Jogar")
                            .font(.system(size: 34, weight: .bold))
                            .padding()
                            .frame(width: 330, height: 64)
                            .background(Color("buttonColor"))
                            .foregroundColor(.white)
                            .cornerRadius(100)
                            .overlay(
                                RoundedRectangle(cornerRadius: 100)
                                    .stroke(Color("whiteColor"), lineWidth: 4)
                            )
                    }
                    .padding(.bottom, 15)

                    // Botão "Tutorial"
                    NavigationLink(destination: TutorialView(isNavigatingToGame: $navigateToGameView)) {
                        Text("Tutorial")
                            .font(.system(size: 34, weight: .bold))
                            .padding()
                            .frame(width: 330, height: 64)
                            .background(Color("whiteColor"))
                            .foregroundColor(Color("buttonColor"))
                            .cornerRadius(100)
                            .overlay(
                                RoundedRectangle(cornerRadius: 100)
                                    .stroke(Color("buttonColor"), lineWidth: 4)
                            )
                    }
                    .padding(.bottom, 50)

                    Spacer()
                }
            }
            .navigationDestination(isPresented: $navigateToGameView) {
                GameView()
            }
            .navigationDestination(isPresented: $navigateToTutorialView) {
                TutorialView(isNavigatingToGame: $navigateToGameView)
            }
        }
    }
}



#Preview {
    ContentView()
}

