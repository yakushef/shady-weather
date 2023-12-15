//
//  ContentView.swift
//  Shady Weather
//
//  Created by Aleksey Yakushev on 13.11.2023.
//

import SwiftUI

let testCities = [
    "London",
    "Moscow",
    "Мурманск",
    "Београд"
]

struct WeatherView: View {
    @ObservedObject var viewModel: WeatherViewModel
    
    @State private var showingSearch = false
    @State private var cityName = ""
    
    var body: some View {
        NavigationView{
            ZStack {
                ShaderBackgroundView()
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    viewModel.weatherImage
                        .imageScale(.large)
                    Spacer()
                        .frame(height: 15)
                    Text(viewModel.tempString + "°C")
                        .font(.title3)
                }
                .padding()
            
        }
            .navigationTitle(viewModel.cityName)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing, content: {
                    Button {
                        viewModel.getCurrentWeatherFor(city: testCities.randomElement() ?? "Toronto")
                    } label: {
                        Image(systemName: "mappin.and.ellipse")
                            .imageScale(.large)
                    }
                })
                ToolbarItem(placement: .topBarTrailing, content: {
                    Button {
                        showingSearch = true
                    } label: {
                        Image(systemName: "magnifyingglass")
                            .imageScale(.large)
                    }
                    .alert("Find a place", isPresented: $showingSearch, actions: {
                        TextField("City", text: $cityName)
                        Button("OK", action: {
                            viewModel.getCurrentWeatherFor(city: cityName)
                        })
                        Button("Cancel", role: .cancel, action: {})
                    }, message: {
                        Text("Enter city name below.")
                    })
                })
            }
            .toolbarBackground(.visible, for: .navigationBar)
        }
        .accentColor(.primary)
    }
}

#Preview {
    WeatherView(viewModel: WeatherViewModel())
}

