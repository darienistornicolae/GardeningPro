//
//  OnboardingView.swift
//  Gardening
//
//  Created by Darie-Nistor Nicolae on 02.08.2023.
//

import SwiftUI

class OnboardingViewModel: ObservableObject {
    @AppStorage("isOnboardingCompleted") var isOnboardingCompleted: Bool = false
    @Published var currentPage: Int = 0
}

struct OnboardingView: View {
    @StateObject var viewModel = OnboardingViewModel()

    var body: some View {
        VStack {
            if viewModel.currentPage == 0 {
                CreateGardenOnboardingView(viewModel: CreateGardenOnboardingViewModel())
                    .environmentObject(viewModel)
            } else if viewModel.currentPage == 1 {
                AddPlantOnboardingView(viewModel: AddPlantOnboardingViewModel())
                    .environmentObject(viewModel)
            }
        }
        .animation(.easeIn, value: viewModel.currentPage)
    }
}




struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
