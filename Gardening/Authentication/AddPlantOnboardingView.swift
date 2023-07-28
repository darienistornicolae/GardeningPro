//
//  AddPlantOnboardingView.swift
//  Gardening
//
//  Created by Darie-Nistor Nicolae on 10.07.2023.
//

import SwiftUI

struct AddPlantOnboardingView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @State var searchText: String = ""
    @EnvironmentObject var garden: AuthenticationManager
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
                    Text("Great! Now, it's time to add some plants into your garden! You can add as many plants as you want.")
                        .multilineTextAlignment(.leading)
                        .font(.title2)
                        .foregroundColor(.white)
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(.gray)
                        
                        VStack {
                            searchBar
                            List {
                                
                            }
                            .listRowBackground(Color.black)
                            .listStyle(.plain)
                            .background(Color.gray)
                            .cornerRadius(10)
                            
                            
                            Spacer()
                            Button(action: {
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
        AddPlantOnboardingView()
    }
}

fileprivate extension AddPlantOnboardingView {
    var searchBar: some View {
        HStack {
            Image(systemName: "magnifyingglass").foregroundColor(.gray)
            TextField("Search plant...", text: $searchText)
        }
        .frame(maxWidth: 350)
        .padding(10)
        .background(Color(.systemGray5))
        .cornerRadius(20)
    }
}
