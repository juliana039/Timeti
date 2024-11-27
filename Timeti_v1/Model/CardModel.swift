//
//  CardModel.swift
//  Timeti_v1
//
//  Created by Juliana Pereira de Magalhães on 10/11/24.
//

import Foundation
import CoreGraphics

struct CardModel: Identifiable, Equatable {
    let id = UUID()
    var images: [String] = []
    var isFlipped: Bool = false
    var showFigures: Bool = false  
    var frontOpacity: Double = 1.0
    var backOpacity: Double = 0.0
    var rotation: Double = 0.0
    var offsetX: CGFloat = 0.0  // Para a animação de saída

    static func == (lhs: CardModel, rhs: CardModel) -> Bool {
        return lhs.id == rhs.id
    }
}
