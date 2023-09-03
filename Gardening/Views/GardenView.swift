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
    var body: some View {
        NavigationView {
            VStack {
                if let garden = manager.currentGarden {
                    Text(garden.gardenName)
                }
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
