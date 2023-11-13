//
//  WeatherService.swift
//  Shady Weather
//
//  Created by Aleksey Yakushev on 13.11.2023.
//

import Combine
import Foundation

extension Data {
    
    func printAsJSON() {
        if let theJSONData = try? JSONSerialization.jsonObject(with: self, options: []) as? NSDictionary {
            var swiftDict: [String: Any] = [:]
            for key in theJSONData.allKeys {
                let stringKey = key as? String
                if let key = stringKey, let keyValue = theJSONData.value(forKey: key) {
                    swiftDict[key] = keyValue
                }
            }
            swiftDict.printAsJSON()
        }
    }
}

public extension Dictionary {
    
    func printAsJSON() {
        if let theJSONData = try? JSONSerialization.data(withJSONObject: self, options: .prettyPrinted),
            let theJSONText = String(data: theJSONData, encoding: String.Encoding.ascii) {
            print("\(theJSONText)")
        }
    }
}

protocol WeatherServiceProtocol {
    var vm: WeatherViewModel? {get set}
    func makeCall()
}

final class WeatherService: WeatherServiceProtocol {
    static var shared = WeatherService()
    var vm: WeatherViewModel? = nil
    private var cancellable = Set<AnyCancellable>()
    
    private init() {}
    
    func makeCall() {
        let url = URL(string: APIConfig.makeCityCallURLFor(location: Location(latitude: 0, longitude: 0)))!
        let publisher = URLSession.shared
            .dataTaskPublisher(for: url)
            .receive(on: DispatchQueue.main)
            .map(\.data)
//            .decode(type: WeatherResponseModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { res in
                print(res)
            }, receiveValue: { [weak self] response in
                response.printAsJSON()
//                print(response)
//                self?.vm?.weather = response
//                print(self?.vm?.weather)
            })
            .store(in: &cancellable)
    }
}
