//
//  LocationManager.swift
//  WeatherApp
//
//  Created by Максим Шишлов on 21.11.2023.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    let manager = CLLocationManager() // создаем менеджера
    
    @Published var location: CLLocationCoordinate2D? // паблик переменная для хранения координат
    @Published var isLoading = false // булевая переменная для отслеживания процесса получения координат
    
    override init() {
        super.init()
        manager.delegate = self
    }
    
    // функция получения положения
    func requestLocation() {
        isLoading = true
        manager.requestLocation() // вызываем функцию
    }
    
    // функция для обновления координат пользователя
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.location = locations.first?.coordinate
        isLoading = false
    }
    
    // функция для выявления ошибки при загрузке координат 
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Some error:", error)
        isLoading = false
    }
}
