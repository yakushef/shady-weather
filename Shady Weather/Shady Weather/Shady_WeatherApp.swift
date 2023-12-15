//
//  Shady_WeatherApp.swift
//  Shady Weather
//
//  Created by Aleksey Yakushev on 13.11.2023.
//

import SwiftUI

@main
struct Shady_WeatherApp: App {
    @StateObject var weatherVM = WeatherViewModel()
    
    var body: some Scene {
        WindowGroup {
            WeatherView(viewModel: weatherVM)
        }
    }
}
