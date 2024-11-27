//
//  DataLoader.swift
//  Timeti_v1
//
//  Created by Juliana Pereira de Magalhães on 26/11/24.
//

import Foundation

// Estrutura para decodificar o JSON
struct CardsData: Codable {
    let cartas: [[Int]]
}

// Função para carregar o JSON
func loadCardsData() -> [[Int]] {
    guard let url = Bundle.main.url(forResource: "cartas", withExtension: "json") else {
        fatalError("Arquivo cartas.json não encontrado no projeto.")
    }
    
    do {
        let data = try Data(contentsOf: url) // Lê o arquivo JSON
        let decodedData = try JSONDecoder().decode(CardsData.self, from: data) // Decodifica o JSON para o modelo
        return decodedData.cartas
    } catch {
        fatalError("Erro ao carregar o JSON: \(error)")
    }
}


