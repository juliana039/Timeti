//
//  ContentView.swift
//  Timeti_v1
//
//  Created by Juliana Pereira de Magalhães on 10/11/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {  // Isso permite a navegação entre as views
            ZStack {
                Constants.backgroundColor
                    .ignoresSafeArea()
                
                VStack{
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
             
                    
                    
                    NavigationLink(destination: GameView()) {
                        Text("Jogar")
                            .font(.system(size: 34, weight: .bold))
                            .padding()
                            .frame(width: 330, height: 64)
                            .background(Color("buttonColor"))
                            .foregroundColor(.white)
                            .cornerRadius(100)
                            .overlay(  // Adiciona a borda
                                RoundedRectangle(cornerRadius: 100)
                                    .stroke(Color("whiteColor"), lineWidth: 4)
                            )
                    }
                    .padding(.bottom, 15)
                    
                    NavigationLink(destination: TutorialView()) {
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
        }
    }
}

#Preview {
    ContentView()
}

