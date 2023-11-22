//
//  ContentView.swift
//  WeatherApp
//
//  Created by Максим Шишлов on 21.11.2023.
//

import SwiftUI

struct ContentView: View {
    
    // инициализируем класс LocationManager (@StateObject позволяет получить информацию об обновлении @Published переменных из класса LocationManager
    @StateObject var locationManager = LocationManager()
    
    // инициализируем экземпляр класса с функцией получения погоды
    var weatherManager = WeatherManager()
    
    // создаем объект для хранения погоды
    @State var weather: ResponseBody?
    
    var body: some View {
        VStack {
            
            if let location = locationManager.location {
                if let weather = weather {
                    WeatherView(weather: weather)
                } else {
                    LoadingView()
                        .task {
                            do {
                                weather = try await weatherManager.getCurrentWeather(lat: location.latitude, lon: location.longitude)
                            } catch {
                                print("Error getting weather: \(error)")
                            }
                        }
                }
            } else {
                if locationManager.isLoading {
                    LoadingView()
                } else {
                    WelcomeView()
                        .environmentObject(locationManager)
                }
            }
        }
        .background(Color(hue: 0.656, saturation: 0.787, brightness: 0.356))
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
