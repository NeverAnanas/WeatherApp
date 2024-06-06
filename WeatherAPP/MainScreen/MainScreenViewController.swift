//
//  ViewController.swift
//  WeatherAPP
//
//  Created by Анастасия Неверова on 16.02.2024.
//  Edite on 22.05.2024.
//

import UIKit

class MainScreenViewController: UIViewController  {
    let weatherCellGray = WeatherCellGray()
    let weatherCellGray2 = WeatherCellGray()
    let weatherCellGray3 = WeatherCellGray()
    let weatherCellGray4 = WeatherCellGray()
    let scrollView = UIScrollView()
    let topContainer = UIImageView()
    let currentDayLabel = UILabel()
    let currentWeatherIconView = UIImageView()
    let currentTemperatureLabel = UILabel()
    let currentFeelTemperatureLabel = UILabel()
    
    lazy var day1 = WeatherCellGray.WeatherDay(
        date: "13 августа",
        temperature: "25°",
        feelTemperature: "29°",
        dayOfWeek: "пн",
        eachHourForecast: weatherItemsForMonday
    )
    
    lazy var day2 = WeatherCellGray.WeatherDay(
        date: "14 августа",
        temperature: "25°",
        feelTemperature: "26°",
        dayOfWeek: "пн",
        eachHourForecast: weatherItemsForMonday
    )
    
    lazy var day3 = WeatherCellGray.WeatherDay(
        date: "15 августа",
        temperature: "23°",
        feelTemperature: "20°",
        dayOfWeek: "пн",
        eachHourForecast: weatherItemsForMonday
    )
    
    lazy var day4 = WeatherCellGray.WeatherDay(
        date: "16 августа",
        temperature: "25°",
        feelTemperature: "20°",
        dayOfWeek: "пн",
        eachHourForecast: weatherItemsForMonday
    )

    let weatherItemsForMonday = [
        WeatherItemCell.WeatherItem(time: "12:00", temperature: "25°", emoji: "mini_sun_icon"),
        WeatherItemCell.WeatherItem(time: "15:00", temperature: "25°", emoji: "mini_sun_icon"),
        WeatherItemCell.WeatherItem(time: "18:00", temperature: "25°", emoji: "mini_sun_icon"),
        WeatherItemCell.WeatherItem(time: "21:00", temperature: "21°", emoji: "mini_sun_icon"),
        WeatherItemCell.WeatherItem(time: "01:00", temperature: "20°", emoji: "mini_sun_icon"),
        WeatherItemCell.WeatherItem(time: "04:00", temperature: "18°", emoji: "mini_sun_icon")
    ]
    
    let weatherItemsForSunday = [
        WeatherItemCell.WeatherItem(time: "12:00", temperature: "25°", emoji: "mini_sun_icon"),
        WeatherItemCell.WeatherItem(time: "15:00", temperature: "25°", emoji: "mini_sun_icon"),
        WeatherItemCell.WeatherItem(time: "18:00", temperature: "25°", emoji: "mini_sun_icon"),
        WeatherItemCell.WeatherItem(time: "21:00", temperature: "21°", emoji: "mini_sun_icon"),
        WeatherItemCell.WeatherItem(time: "01:00", temperature: "20°", emoji: "mini_sun_icon"),
        WeatherItemCell.WeatherItem(time: "04:00", temperature: "18°", emoji: "mini_sun_icon")
    ]
    
    let item = UIBarButtonItem(systemItem: .close)

    // MARK: - ViewDidLoad
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        weatherCellGray.setWeather(day: day1)
        weatherCellGray2.setWeather(day: day2)
        weatherCellGray3.setWeather(day: day3)
        weatherCellGray4.setWeather(day: day4)
        
        topContainer.isUserInteractionEnabled = true

        // navigation Item title (Нижний Новгород)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(buttonTappedAction))
        
        var image = UIImage(named: "search_icon")?.withRenderingMode(.alwaysOriginal)
        var imageSun = UIImage(named: "sun_icon")?.withRenderingMode(.alwaysOriginal)
        var imageMap = UIImage(named: "map_icon")?.withRenderingMode(.alwaysOriginal)
        
        let searhItem = UIBarButtonItem(
            title: "search",
            image: image,
            target: self,
            action: #selector(buttonTappedAction)
        )
        
        let sunItem = UIBarButtonItem(
            title: "sun_icon",
            image: imageSun,
            target: self,
            action: #selector(buttonTappedAction)
        )
        
        sunItem.imageInsets = .init(top: .zero, left: 50, bottom: .zero, right: .zero)
        
        navigationItem.rightBarButtonItems = [searhItem, sunItem]
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "map_icon",
            image: imageMap,
            target: self,
            action: #selector(buttonTappedAction)
        )
        
        navigationItem.title = "Нижний Новгород"
        
        view.backgroundColor = .systemBackground
        
        layoutCurrentWeatherView()
    }
    
    @objc func buttonTappedAction() {
        // TODO: - Add code later
    }
    
    func layoutCurrentWeatherView() {
        
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.alwaysBounceVertical = true 
        scrollView.alwaysBounceHorizontal = false
        scrollView.showsHorizontalScrollIndicator = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        // background image
        
        scrollView.addSubview(topContainer)
        topContainer.translatesAutoresizingMaskIntoConstraints = false
        
        topContainer.image = UIImage(named: "Group 33510")
        topContainer.contentMode = .scaleAspectFill
        
        NSLayoutConstraint.activate([
            topContainer.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            topContainer.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10),
            topContainer.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            topContainer.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            topContainer.heightAnchor.constraint(equalToConstant: 280)
        ])
        
        // text
        
        topContainer.addSubview(currentDayLabel)
        
        currentDayLabel.translatesAutoresizingMaskIntoConstraints = false
        currentDayLabel.text = "Сегодня, 12 августа, чт"
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
        
        NSLayoutConstraint.activate([
            currentWeatherIconView.topAnchor.constraint(equalTo: currentDayLabel.bottomAnchor, constant: 12),
            currentWeatherIconView.centerXAnchor.constraint(equalTo: currentDayLabel.centerXAnchor)
        ])
        
        // temperature label
        
        topContainer.addSubview(currentTemperatureLabel)
        currentTemperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        
        currentTemperatureLabel.text = "30°"
        currentTemperatureLabel.font = .systemFont(ofSize: 48, weight: .bold)
        currentTemperatureLabel.textColor = .white
        
        NSLayoutConstraint.activate([
            currentTemperatureLabel.topAnchor.constraint(equalTo: currentWeatherIconView.bottomAnchor, constant: 10),
            currentTemperatureLabel.centerXAnchor.constraint(equalTo: topContainer.centerXAnchor)
        ])
        
        // feel temperature label
        
        topContainer.addSubview(currentFeelTemperatureLabel)
        currentFeelTemperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        
        currentFeelTemperatureLabel.text = "Ясно, ощущается как 32°"
        currentFeelTemperatureLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        currentFeelTemperatureLabel.textColor = .white
        
        NSLayoutConstraint.activate([
            currentFeelTemperatureLabel.topAnchor.constraint(equalTo: currentTemperatureLabel.bottomAnchor, constant: 2),
            currentFeelTemperatureLabel.centerXAnchor.constraint(equalTo: topContainer.centerXAnchor)
        ])
        
        // background image grey
        
        scrollView.addSubview(weatherCellGray)
        weatherCellGray.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            weatherCellGray.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            weatherCellGray.topAnchor.constraint(equalTo: topContainer.bottomAnchor, constant: 20),
            weatherCellGray.centerXAnchor.constraint(equalTo: topContainer.centerXAnchor),
            weatherCellGray.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            weatherCellGray.heightAnchor.constraint(equalToConstant: 206)
        ])
        
        scrollView.addSubview(weatherCellGray2)
        weatherCellGray2.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            weatherCellGray2.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            weatherCellGray2.topAnchor.constraint(equalTo: weatherCellGray.bottomAnchor, constant: 8),
            weatherCellGray2.centerXAnchor.constraint(equalTo: topContainer.centerXAnchor),
            weatherCellGray2.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            weatherCellGray2.heightAnchor.constraint(equalToConstant: 206)
        ])
        
        scrollView.addSubview(weatherCellGray3)
        weatherCellGray3.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            weatherCellGray3.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            weatherCellGray3.topAnchor.constraint(equalTo: weatherCellGray2.bottomAnchor, constant: 8),
            weatherCellGray3.centerXAnchor.constraint(equalTo: topContainer.centerXAnchor),
            weatherCellGray3.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            weatherCellGray3.heightAnchor.constraint(equalToConstant: 206)
        ])
        
        scrollView.addSubview(weatherCellGray4)
        weatherCellGray4.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            weatherCellGray4.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            weatherCellGray4.topAnchor.constraint(equalTo: weatherCellGray3.bottomAnchor, constant: 8),
            weatherCellGray4.centerXAnchor.constraint(equalTo: topContainer.centerXAnchor),
            weatherCellGray4.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            weatherCellGray4.heightAnchor.constraint(equalToConstant: 206),
            weatherCellGray4.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 10)
        ])
    }
}

#Preview(traits: .portrait) {
    MainScreenViewController()
}
