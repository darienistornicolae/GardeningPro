//
//  CreateGardenOnboardingView.swift
//  Gardening
//
//  Created by Darie-Nistor Nicolae on 10.07.2023.
//

import SwiftUI

struct CreateGardenOnboardingView: View {
    @StateObject var viewModel = CreateGardenOnboardingViewModel()
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var garden: AuthenticationManager
    @State var isShowingAddPlantView: Bool = false
    init() {
        let navBarAppearance = UINavigationBar.appearance()
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                if colorScheme == .dark {
                    LinearGradient(colors: [Color.black, Color.green], startPoint: .bottom, endPoint: .top)
                        .ignoresSafeArea(.all)
                } else {
                    LinearGradient(colors: [Color.blue, Color.green], startPoint: .bottom, endPoint: .top)
                        .ignoresSafeArea(.all)
                }
                VStack {
                    Text("Let's create your first garden")
                        .font(.title2)
                        .padding(.top, 30)
                    
                    InputView(text: $viewModel.gardenName, placeholder: "Input your garden name")
                        .foregroundColor(Color(colorScheme == .dark ? .white : .black))
                    Spacer()
                    
                    Button(action: {
                        Task {
                            try await garden.createGarden(gardenName:viewModel.gardenName, plants: [Datum]())
                            isShowingAddPlantView = true
                        }
                    }) {
                        Text("Add Garden")
                            .foregroundColor(.white)
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.green)
                            .cornerRadius(8)
                    }
                    
                }
                .navigationTitle("Hello, Nick!")
                .foregroundColor(.white)
                .padding(20)
                .fullScreenCover(isPresented: $isShowingAddPlantView, content: {
                    AddPlantOnboardingView()
                                })
                .transition(.slide)
            }
        }
    }
}

struct CreateGardenOnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        CreateGardenOnboardingView()
    }
}
