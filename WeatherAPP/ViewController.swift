//
//  ViewController.swift
//  WeatherAPP
//
//  Created by Анастасия Неверова on 16.02.2024.
//  Edite on 22.05.2024.
//

import UIKit

class ViewController: UIViewController {
    
    let myScrollViewTemperature = UIScrollView()
    let topContainer = UIImageView()
    let currentDayLabel = UILabel()
    let currentWeatherIconView = UIImageView()
    let currentTemperatureLabel = UILabel()
    let currentFeelTemperatureLabel = UILabel()
    let buttomContainer = UIImageView()
    let lastWeatherIconViewGrey = UIImageView()
    let lastTemperatureLabel = UILabel()
    let lastTemperatureLabelBlack = UILabel()
    let lastTimeTemperature = UILabel()
    let rectangle = UIImageView()
    let collectionView = UICollectionView(frame: .zero)
    
    let item = UIBarButtonItem(systemItem: .close)

    override func viewDidLoad() {
        super.viewDidLoad()
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
        
        // background image
        
        view.addSubview(topContainer)
        topContainer.translatesAutoresizingMaskIntoConstraints = false
        
        topContainer.image = UIImage(named: "Group 33510")
        topContainer.contentMode = .scaleAspectFit
        
        NSLayoutConstraint.activate([
            topContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            topContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            topContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
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
        
        view.addSubview(buttomContainer)
        buttomContainer.translatesAutoresizingMaskIntoConstraints = false
        
        buttomContainer.image = UIImage(named: "backgroundGrey")
        buttomContainer.contentMode = .scaleAspectFit
        
        NSLayoutConstraint.activate([
            buttomContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            buttomContainer.topAnchor.constraint(equalTo: topContainer.bottomAnchor, constant: 20),
            buttomContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            buttomContainer.heightAnchor.constraint(equalToConstant: 206)
        ])
        
        // image grey
        
        buttomContainer.addSubview(lastWeatherIconViewGrey)
        lastWeatherIconViewGrey.translatesAutoresizingMaskIntoConstraints = false
        
        lastWeatherIconViewGrey.image = UIImage(named: "mini_sun_icon")
        
        NSLayoutConstraint.activate([
            lastWeatherIconViewGrey.topAnchor.constraint(equalTo: buttomContainer.topAnchor, constant: 18),
            lastWeatherIconViewGrey.rightAnchor.constraint(equalTo: buttomContainer.rightAnchor, constant: -27),
        ])
        
        // text temperature
        
        buttomContainer.addSubview(lastTemperatureLabel)
        lastTemperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        
        lastTemperatureLabel.text = "29°"
        lastTemperatureLabel.font = .systemFont(ofSize: 17, weight: .bold)
        lastTemperatureLabel.textColor = .gray
        
        NSLayoutConstraint.activate([
            lastTemperatureLabel.topAnchor.constraint(equalTo: buttomContainer.topAnchor, constant: 18),
            lastTemperatureLabel.rightAnchor.constraint(equalTo: lastWeatherIconViewGrey.leftAnchor, constant: -16),
            lastTemperatureLabel.centerYAnchor.constraint(equalTo: lastWeatherIconViewGrey.centerYAnchor)
        ])
        
        buttomContainer.addSubview(lastTemperatureLabelBlack)
        lastTemperatureLabelBlack.translatesAutoresizingMaskIntoConstraints = false
        
        lastTemperatureLabelBlack.text = "25°"
        lastTemperatureLabelBlack.font = .systemFont(ofSize: 17, weight: .bold)
        
        NSLayoutConstraint.activate([
            lastTemperatureLabelBlack.topAnchor.constraint(equalTo: buttomContainer.topAnchor, constant: 18),
            lastTemperatureLabelBlack.rightAnchor.constraint(equalTo: lastTemperatureLabel.leftAnchor, constant: -8),
            lastTemperatureLabelBlack.centerYAnchor.constraint(equalTo: lastWeatherIconViewGrey.centerYAnchor)
        ])
        
        buttomContainer.addSubview(lastTimeTemperature)
        lastTimeTemperature.translatesAutoresizingMaskIntoConstraints = false
        
        //        lastTimeTemperature.text = "13 августа, пт"
        //        lastTimeTemperature.font = .systemFont(ofSize: 16, weight: .medium)
        
        let attributedString = NSMutableAttributedString(
            string: "13 августа, пт",
            attributes: [
                .font: UIFont.systemFont(
                    ofSize: 16,
                    weight: .medium
                )
            ])
        
        attributedString.addAttributes(
            [.foregroundColor: UIColor.gray],
            range: NSRange(location: 12, length: 2))
        
        lastTimeTemperature.attributedText = attributedString
        
        NSLayoutConstraint.activate([
            lastTimeTemperature.topAnchor.constraint(equalTo: buttomContainer.topAnchor),
            lastTimeTemperature.centerYAnchor.constraint(equalTo: lastWeatherIconViewGrey.centerYAnchor),
            lastTimeTemperature.leftAnchor.constraint(equalTo: buttomContainer.leftAnchor, constant: 27)
        ])
    
        buttomContainer.addSubview(rectangle)
        rectangle.translatesAutoresizingMaskIntoConstraints = false
        rectangle.image = UIImage(named: "rectangle_icon")
        
        NSLayoutConstraint.activate([
            rectangle.bottomAnchor.constraint(equalTo: buttomContainer.bottomAnchor, constant: -16),
            rectangle.leftAnchor.constraint(equalTo: buttomContainer.leftAnchor, constant: 27)
        ])
        
    }
    
//    func layoutCurrentWeatherViewGrey() {
//        
//      
//    }
}

#Preview(traits: .portrait) {
    ViewController()
}
