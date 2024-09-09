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
