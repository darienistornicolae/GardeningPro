//
//  APICall.swift
//  Gardening
//
//  Created by Darie-Nistor Nicolae on 10.07.2023.
//

import Foundation
import Combine


class APICall: ObservableObject {
    @Published var name: String? = nil
    
    func getPlants(name: String) async throws {
        guard let url = URL(string: "") else { return }
        do {
            try await URLSession.shared.data(from: url)
        } catch <#pattern#> {
            <#statements#>
        }
    }
}
