//
//  ViewController.swift
//  WeatherAPP
//
//  Created by Анастасия Неверова on 16.02.2024.
//

import UIKit

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
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let labelCity = UILabel(
            frame: .init(
                x: 50,
                y: 70,
                width: 300, height: 90
            )
        )
        
        let font = UIFont.boldSystemFont(ofSize: 27)

        let labelToDay = UILabel(
            frame: .init(
                x: 70,
                y: 90,
                width: 300, height: 90)
            )
        
        var backGraundWeather = UIImageView()
        var myImage = UIImageView()
        
        let backGraundWeatherBlue = UIImage(named: "Group 33510")
        let backGraundWeatherSun = UIImage(named: "Sun")
        
        backGraundWeather = UIImageView(image: backGraundWeatherBlue)
        myImage = UIImageView(image: backGraundWeatherSun)
        
        backGraundWeather.frame = CGRect(x: 25, y: 170, width: 343, height: 280)
        myImage.frame = CGRect(x: 25, y: 170, width: 343, height: 280)
        
        
        
        labelCity.text = city
        labelCity.font = font
        labelCity.textAlignment = .center
        labelToDay.text = toDay
        
        view.addSubview(labelCity)
        view.addSubview(labelToDay)
        view.addSubview(backGraundWeather)
        view.addSubview(myImage)
        
    }
}

#Preview(traits: .portrait) {
    ViewController()
}
