//
//  CardModel.swift
//  Timeti_v1
//
//  Created by Juliana Pereira de Magalhães on 10/11/24.
//

import Foundation


struct CardModel: Identifiable {
    let id = UUID()
    var images: [String] = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", "47", "48", "49", "50", "51", "52", "53", "54", "55", "56", "57"
]
    var isFlipped: Bool = false
    var frontOpacity: Double = 1.0
    var backOpacity: Double = 0.0
    var rotation: Double = 0.0
    var offsetX: CGFloat = 0.0  // Para armazenar a posição horizontal da carta
}
