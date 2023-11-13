//
//  ContentView.swift
//  Shady Weather
//
//  Created by Aleksey Yakushev on 13.11.2023.
//

import SwiftUI

struct WeatherView: View {
    @ObservedObject var viewModel: WeatherViewModel
    
    var body: some View {
        VStack {
            Image(systemName: "umbrella")
                .imageScale(.large)
                .foregroundStyle(.foreground)
            Text("\(viewModel.weather?.main.temp ?? 0.0)")
        }
        .padding()
    }
}

#Preview {
    WeatherView(viewModel: WeatherViewModel())
}
