//
//  CardModel.swift
//  Timeti_v1
//
//  Created by Juliana Pereira de Magalhães on 10/11/24.
//

import Foundation


struct CardModel: Identifiable {
    let id = UUID()
    var isFlipped: Bool = false
    var frontOpacity: Double = 1.0
    var backOpacity: Double = 0.0
    var rotation: Double = 0.0
    var offsetX: CGFloat = 0.0  // Para armazenar a posição horizontal da carta
}
