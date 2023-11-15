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
    @State private var cityName = "..." {
        didSet {
            viewModel.getCurrentWeatherFor(city: cityName)
        }
    }
    
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
                        
                    } label: {
                        Image(systemName: "mappin.and.ellipse")
                            .imageScale(.large)
                    }
                })
                ToolbarItem(placement: .topBarTrailing, content: {
                    Button {
                        viewModel.getCurrentWeatherFor(city: testCities.randomElement() ?? "Toronto")
                    } label: {
                        Image(systemName: "magnifyingglass")
                            .imageScale(.large)
                    }
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
