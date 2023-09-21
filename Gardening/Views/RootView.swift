//
//  RootView.swift
//  Gardening
//
//  Created by Darie-Nistor Nicolae on 25.07.2023.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject var authViewModel: AuthenticationManager
    @AppStorage("isSignUpCompleted") var isSignUpCompleted: Bool = false
    @State private var onboardingStatus: [String: Bool] = [:] // Dictionary to store onboarding status

    let trasition: AnyTransition = .asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading))

    var body: some View {
        Group {
            if authViewModel.userSession != nil {
                if let currentUser = authViewModel.userSession?.uid {
                    let userId = currentUser
                    let isOnboardingCompleted = onboardingStatus[userId] ?? false // Use the dictionary
                    if !isOnboardingCompleted && authViewModel.userSession != nil{
                        OnboardingView()
                            .transition(trasition)
                    } else {
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
                        .transition(trasition)
                    }
                }
            } else {
                LoginView()
            }
        }
        .onAppear {
            // Load onboarding statuses from the dictionary when the view appears
            if let currentUser = authViewModel.userSession?.uid {
                let userId = currentUser
                if let status = onboardingStatus[userId] {
                    isSignUpCompleted = status
                }
            }
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
            .environmentObject(AuthenticationManager())
    }
}

