//
//  TutorialViewWrapper.swift
//  Timeti_v1
//
//  Created by Juliana Pereira de Magalhães on 16/12/24.
//

import SwiftUI

struct TutorialViewWrapper: View {
    @AppStorage("hasSeenTutorial") private var hasSeenTutorial: Bool = false
    @State private var navigateToGame: Bool = false // Controle de navegação para o GameView

    var body: some View {
        if hasSeenTutorial || navigateToGame {
            GameView()
        } else {
            TutorialView(isNavigatingToGame: $navigateToGame) // Passa o binding corretamente
        }
    }
}


