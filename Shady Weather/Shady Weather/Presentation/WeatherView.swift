//
//  ContentView.swift
//  Shady Weather
//
//  Created by Aleksey Yakushev on 13.11.2023.
//

import SwiftUI

struct WeatherView: View {
    @ObservedObject var viewModel: WeatherViewModel
    
    @State private var showingSearch = false
    @State private var cityName = "..."
    
    var body: some View {
    var temp: Double = Double(viewModel.tempString) ?? 0.0
        
        NavigationView{
            ZStack {
                ShaderBackgroundView(temp: temp)
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
