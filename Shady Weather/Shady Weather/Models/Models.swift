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
    let lon, lat: Double
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
    
}

struct CityModel: Codable {
    
}

