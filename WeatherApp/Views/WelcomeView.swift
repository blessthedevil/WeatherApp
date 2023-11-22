//
//  WelcomeView.swift
//  WeatherApp
//
//  Created by Максим Шишлов on 21.11.2023.
//

import SwiftUI
import CoreLocationUI

struct WelcomeView: View {
    
    // @EnvironmentObject используем чтобы неявно подписаться на класс LocationManager для получения данных из класса после инициализации экрана
    @EnvironmentObject var locationManager: LocationManager
    
    var body: some View {
        VStack {
            
            VStack(spacing: 20) {
                
                Text("Добро пожаловать в Погоду!")
                    .bold()
                    .font(.title)
                
                Text("Нажми на кнопку чтобы поделиться твоим местоположением")
                    .padding()
                
            }
            .multilineTextAlignment(.center)
            .padding()
            
            LocationButton(.shareCurrentLocation) {
                locationManager.requestLocation()
            }
            .foregroundStyle(.white)
            .symbolVariant(.fill)
            .clipShape(.capsule)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    WelcomeView()
}
