import UIKit

class TemperatureConverter {
    
    func convertTemperatureToString(temperature: Double) -> String {
        let temperatureInt = Int(temperature)
        let temperatureString = String(temperatureInt) + "°"
        return temperatureString
    }
    
    func convertTemperatureAndAddWeatherState(feelsLike: Double, weatherState: Forecast) -> String {
        let convertTempToString = convertTemperatureToString(temperature: feelsLike)
        let weatherStateIndex = weatherState
        let result = weatherStateIndex.main + ", " + "ощущается как " + convertTempToString
        
        return result
    }
    
    func fontDesignationTemperature(temperature: String) -> NSAttributedString {
        return NSMutableAttributedString(
            string: temperature,
            attributes: [
                .font: UIFont.systemFont(
                    ofSize: 17,
                    weight: .bold
                )]
            )
    }
    
    func fontDesignationFeelsTemperature(feelTemperature: String) -> NSAttributedString {
        return NSMutableAttributedString(
            string: feelTemperature,
            attributes: [
                .font: UIFont.systemFont(
                    ofSize: 17,
                    weight: .bold),
                .foregroundColor: UIColor.gray
            ]
        )
    }
}
