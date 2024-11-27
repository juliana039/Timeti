//
//  ImageButtons.swift
//  Timeti_v1
//
//  Created by Juliana Pereira de Magalhães on 10/11/24.
//


import SwiftUI


struct CircleButton: View {
    var action: () -> Void
    
    var body: some View {
        Button(action: {
            action()
        }) {
            Circle()
                .fill(Color.blue)
                .frame(width: 30, height: 30)
        }
    }
}
