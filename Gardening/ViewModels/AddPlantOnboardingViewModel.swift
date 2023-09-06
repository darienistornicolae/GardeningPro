//
//  AddPlantOnboardingViewModel.swift
//  Gardening
//
//  Created by Darie-Nistor Nicolae on 28.07.2023.
//

import Foundation
import SwiftUI

class AddPlantOnboardingViewModel: ObservableObject {
    @Published var searchPlantName: String = ""
    @Published var plants: [Datum] = []
    @Published var images: [Int: UIImage] = [:]
    
    private var apiManager = APICall()

    func search(query: String) {
        apiManager.performSearch(query: query) { [self] fetchedPlants in
            self.plants = fetchedPlants
            self.loadImages(for: fetchedPlants)
        }
    }
    
    private func loadImages(for plants: [Datum]) {
        for plant in plants {
            Task {
                guard let imageURL = plant.defaultImage?.regularURL, let url = URL(string: imageURL) else { return }
                if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.images[plant.id] = image
                    }
                }
            }
        }
    }

}
