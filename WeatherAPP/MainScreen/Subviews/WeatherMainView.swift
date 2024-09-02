import UIKit

class WeatherMainView: UIView {
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
    
    override func layoutSubviews() {
        setInitialInfo()
    }
    
    lazy var day1 = WeatherCellGray.WeatherDay(
        date: "13 августа",
        temperature: "25°",
        feelTemperature: "29°",
        dayOfWeek: "пн",
        eachHourForecast: WeatherData.weatherItemsForMonday
    )
    
    lazy var day2 = WeatherCellGray.WeatherDay(
        date: "14 августа",
        temperature: "25°",
        feelTemperature: "26°",
        dayOfWeek: "вт",
        eachHourForecast: WeatherData.weatherItemsForMonday
    )
    
    lazy var day3 = WeatherCellGray.WeatherDay(
        date: "15 августа",
        temperature: "23°",
        feelTemperature: "20°",
        dayOfWeek: "ср",
        eachHourForecast: WeatherData.weatherItemsForMonday
    )
    
    lazy var day4 = WeatherCellGray.WeatherDay(
        date: "16 августа",
        temperature: "25°",
        feelTemperature: "20°",
        dayOfWeek: "чт",
        eachHourForecast: WeatherData.weatherItemsForMonday
    )
    
    func setInitialInfo() {
        weatherCellGray.setWeather(day: day1)
        weatherCellGray2.setWeather(day: day2)
        weatherCellGray3.setWeather(day: day3)
        weatherCellGray4.setWeather(day: day4)
        
        topContainer.isUserInteractionEnabled = true
    }
}

class WeatherData {
    static let weatherItemsForMonday = [
        WeatherItemCell.WeatherItem(time: "12:00", temperature: "25°", emoji: "mini_sun_icon"),
        WeatherItemCell.WeatherItem(time: "15:00", temperature: "25°", emoji: "mini_sun_icon"),
        WeatherItemCell.WeatherItem(time: "18:00", temperature: "25°", emoji: "mini_sun_icon"),
        WeatherItemCell.WeatherItem(time: "21:00", temperature: "21°", emoji: "mini_sun_icon"),
        WeatherItemCell.WeatherItem(time: "01:00", temperature: "20°", emoji: "mini_sun_icon"),
        WeatherItemCell.WeatherItem(time: "04:00", temperature: "18°", emoji: "mini_sun_icon")
    ]
}
