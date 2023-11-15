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

    static func makeCityCallURLfor(city: String) -> String {
        let location = getGeocodingFor(city: city)
        let call = makeCityCallURLFor(location: location)
        return call
    }

    static private func getGeocodingFor(city: String) -> Location {
        return Location(latitude: Double.random(in: -90...90), longitude: Double.random(in: -180...180))
    }
}
