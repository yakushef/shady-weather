//
//  WeatherError.swift
//  Shady Weather
//
//  Created by Aleksey Yakushev on 13.11.2023.
//

import Foundation

enum WeatherError: Error {
  case parsing(description: String)
  case network(description: String)
}
