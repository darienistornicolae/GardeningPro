//
//  GardenView.swift
//  Gardening
//
//  Created by Darie-Nistor Nicolae on 26.07.2023.
//

import SwiftUI
import Firebase

struct GardenView: View {
    @EnvironmentObject var manager: AuthenticationManager
    @StateObject var viewModel = AddPlantOnboardingViewModel()
    var body: some View {
        NavigationView {
            VStack {
                List(viewModel.plants, id:\.id) { plant in
                    Text(plant.commonName)
                        .foregroundColor(.red)
//
                }
                .cornerRadius(10)
            }
            .navigationTitle("My gardens")
        }
    }
}

struct GardenView_Previews: PreviewProvider {
    static var previews: some View {
        GardenView()
    }
}
