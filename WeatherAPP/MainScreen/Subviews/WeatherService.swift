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

struct WeatherServiceCityResponse: Codable {
    let name: String
}

struct WeatherServiceResponse {
    let city: String
    let forecasts: [Forecast]
}

class WeatherService {
    let apiKey = "800ca88bde916f0238757457c4e63bda"
    let lat: Float = 56.296505
    let lon: Float = 43.936058
    let lang = "ru"
    
    func fetchWeather(for city: String, completion: @escaping (WeatherServiceResponse?) -> Void) {
        let baseURL = "https://api.openweathermap.org/data/2.5/forecast?lat=\(lat)&lon=\(lon)&lang=ar&appid=\(apiKey)&units=metric"
        
        guard let url = URL(string: baseURL) else {
            completion(nil)
            return
        }
        
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 5
        sessionConfig.timeoutIntervalForResource = 5
        
        let task = URLSession(configuration: sessionConfig).dataTask(with: url) { [weak self] data, response, error in
            guard let self else { return }
            
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
                    
                    self.fetchCity(lat: lat, lon: lon) { nameOfCity in
                        guard let nameOfCity else {
                            completion(nil)
                            return
                        }
                        
                        let response = WeatherServiceResponse(city: nameOfCity, forecasts: forecasts)
                        completion(response)
                    }
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
    
    func fetchCity(lat: Float, lon: Float, completion: @escaping (String?) -> Void) {
        let baseURLCiry = "https://api.openweathermap.org/geo/1.0/reverse?lat=\(lat)&lon=\(lon)&limit=1&appid=\(apiKey)"
        guard let urlCity = URL(string: baseURLCiry) else {
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: urlCity) { data, response, error in
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    let cityResponse = try decoder.decode([WeatherServiceCityResponse].self, from: data)
                    completion(cityResponse.first?.name)
                } catch {
                    completion(nil)
                }
            } else {
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
