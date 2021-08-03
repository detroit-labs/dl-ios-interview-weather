import UIKit

class ForecastTableViewController: UITableViewController, ForecastDelegate {
    var weatherService = WeatherService()
    
    var firstDayForecastItems: [List] = []
    var secondDayForecastItems: [List] = []
    var thirdDayForecastItems: [List] = []
    var fourthDayForecastItems: [List] = []
    var fifthDayForecastItems: [List] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        weatherService.forecastDelegate = self
        weatherService.fetchFiveDayForecast()
    }

    func didFetchFiveDayForecast(_ weatherService: WeatherService, _ weather: Forecast) {
        DispatchQueue.main.async {
            var currentDate: Date?
            var currentDateIndex = 0

            for day in weather.list {
                if currentDate == nil {
                    currentDate = Date(timeIntervalSince1970: Double(day.dt))
                } else {
                    let calender = Calendar.current
                    let newDate = Date(timeIntervalSince1970: Double(day.dt))
                    if calender.isDate(currentDate!, inSameDayAs: newDate) {
                        if currentDateIndex == 0 {
                            self.firstDayForecastItems.append(day)
                        } else if currentDateIndex == 1 {
                            self.secondDayForecastItems.append(day)
                        } else if currentDateIndex == 2 {
                            self.thirdDayForecastItems.append(day)
                        } else if currentDateIndex == 3 {
                            self.fourthDayForecastItems.append(day)
                        } else {
                            self.fifthDayForecastItems.append(day)
                        }
                    } else {
                        currentDate = Date(timeIntervalSince1970: Double(day.dt))
                        currentDateIndex += 1
                    }
                }
            }

            self.tableView.reloadData()
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        5
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            if let date = firstDayForecastItems.first?.dt {
                let date = Date(timeIntervalSince1970: Double(date))
                let formatter = DateFormatter()
                formatter.dateFormat = "EEEE, MMM d"
                return formatter.string(from: date)
            }
        case 1:
            if let date = secondDayForecastItems.first?.dt {
                let date = Date(timeIntervalSince1970: Double(date))
                let formatter = DateFormatter()
                formatter.dateFormat = "EEEE, MMM d"
                return formatter.string(from: date)
            }
        case 2:
            if let date = thirdDayForecastItems.first?.dt {
                let date = Date(timeIntervalSince1970: Double(date))
                let formatter = DateFormatter()
                formatter.dateFormat = "EEEE, MMM d"
                return formatter.string(from: date)
            }
        case 3:
            if let date = fourthDayForecastItems.first?.dt {
                let date = Date(timeIntervalSince1970: Double(date))
                let formatter = DateFormatter()
                formatter.dateFormat = "EEEE, MMM d"
                return formatter.string(from: date)
            }
        case 4:
            if let date = fifthDayForecastItems.first?.dt {
                let date = Date(timeIntervalSince1970: Double(date))
                let formatter = DateFormatter()
                formatter.dateFormat = "EEEE, MMM d"
                return formatter.string(from: date)
            }
        default:
            return ""
        }

        return ""
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return firstDayForecastItems.count
        case 1:
            return secondDayForecastItems.count
        case 2:
            return thirdDayForecastItems.count
        case 3:
            return fourthDayForecastItems.count
        case 4:
            return fifthDayForecastItems.count
        default:
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "forecast-cell", for: indexPath)

        if indexPath.section == 0 {
            let time = Date(timeIntervalSince1970: Double(firstDayForecastItems[indexPath.row].dt))
            let formatter = DateFormatter()
            formatter.dateFormat = "h a"
            let timeString = formatter.string(from: time)
            cell.textLabel?.text = "\(timeString): \(Int(firstDayForecastItems[indexPath.row].main.temp))°"
        } else if indexPath.section == 1 {
            let time = Date(timeIntervalSince1970: Double(secondDayForecastItems[indexPath.row].dt))
            let formatter = DateFormatter()
            formatter.dateFormat = "h a"
            let timeString = formatter.string(from: time)
            cell.textLabel?.text = "\(timeString): \(Int(secondDayForecastItems[indexPath.row].main.temp))°"
        } else if indexPath.section == 2 {
            let time = Date(timeIntervalSince1970: Double(thirdDayForecastItems[indexPath.row].dt))
            let formatter = DateFormatter()
            formatter.dateFormat = "h a"
            let timeString = formatter.string(from: time)
            cell.textLabel?.text = "\(timeString): \(Int(thirdDayForecastItems[indexPath.row].main.temp))°"
        } else if indexPath.section == 3 {
            let time = Date(timeIntervalSince1970: Double(fourthDayForecastItems[indexPath.row].dt))
            let formatter = DateFormatter()
            formatter.dateFormat = "h a"
            let timeString = formatter.string(from: time)
            cell.textLabel?.text = "\(timeString): \(Int(fourthDayForecastItems[indexPath.row].main.temp))°"
        } else if indexPath.section == 4 {
            let time = Date(timeIntervalSince1970: Double(fifthDayForecastItems[indexPath.row].dt))
            let formatter = DateFormatter()
            formatter.dateFormat = "h a"
            let timeString = formatter.string(from: time)
            cell.textLabel?.text = "\(timeString): \(Int(fifthDayForecastItems[indexPath.row].main.temp))°"
        }

        return cell
    }
}
