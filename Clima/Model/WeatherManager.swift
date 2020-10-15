//
//  WeatherManager.swift
//  Clima
//
//  Created by Appnap WS04 on 2/9/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

protocol WeatherManagerDelegate {
    func didUpdateWeather(weather:WeatherModel)
}

struct WeatherManager {
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=56159e49ebd9a38c557472f3d91a5c71&units=Metric"
    var delegate: WeatherManagerDelegate?
    var cityName = ""
    var fetchWeather : String {
        //print(cityName!)
        let stringURL = "\(weatherURL)&q=\(self.cityName)"
        return stringURL
//        performRequest(with:stringURL) 
    }
    
     func getWeatherData(successHandler: @escaping (WeatherModel) -> Void) {
            if let url = URL(string: fetchWeather) {
                
                
                let session = URLSession(configuration: .default)
                let task = session.dataTask(with: url,completionHandler: { (data, response, error) in
                    if error != nil {
                       // self.delegate?.didFailWithError(error: error!)
                        return
                    }
                    
                    if let safeData = data {
                        if let weather = self.parseJSON(safeData) {
                            self.delegate?.didUpdateWeather(weather: weather)
                            successHandler(WeatherModel(conditionId: weather.conditionId, cityName: weather.cityName, temperature: weather.temperature))
                        }
                    }
                })
                task.resume()
            }
        }
    
    func parseJSON(_ weatherData:Data) ->WeatherModel? {
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            print("WeatherName:\(weather.conditionName)")
            print("City Name: \(weather.cityName)")
            print("Temperature: \(weather.temperatureString)")
            
            return weather
        }catch{
            print(error)
            return nil
        }
    }
    
}
