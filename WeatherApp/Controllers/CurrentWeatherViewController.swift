import UIKit

class CurrentWeatherViewController: UIViewController, CurrentWeatherDelegate {
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var visibilityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var temperatureHighLabel: UILabel!
    @IBOutlet weak var temperatureLowLabel: UILabel!

    var weatherService = WeatherService()

    override func viewDidLoad() {
        super.viewDidLoad()
        weatherService.currentWeatherDelegate = self
        weatherService.fetchCurrentWeather()
    }

    func didFetchCurrentWeather(_ weatherService: WeatherService, _ weather: CurrentWeather) {
        DispatchQueue.main.async {
            self.locationLabel.text = weather.locationName
            self.visibilityLabel.text = weather.weather[0].description
            self.temperatureLabel.text = "\(Int(weather.main.temp))°"
            self.temperatureHighLabel.text = "H:\(Int(weather.main.tempMax))°"
            self.temperatureLowLabel.text = "H:\(Int(weather.main.tempMin))°"
        }
    }
}
