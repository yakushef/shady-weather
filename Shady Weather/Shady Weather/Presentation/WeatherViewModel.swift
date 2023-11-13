//
//  WeatherViewModel.swift
//  Shady Weather
//
//  Created by Aleksey Yakushev on 13.11.2023.
//

import Combine
import Foundation

final class WeatherViewModel: ObservableObject {
    private var service: WeatherServiceProtocol
    
    @Published var weather: WeatherResponseModel? = nil
    
    init(service: WeatherServiceProtocol = WeatherService.shared) {
        self.service = service
        self.service.vm = self
        getCurrentWeather()
    }

    func getCurrentWeather() {
        service.makeCall()
    }
}
