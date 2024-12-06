//
//  TutorialView.swift
//  Timeti_v1
//
//  Created by Juliana Pereira de Magalhães on 05/12/24.
//

import SwiftUI

struct TutorialView: View {
    var body: some View {
        ZStack {
            Constants.backgroundColor
                .ignoresSafeArea()
            TimerView(viewModel: TimerViewModel())

        }
    }
}
