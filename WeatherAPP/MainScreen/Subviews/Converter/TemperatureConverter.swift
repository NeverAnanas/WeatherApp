import Foundation

class TemperatureConverter {
    
    func convertTemperatureToString(temperature: Double) -> String {
        let temperatureInt = Int(temperature)
        let temperatureString = String(temperatureInt) + "°"
        return temperatureString
    }
    
    func convertTemperatureAndAddWeatherState(feelsLike: Double, weatherState: Forecast) -> String {
        let convertTemp = convertTemperatureToString(temperature: feelsLike)
        let weatherStateIndex = weatherState
        let result = weatherStateIndex.main + ", " + "ощущается как " + convertTemp
        
        return result
    }
}
