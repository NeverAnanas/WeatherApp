
// TODO: 1. Разбить дни с интервалом в 3 часа
// TODO: 2. Отобразить на экране
// TODO: 3. картинку, день недели

import UIKit

class MainScreenViewController: UIViewController  {
    
    let mainView = WeatherMainView()
    let weatherItemsView = WeatherItemsView()

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

    private var service = WeatherService()
    
    // MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mockDay = WeatherCellGray.WeatherDay(
            date: "15 августа", temperature: "25°", feelTemperature: "29°", dayOfWeek: "пн", eachHourForecast: weatherItemsForMonday)
    
        weatherItemsView.setWeather(days: [mockDay, mockDay, mockDay, mockDay])
        setInitialInfo()
        makeWeatherRequest()
    }
    
    @objc func buttonTappedAction() {
        // TODO: Add some code
    }
    
    private func makeWeatherRequest() {
        service.fetchWeather(for: "Nizhniy Novgorod") { weatherForecast in
            DispatchQueue.main.sync {
                guard let weatherForecast else { return }
                
                var result = self.splitIntoDays(forecasts: weatherForecast)
                print(result)
            }
        }
    }
   
    // MARK: GPT
    
    func convertToDays(forecasts: [Forecast]) -> [WeatherCellGray.WeatherDay] {
        let splitForecasts = splitIntoDays(forecasts: forecasts)
            var weatherDays: [WeatherCellGray.WeatherDay] = []
            
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "ru_RU")
            dateFormatter.dateFormat = "d MMMM"
            
            let dayOfWeekFormatter = DateFormatter()
            dayOfWeekFormatter.locale = Locale(identifier: "ru_RU")
            dayOfWeekFormatter.dateFormat = "EEEE"
            
            let timeFormatter = DateFormatter()
            timeFormatter.locale = Locale(identifier: "ru_RU")
            timeFormatter.dateFormat = "HH:mm"
            
            for dailyForecasts in splitForecasts {
                // Проверяем первый элемент для получения даты
                guard let firstForecast = dailyForecasts.first else { continue }
                
                // Форматируем дату и день недели
                let date = dateFormatter.string(from: firstForecast.date)
                let dayOfWeek = dayOfWeekFormatter.string(from: firstForecast.date)
                
                // Вычисляем средние значения температуры и температуры по ощущениям
                let avgTemperature = dailyForecasts.map { $0.temperature }.reduce(0, +) / Double(dailyForecasts.count)
                let avgFeelsLikeTemperature = dailyForecasts.map { $0.feelsLike }.reduce(0, +) / Double(dailyForecasts.count)
                
                // Форматируем средние значения в строки
                let temperatureString = String(format: "%.1f", avgTemperature)
                let feelTemperatureString = String(format: "%.1f", avgFeelsLikeTemperature)
                
                // Создаем прогнозы для каждого временного интервала
                let eachHourForecast = dailyForecasts.map { forecast in
                    WeatherItemCell.WeatherItem(
                        time: timeFormatter.string(from: forecast.date),
                        temperature: String(format: "%.1f", forecast.temperature),
                        emoji: forecast.icon
                    )
                }
                
                // Создаем WeatherDay и добавляем его в массив
                let weatherDay = WeatherCellGray.WeatherDay(
                    date: date,
                    temperature: temperatureString,
                    feelTemperature: feelTemperatureString,
                    dayOfWeek: dayOfWeek,
                    eachHourForecast: eachHourForecast
                )
                
                weatherDays.append(weatherDay)
            }
            
            return weatherDays
        }
    
    
    private func splitIntoDays(forecasts: [Forecast]) -> [[Forecast]] {
        var previousDate: Date?
        
        var result: [[Forecast]] = []
        var currentDay: [Forecast] = []
        let calendar = Calendar.current
        
        for forecast in forecasts {
            if let previousDate = previousDate {
                let isSameDay = calendar.isDate(forecast.date, inSameDayAs: previousDate)
                if isSameDay {
                    currentDay.append(forecast)
                } else {
                    result.append(currentDay)
                    currentDay = [forecast]
                }
            } else {
                currentDay.append(forecast)
            }
            
            previousDate = forecast.date
        }
        // добавляем последний массив, если он не пуст
        if !currentDay.isEmpty {
            result.append(currentDay)
        }
        
        return result
    }
    
    // MARK: GPT end
    
    func setInitialInfo() {
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
        
        setFeelsLikeTemperature(description: "Ясно", temp: "35")
        
        view.addSubview(weatherItemsView)
        weatherItemsView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            weatherItemsView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            weatherItemsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            weatherItemsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            weatherItemsView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setToday(number: String, month: String, dayWeek: String) {
        let todayText = "Сегодня"
        let text = NSMutableAttributedString(
            string: todayText + ", ",
            attributes: [
                .font: UIFont.systemFont(
                    ofSize: 14,
                    weight: .semibold),
                .foregroundColor: UIColor.white
            ])
        
        let numberText = NSMutableAttributedString(
            string: number + " ",
            attributes: [
                .font: UIFont.systemFont(
                    ofSize: 14,
                    weight: .semibold),
                .foregroundColor: UIColor.white
            ])
        
        let monthText = NSMutableAttributedString(
            string: month + ", ",
            attributes: [
                .font: UIFont.systemFont(
                    ofSize: 14,
                    weight: .semibold),
                .foregroundColor: UIColor.white
            ])
        
        let dayWeekText = NSMutableAttributedString(
            string: dayWeek,
            attributes: [
                .font: UIFont.systemFont(
                    ofSize: 14,
                    weight: .semibold),
                .foregroundColor: UIColor.white
            ])
        text.append(numberText)
        text.append(monthText)
        text.append(dayWeekText)
    }
    
    private func setFeelsLikeTemperature(description: String, temp: String) {
        let feels = "ощущается как"
        
        let text = NSMutableAttributedString(
            string: description + ", ",
            attributes: [
                .font: UIFont.systemFont(
                    ofSize: 14,
                    weight: .bold),
                .foregroundColor: UIColor.white
            ])
        
        let feelLike = NSMutableAttributedString(
            string: feels + " ",
            attributes: [
                .font: UIFont.systemFont(
                    ofSize: 14,
                    weight: .bold),
                .foregroundColor: UIColor.white
            ])
        
        
        let temperatureFeelsLike = NSMutableAttributedString(
            string: temp + "°",
            attributes: [
                .font:UIFont.systemFont(
                    ofSize: 14,
                    weight: .bold),
                .foregroundColor: UIColor.white
            ])
        
        text.append(feelLike)
        text.append(temperatureFeelsLike)
        
        // 2
        mainView.currentFeelTemperatureLabel.attributedText = text
    }
}

#Preview(traits: .portrait) {
    MainScreenViewController()
}
