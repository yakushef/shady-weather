//
//  WeatherViewModel.swift
//  Shady Weather
//
//  Created by Aleksey Yakushev on 13.11.2023.
//

import Combine
import Foundation
import SwiftUI
import SpriteKit

public let numberFormatter = {
    let numberFormatter = NumberFormatter()

    numberFormatter.maximumFractionDigits = 2
    numberFormatter.roundingMode = .halfUp
    numberFormatter.numberStyle = .decimal
    
    return numberFormatter
}()

final class WeatherViewModel: ObservableObject {
    private var service: WeatherServiceProtocol
    
    //TODO: создать модель для вью и конвертировать при назначении? но кто конвертирует и почему (пусть это будет метод модели для показа)
    var weather: WeatherResponseModel? = nil {
        didSet {
            if let weather {
                tempString = numberFormatter.string(from: NSNumber(value: weather.main.temp)) ?? "?"
                temp = weather.main.temp
                
                let newColor = vector_float4(0, 0, colorMap(value: temp), 0)
                if color != newColor {
                    ShaderTransitionController.shared.startTransition(to: newColor)
                    color = newColor
                }
                
                ShaderTransitionController.shared.setWindSpeed(to: weather.wind.speed ?? 1)
                
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
    @Published var temp: Double = 0.0
    @Published var color = vector_float4(0, 0, 1, 0)
    @Published var cityName: String = "..."
    
    var location: Location = Location(latitude: 55.77, longitude: 37.47) {
        didSet {
            getCurrentWeather()
        }
    }
    
    @Published var weatherImage: Image? = Image(systemName: "questionmark.circle.fill")
    
    init(service: WeatherServiceProtocol = WeatherService.shared) {
        self.service = service
        self.service.vm = self
        getCurrentWeather()
    }
    
    func getCurrentWeatherFor(city: String) {
        service.makeCallFor(city: city)
    }
    
    func getCurrentWeather() {
        service.makeCallFor(location: location)
    }
    
    private func colorMap (value: Double, from: ClosedRange<Double> = -10...10, to: ClosedRange<Double> = 0...1) -> Float {
      return Float((value - from.lowerBound) / (from.upperBound - from.lowerBound) * (to.upperBound - to.lowerBound) + to.lowerBound)
    }

}
