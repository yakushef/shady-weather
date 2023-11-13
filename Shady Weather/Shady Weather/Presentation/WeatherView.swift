//
//  ContentView.swift
//  Shady Weather
//
//  Created by Aleksey Yakushev on 13.11.2023.
//

import SwiftUI

struct WeatherView: View {
    @ObservedObject var viewModel: WeatherViewModel {
        didSet {
            temp = viewModel.weather?.main.temp ?? 0.0
            print(viewModel.weather)
        }
    }
    @State var temp = 0.0
    
    var body: some View {
        VStack {
            Image(systemName: "umbrella")
                .imageScale(.large)
                .foregroundStyle(.foreground)
            Text("\(temp, specifier: "%.2f")")
        }
        .padding()
    }
}

#Preview {
    WeatherView(viewModel: WeatherViewModel())
}
