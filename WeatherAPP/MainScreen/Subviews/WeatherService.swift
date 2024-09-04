import UIKit

struct Forecast: Codable {
    let date: Date
    let temperature: Double
    let description: String
    let feelsLike: Double
    let main: String
    let icon: String
    let id: Int
}

struct WeatherResponse: Codable {
    let list: [APIForecast]
}

struct APIForecast: Codable {
    let dt: Double
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
    let feelsLike: Double
    
    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
    }
}

struct Weather: Codable {
    let textDescription: String // Погодные условия в группе
    let id: Int        // Идникатор погодных условий
    let main: String   // Группа параметров погоды (дождь, снег, облака и т. д.)
    let icon: String   // Идентор значка погоды
    
    enum CodingKeys: String, CodingKey {
        case textDescription = "description"
        case id
        case main
        case icon
    }
}

class WeatherService {
    let apiKey = "800ca88bde916f0238757457c4e63bda"
    let lat = 56
    let lon = 44
    let lang = "ru"

    
    func fetchWeather(for city: String, completion: @escaping ([Forecast]?) -> Void) {
        let baseURL = "https://api.openweathermap.org/data/2.5/forecast?lat=\(lat)&lon=\(lon)&lang=ar&appid=\(apiKey)&units=metric"
        
        guard let url = URL(string: baseURL) else {
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let noOptionalData = data {
                let decoder = JSONDecoder()
                do {
                    let weatherResponse = try decoder.decode(WeatherResponse.self, from: noOptionalData)
                    
                    let forecasts = weatherResponse.list.map { forecastDay in
                        Forecast(
                            date: self.createDate(from: forecastDay.dt),
                            temperature: forecastDay.main.temp,
                            description: forecastDay.main.temp.description,
                            feelsLike: forecastDay.main.feelsLike,
                            main: forecastDay.weather.first?.main ?? "",
                            icon: forecastDay.weather.first?.icon ?? "",
                            id: forecastDay.weather.first?.id ?? 0
                        )
                    }
                    
                    completion(forecasts)
                } catch {
//                    assertionFailure()
                    completion(nil)
                }
            } else {
//                assertionFailure()
                completion(nil)
            }
        }
        
        task.resume()
    }
    
    private func createDate(from unixRepresentation: Double) -> Date {
        var date = Date(timeIntervalSince1970: unixRepresentation)
        let secondsIn3Hours = 60 * 60 * 3
        let timeOffsetForGMT3 = TimeInterval(exactly: secondsIn3Hours)!
        
        date.addTimeInterval(timeOffsetForGMT3)
        return date
    }
}
