//
//  ViewController.swift
//  WeatherAPP
//
//  Created by Анастасия Неверова on 16.02.2024.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {

    //    private let time: String = "12:00"
    private let city: String = "Нижний Новгород"
    private let toDay: String = "Сегодня"
    private let numberMonth: Int = 12
    private let month: String = "августа"
    private let temperature: Int = 30
    private let weather: String = "Ясно"
    private let perceptionOfTemperature: Int = 32
    private let perception: String = "ощущается как"
    private let circle: String = "°"
    
    let topContainer = UIImageView()
    let currentDayLabel = UILabel()
    let currentWeatherIconView = UIImageView()
    let currentTemperatureLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        layoutCurrentWeatherView()
        
//        let labelCity = UILabel(
//            frame: .init(
//                x: 50,
//                y: 70,
//                width: 300, height: 90
//            )
//        )
//        
//        let font = UIFont.boldSystemFont(ofSize: 27)
//
//        let labelToDay = UILabel(
//            frame: .init(
//                x: 70,
//                y: 90,
//                width: 300, height: 90)
//            )
//        
//        var backGraundWeather = UIImageView()
//        var myImage = UIImageView()
//        
//        let backGraundWeatherBlue = UIImage(named: "Group 33510")
//        let backGraundWeatherSun = UIImage(named: "Sun")
//        
//        backGraundWeather = UIImageView(image: backGraundWeatherBlue)
//        myImage = UIImageView(image: backGraundWeatherSun)
//        
//        backGraundWeather.frame = CGRect(x: 25, y: 170, width: 343, height: 280)
//        myImage.frame = CGRect(x: 25, y: 170, width: 343, height: 280)
//        
//        
//        labelCity.text = city
//        labelCity.font = font
//        labelCity.textAlignment = .center
//        labelToDay.text = toDay
//        
//        view.addSubview(labelCity)
//        view.addSubview(labelToDay)
//        view.addSubview(backGraundWeather)
//        view.addSubview(myImage)
        
    }
    
    func layoutCurrentWeatherView() {
        // background image
        view.addSubview(topContainer)
        topContainer.translatesAutoresizingMaskIntoConstraints = false
        
        topContainer.image = UIImage(named: "Group 33510")
        topContainer.contentMode = .scaleAspectFit
        
        NSLayoutConstraint.activate([
            topContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            topContainer.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            topContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            topContainer.heightAnchor.constraint(equalToConstant: 280)
        ])
        
        // text
        topContainer.addSubview(currentDayLabel)
        
        currentDayLabel.translatesAutoresizingMaskIntoConstraints = false
        currentDayLabel.text = "12 May"
        currentDayLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        currentDayLabel.textColor = .white
        currentDayLabel.textAlignment = .center
        
        NSLayoutConstraint.activate([
            currentDayLabel.topAnchor.constraint(equalTo: topContainer.topAnchor, constant: 16),
            currentDayLabel.centerXAnchor.constraint(equalTo: topContainer.centerXAnchor),
            currentDayLabel.leadingAnchor.constraint(greaterThanOrEqualTo: topContainer.leadingAnchor, constant: 50),
            currentDayLabel.trailingAnchor.constraint(greaterThanOrEqualTo: topContainer.trailingAnchor, constant: -50),
        ])
        
        // image
        topContainer.addSubview(currentWeatherIconView)
        currentWeatherIconView.translatesAutoresizingMaskIntoConstraints = false
        
        currentWeatherIconView.image = UIImage(named: "Sun")
        currentWeatherIconView.backgroundColor = .red
        
        NSLayoutConstraint.activate([
            currentWeatherIconView.topAnchor.constraint(equalTo: currentDayLabel.bottomAnchor, constant: 12),
            currentWeatherIconView.centerXAnchor.constraint(equalTo: currentDayLabel.centerXAnchor)
        ])
        
        // temperature label
        
        topContainer.addSubview(currentTemperatureLabel)
        currentTemperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        
        currentTemperatureLabel.text = "30°"
        currentTemperatureLabel.font = .systemFont(ofSize: 40, weight: .bold)
        currentTemperatureLabel.textColor = .white
        
        NSLayoutConstraint.activate([
            currentTemperatureLabel.topAnchor.constraint(equalTo: currentWeatherIconView.bottomAnchor, constant: 10),
            currentTemperatureLabel.centerXAnchor.constraint(equalTo: topContainer.centerXAnchor)
        ])
    }
}

#Preview(traits: .portrait) {
    ViewController()
}
