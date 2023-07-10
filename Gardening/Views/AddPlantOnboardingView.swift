//
//  AddPlantOnboardingView.swift
//  Gardening
//
//  Created by Darie-Nistor Nicolae on 10.07.2023.
//

import SwiftUI

struct AddPlantOnboardingView: View {
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    Text("Great! Now, it's time to add some plants into your garden! You can add as many plants as you want")
                        .multilineTextAlignment(.leading)
                        .font(.title2)
                    Spacer()
                }
                .navigationTitle("Garden Name")
                .padding()
            }
        }
    }
}

struct AddPlantOnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        AddPlantOnboardingView()
    }
}
