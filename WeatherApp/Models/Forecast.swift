import Foundation

struct Forecast: Decodable {
    let city: City
    let list: [List]
}

struct City: Decodable {
    let name: String
}

struct List: Decodable {
    let dt: Int
    let main: Main
    let weather: [Weather]
    let clouds: Clouds
    let wind: Wind
    let visibility: Int
}
