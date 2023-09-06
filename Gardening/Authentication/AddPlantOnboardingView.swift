//
//  AddPlantOnboardingView.swift
//  Gardening
//
//  Created by Darie-Nistor Nicolae on 10.07.2023.
//

import SwiftUI

struct AddPlantOnboardingView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @StateObject var viewModel = AddPlantOnboardingViewModel()
    @State var searchText: String = ""
    @State private var showAlert = false
    @State private var addedPlantName: String?
    @EnvironmentObject var garden: AuthenticationManager
    @AppStorage("isOnboardingCompleted") var isOnboardingCompleted: Bool = false
    @EnvironmentObject var onboardingViewModel: OnboardingViewModel
    
    init(viewModel: @autoclosure @escaping () -> AddPlantOnboardingViewModel) {
        let navBarAppearance = UINavigationBar.appearance()
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        self._viewModel = StateObject(wrappedValue: viewModel())
       
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
                    Text("Great! Now, it's time to add some plants into your garden! You can add as many plants as you want.")
                        .multilineTextAlignment(.leading)
                        .font(.title2)
                        .foregroundColor(.white)
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(.gray)
                        
                        VStack {
                            searchBar
                            
                            List(viewModel.plants, id:\.id) {plant in
                                Button(action: {
                                    Task {
                                        try? await garden.addPlantToGarden(gardenId: garden.currentGarden?.gardenId ?? "", plant: plant)
                                        showAlert = true
                                        addedPlantName = plant.commonName
                                    }
                                }) {
                                    HStack {
                                        if let image = viewModel.images[plant.id] {
                                            Image(uiImage: image)
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 100, height: 100)
                                        } else {
                                            ProgressView()
                                        }

                                        Text(plant.commonName)
                                    }
                                }

                            }
                            .alert(isPresented: $showAlert) {
                                Alert(
                                    title: Text("Plant Added"),
                                    message: addedPlantName.map { Text(" \($0) has been successfully added to your garden.") } ?? Text("Plant added successfully."),
                                    dismissButton: .default(Text("OK"))
                                )
                            }
                            .listRowBackground(Color.black)
                            .listStyle(.plain)
                            .background(Color.gray)
                            .cornerRadius(10)
                            
                            
                            Spacer()
                            Button(action: {
                                onboardingViewModel.currentPage += 1
                                onboardingViewModel.isOnboardingCompleted = true
                            }) {
                                Text("Continue")
                                    .foregroundColor(.white)
                                    .font(.headline)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.green)
                                    .cornerRadius(8)
                            }
                        }
                        
                        .padding()
                    }
                    
                    
                    Spacer()
                }
                .navigationTitle(garden.currentGarden?.gardenName ?? "No name")
                
                .padding()
            }
        }
    }
}

struct AddPlantOnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        AddPlantOnboardingView(viewModel: AddPlantOnboardingViewModel())
            .environmentObject(AuthenticationManager())
    }
}

fileprivate extension AddPlantOnboardingView {
    var searchBar: some View {
        HStack {
            Image(systemName: "magnifyingglass").foregroundColor(.gray)
            TextField("Search plant...", text: $viewModel.searchPlantName)
                .onChange(of: viewModel.searchPlantName) { newValue in
                    viewModel.search(query: newValue)
                }
        }
        .frame(maxWidth: 350)
        .padding(10)
        .background(Color(.systemGray5))
        .cornerRadius(20)
    }
}
