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
                Color(red: 0.725, green: 0.780, blue: 0.863)  // Cor de fundo personalizada
                    .ignoresSafeArea()
                VStack(spacing: 10) {
                    Spacer()
                    Image("timeti")
                        .resizable()  // Permite que a imagem seja redimensionada
                        .frame(width: 400, height: 200)  // Define o tamanho desejado
                        .scaledToFit()
                    //                    .renderingMode(.original)
                    //                    .scaledToFit()
                    //                    .aspectRatio(0.9, contentMode: .fit)  // Ajusta a proporção
                    //                    .frame(maxWidth: 250, maxHeight: 250) // Limita o tamanho máximo
                    Spacer()
                    
                    NavigationLink(destination: GameView()) {
                        Text("Jogar")
                            .font(.system(size: 24, weight: .bold))  // Tamanho e peso personalizados
                            .padding()
                            .frame(width: 300, height: 50)  // Define o tamanho do botão
                            .background(Color(red: 0.176, green: 0.361, blue: 0.667)) // Cor personalizada
                        
                            .foregroundColor(.white)  // Cor do texto
                            .cornerRadius(10)  // Bordas arredondadas
                    }
                    .padding(.top, 20)
                    
                    Spacer()
                }
            }
        }
    }
}


#Preview {
    ContentView()
}
