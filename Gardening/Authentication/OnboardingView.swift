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
    @State private var onboardingStatus: [String: Bool] = [:] // Dictionary to track onboarding status
    let transition: AnyTransition = .asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading))
    
    var body: some View {
        VStack {
            if viewModel.isOnboardingCompleted {
                // Transition to the main content, which includes the TabView
                TabView {
                    GardenView()
                        .tabItem {
                            Image(systemName: "camera.macro")
                            Text("Garden")
                        }

                    ProfileView()
                        .tabItem {
                            Image(systemName: "person.fill")
                            Text("Profile")
                        }
                }
                .transition(transition)
            } else {
                // Continue showing the onboarding content
                if viewModel.currentPage == 0 {
                    CreateGardenOnboardingView(viewModel: CreateGardenOnboardingViewModel())
                        .environmentObject(viewModel)
                        .onDisappear {
                            // When the CreateGardenOnboardingView is dismissed, mark this onboarding step as completed
                            let currentUserId = "currentUserId" // Replace with actual user ID
                            onboardingStatus[currentUserId] = true
                        }
                } else if viewModel.currentPage == 1 {
                    AddPlantOnboardingView(viewModel: AddPlantOnboardingViewModel())
                        .environmentObject(viewModel)
                        .onDisappear {
                            // When the AddPlantOnboardingView is dismissed, mark this onboarding step as completed
                            let currentUserId = "currentUserId" // Replace with actual user ID
                            onboardingStatus[currentUserId] = true
                        }
                }
            }
        }
        .animation(.linear, value: viewModel.currentPage)
    }
}






struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
