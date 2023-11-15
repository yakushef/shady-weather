//
//  APIConfig.swift
//  Shady Weather
//
//  Created by Aleksey Yakushev on 13.11.2023.
//

import Foundation

struct Location {
    let latitude: Double
    let longitude: Double
}

struct APIConfig {
    static let apiKey = apiKeyString
    static let endpoint = "https://api.openweathermap.org/data/2.5/"

    static func makeCityCallURLFor(location: Location) -> String {
        let excluded = "minutely"
        return "\(endpoint)/weather?lat=\(location.latitude)&lon=\(location.longitude)&appid=\(apiKey)&units=metric"//&exclude=\(excluded)&units=metric"
    }

    static func makeGeocodingCallURLFor(city: String) -> String {
        return "https://api.openweathermap.org/geo/1.0/direct?q=\(city)&limit=1&appid=\(apiKey)"
    }
}
