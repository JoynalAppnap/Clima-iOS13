//
//  WeatherData.swift
//  Clima
//
//  Created by Appnap WS04 on 2/9/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation
struct WeatherData:Codable {
    let name:String
    let weather:[Weather]
    let main:Main
    let coord:Location
}
struct Location:Codable {
    let lon:Double
    let lat:Double
}
struct Weather:Codable {
    let id:Int
    let main:String
    let description:String
    let icon:String
}
struct Main:Codable {
    let temp:Double
    let temp_min:Double
    let temp_max:Double
}
