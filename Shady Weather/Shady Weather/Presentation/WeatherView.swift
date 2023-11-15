//
//  ContentView.swift
//  Shady Weather
//
//  Created by Aleksey Yakushev on 13.11.2023.
//

import Kingfisher
import SwiftUI

struct WeatherView: View {
    @ObservedObject var viewModel: WeatherViewModel
    
    var body: some View {
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
    }
}

#Preview {
    WeatherView(viewModel: WeatherViewModel())
}
