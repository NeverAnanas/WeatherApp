import UIKit

struct WeatherData: Codable {
    let temperature: Double
    let description: String
}

class WeatherService {
    let apiKey = "800ca88bde916f0238757457c4e63bda"
    let lat = 56
    let lon = 44

    
    func fetchWeather(for city: String, completion: @escaping (WeatherData?) -> Void) {
        let baseURL = "https://api.openweathermap.org/data/2.5/forecast?lat=\(lat)&lon=\(lon)&appid=\(apiKey)&units=metric"
//        let urlString = "\(baseURL)?q=\(city)&appid=\(apiKey)&units=metric"
        
        guard let url = URL(string: baseURL) else {
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    let weatherResponse = try decoder.decode(WeatherResponse.self, from: data)
                    let weatherData = WeatherData(
                        temperature: weatherResponse.list.first?.main.temp ?? 0.0,
                        description: weatherResponse.list.first?.weather.description ?? ""
                    )
                    completion(weatherData)
                } catch {
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
}

struct WeatherResponse: Codable {
    let list: [ForecastDay]
}

struct ForecastDay: Codable {
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let description: String
}
