//
//  WeatherManager.swift
//  WeatherApp
//
//  Created by Максим Шишлов on 21.11.2023.
//

import Foundation
import CoreLocation

class WeatherManager {

    func getCurrentWeather(lat: CLLocationDegrees, lon: CLLocationDegrees) async throws -> ResponseBody {
        
        // создаем юрл для получения данных по координатам и апи ключу
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=d20a25483e0ad689bf8c76f2a44c7bdb&units=metric") else { fatalError("Missing URL") }
        
        // создаем запрос по полученному юрл
        let urlRequest = URLRequest(url: url)
        
        // отправляем запрос и джем получения данных
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        // проверяем полученный код (== 200 – успех :) )
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error while fetching data") }
        
        // Распарсиваем данные
        let decodedData = try JSONDecoder().decode(ResponseBody.self, from: data)
        
        return decodedData
    }
    
}

// Модель для полученных данных (для парсинга)
struct ResponseBody: Decodable {
    var coord: CoordinatesResponse
    var weather: [WeatherResponse]
    var main: MainResponse
    var name: String
    var wind: WindResponse

    struct CoordinatesResponse: Decodable {
        var lon: Double
        var lat: Double
    }

    struct WeatherResponse: Decodable {
        var id: Double
        var main: String
        var description: String
        var icon: String
    }

    struct MainResponse: Decodable {
        var temp: Double
        var feels_like: Double
        var temp_min: Double
        var temp_max: Double
        var pressure: Double
        var humidity: Double
    }
    
    struct WindResponse: Decodable {
        var speed: Double
        var deg: Double
    }
}

extension ResponseBody.MainResponse {
    var feelsLike: Double { return feels_like }
    var tempMin: Double { return temp_min }
    var tempMax: Double { return temp_max }
}
