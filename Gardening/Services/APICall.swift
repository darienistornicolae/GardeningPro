//
//  APICall.swift
//  Gardening
//
//  Created by Darie-Nistor Nicolae on 10.07.2023.
//

import Foundation
import Combine


class APICall: ObservableObject {
    
    func getPlants(plantName: String) async throws -> Data {
        let apiKey: String = "sk-SWhc64a73409f079d1492"
        guard let url = URL(string: "https://perenual.com/api/species-list?key=\(apiKey)&q=\(plantName)") else {
            throw URLError(.badURL)
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return data
        } catch {
            throw error
        }
    }
}
