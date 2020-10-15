//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

//56159e49ebd9a38c557472f3d91a5c71  Api Key

import UIKit
import CoreLocation
import SwiftUI
import WidgetKit
class WeatherViewController: UIViewController, UITextFieldDelegate, WeatherManagerDelegate {
    
    @AppStorage("selectedWeather", store: UserDefaults(suiteName: "group.co.appbrewery.Clima"))
    var selectedWeather: Data = Data()
   // var selectedFamily:Data = Data()
    
    var dataArray = [WeatherModel]()
    var weatherManager = WeatherManager()
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        weatherManager.delegate = self
        searchTextField.delegate = self
    }
    @IBAction func searchingButtonPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
        // print(searchTextField.text!)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        // print(searchTextField.text!)
        searchTextField.endEditing(true)
        return true
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        }
        else {
            searchTextField.placeholder = "Type Something"
            return false
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        // print(searchTextField.text!)
        weatherManager.cityName = textField.text!
        weatherManager.getWeatherData { (action) in
            print(action.cityName)
        }
        
        //weatherManager.getWeatherData(successHandler: WeatherModel)
        //print(weatherModel?.conditionId)
        searchTextField.text = ""
    }
    
    func didUpdateWeather(weather:WeatherModel){
        
        DispatchQueue.main.async{
           let abc = WeatherModel(conditionId: weather.conditionId, cityName: weather.cityName, temperature: weather.temperature)
            let endata = try? JSONEncoder().encode(abc)
            print(abc)
            // self.selectedFamily = "systemLarge"
            WidgetCenter.shared.reloadTimelines(ofKind: "WeatherSimple")
            self.selectedWeather = endata!
//
//            if let userDefaults = UserDefaults(suiteName: "group.co.appbrewery.Clima") {
//                userDefaults.set( data as AnyObject, forKey: "selectedWeather")
//                userDefaults.synchronize()
//            }
//
//            if let userDefaults = UserDefaults(suiteName: "group.co.appbrewery.Clima") {
//                let value1 = userDefaults.object(forKey: "selectedWeather")
//                print("okookkok ---> \(value1.unsafelyUnwrapped)")
//            }
//
            
            
//            do{
//            try JSONEncoder().encode(abc) {return}
//            }
//            catch{
//
//            }
            self.temperatureLabel.text = String(weather.temperatureString)
            self.cityLabel.text = weather.cityName
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
            
        }
        
        
    }
    
    
}

extension WeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            print(lat,lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

