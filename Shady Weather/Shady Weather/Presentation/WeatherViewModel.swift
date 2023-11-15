//
//  WeatherViewModel.swift
//  Shady Weather
//
//  Created by Aleksey Yakushev on 13.11.2023.
//

import Combine
import Foundation
import SwiftUI

// Create a NumberFormatter object
public let numberFormatter = {
    let numberFormatter = NumberFormatter()

    numberFormatter.maximumFractionDigits = 2
    numberFormatter.roundingMode = .halfUp
    numberFormatter.numberStyle = .decimal
    
    return numberFormatter
}()

final class WeatherViewModel: ObservableObject {
    private var service: WeatherServiceProtocol
    
    var weather: WeatherResponseModel? = nil {
        didSet {
            if let weather {
                tempString = numberFormatter.string(from: NSNumber(value: weather.main.temp)) ?? "?"
                iconURL = "https://openweathermap.org/img/wn/" + (weather.weather.first?.icon ?? "") + ".png"
                let image = {
                    switch weather.weather.first?.icon {
                    case "01d": return Image(systemName: "sun.max")
                    case "01n": return Image(systemName: "moon")
                    case "02d": return Image(systemName: "cloud.sun")
                    case "02n": return Image(systemName: "cloud.moon")
                    case "03d", "03n", "04d", "04n": return Image(systemName: "cloud")
                    case "09d", "09n": return Image(systemName: "cloud.rain")
                    case "10d": return Image(systemName: "cloud.sun.rain")
                    case "10n": return Image(systemName: "cloud.moon.rain")
                    case "11d", "11n": return Image(systemName: "cloud.bolt.rain")
                    case "13d", "13n": return Image(systemName: "cloud.snow")
                    case "50d", "50n": return Image(systemName: "cloud.fog")
                    default: return Image(systemName: "questionmark.circle.fill")
                    }
                }()
                weatherImage = image
                cityName = weather.name
            }
        }
    }
    @Published var iconURL: String = ""
    @Published var tempString: String = "?"
    @Published var cityName: String = "..."
    @Published var weatherImage: Image? = Image(systemName: "questionmark.circle.fill")
    
    init(service: WeatherServiceProtocol = WeatherService.shared) {
        self.service = service
        self.service.vm = self
        getCurrentWeather()
    }
    
    func getCurrentWeatherFor(city: String) {
//        service.makeCallfor
    }
    
    func getCurrentWeather() {
        service.makeCall()
    }
}
