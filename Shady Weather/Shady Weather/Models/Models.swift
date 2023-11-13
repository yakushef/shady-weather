//
//  Models.swift
//  Shady Weather
//
//  Created by Aleksey Yakushev on 13.11.2023.
//

import Foundation

// MARK: - WeatherResponseModel
struct WeatherResponseModel: Codable {
    let wind: Wind
    let coord: Coord
    let dt: Int
    let main: Main
    let cod: Int
    let clouds: Clouds
    let base: String
    let visibility: Int
    let sys: Sys
    let id, timezone: Int
    let name: String
    let weather: [Weather]
}

// MARK: - Clouds
struct Clouds: Codable {
    let all: Int
}

// MARK: - Coord
struct Coord: Codable {
    let lon, lat: Int
}

// MARK: - Main
struct Main: Codable {
    let humidity: Int
    let feelsLike, tempMin, tempMax, temp: Double
    let pressure, seaLevel, grndLevel: Int

    enum CodingKeys: String, CodingKey {
        case humidity
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case temp, pressure
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
    }
}

// MARK: - Sys
struct Sys: Codable {
    let sunrise, sunset: Int
}

// MARK: - Weather
struct Weather: Codable {
    let id: Int
    let main, icon, description: String
}

// MARK: - Wind
struct Wind: Codable {
    let speed: Double
    let deg: Int
    let gust: Double
    //
    //struct TemeratureModel: Codable {
    //    var min: Double
    //    var max: Double
    //}
    //
    //struct WeatherConditionModel: Codable {
    //    var id: Int {
    //        0
    //    }
    //    var main: String
    //    var description: String
    //    var icon: String
    //}
    //
    //struct WeatherModel: Codable {
    //      var date: Int
    //    var temperature: Double
    //    var feelsLike: Double
    //    var pressure: Int
    //    var humidity: Int
    //    var dewPoint: Double
    //    var clouds: Int
    //    var windSpeed: Double
    //    var windDeg: Int
    //    var weather: [WeatherConditionModel]
    //    var id: UUID {
    //        UUID()
    //    }
    //
    //    enum CodingKeys: String, CodingKey {
    //        case date = "dt"
    //        case temperature = "temp"
    //        case feelsLike = "feels_like"
    //        case pressure = "pressure"
    //        case humidity = "humidity"
    //        case dewPoint = "dew_point"
    //        case clouds = "clouds"
    //        case windSpeed = "wind_speed"
    //        case windDeg = "wind_deg"
    //        case weather = "weather"
    //    }
    //
    //    init() {
    //        date = 0
    //        temperature = 0.0
    //        feelsLike = 0.0
    //        pressure = 0
    //        humidity = 0
    //        dewPoint = 0.0
    //        clouds = 0
    //        windSpeed = 0.0
    //        windDeg = 0
    //        weather = []
    //    }
    //}
    //
    //struct WeatherDailyModel: Codable {
    //    var date: Int
    //    var temperature: TemeratureModel
    //    var weather: [WeatherConditionModel]
    //    var id: UUID {
    //        UUID()
    //    }
    //
    //    enum CodingKeys: String, CodingKey {
    //        case date = "dt"
    //        case temperature = "temp"
    //        case weather = "weather"
    //    }
    //
    //    init() {
    //        date = 0
    //        temperature = TemeratureModel(min: 0.0, max: 0.0)
    //        weather = [WeatherConditionModel(main: "", description: "", icon: "")]
    //    }
    //}
    //
    //struct WeatherResponseModel: Codable {
    //    var current: WeatherModel
    //    var hourly: [WeatherModel]
    //    var daily: [WeatherDailyModel]
    //}
    
    struct CityModel: Codable {
        
    }
    
}
