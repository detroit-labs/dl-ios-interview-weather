import Foundation

protocol CurrentWeatherDelegate: AnyObject {
    func didFetchCurrentWeather(_ weatherService: WeatherService, _ weather: CurrentWeather)
}

protocol ForecastDelegate: AnyObject {
    func didFetchFiveDayForecast(_ weatherService: WeatherService, _ weather: Forecast)
}

struct WeatherService {
    weak var currentWeatherDelegate: CurrentWeatherDelegate?
    weak var forecastDelegate: ForecastDelegate?

    func fetchCurrentWeather() {
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?zip=48226,us&appid=\(Shared.apiKey)&units=imperial")!

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error)
                return
            }

            if let data = data {
                do {
                    let result = try JSONDecoder().decode(CurrentWeather.self, from: data)
                    currentWeatherDelegate?.didFetchCurrentWeather(self, result)
                } catch(let error) {
                    print("error: \(error)")
                }
            }
        }.resume()
    }

    func fetchFiveDayForecast() {
        let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast?zip=48226,us&appid=\(Shared.apiKey)&units=imperial")!

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error)
                return
            }

            if let data = data {
                do {
                    let result = try JSONDecoder().decode(Forecast.self, from: data)
                    forecastDelegate?.didFetchFiveDayForecast(self, result)
                } catch(let error) {
                    print("error: \(error)")
                }
            }
        }.resume()
    }
}
