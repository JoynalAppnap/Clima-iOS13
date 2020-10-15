//
//  WeatherSimple.swift
//  WeatherSimple
//
//  Created by Appnap WS04 on 27/9/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import WidgetKit
import SwiftUI
import Intents
//import UIKit
struct weatherEntry: TimelineEntry {
    
    // DataModel Instance Declaration
    let date: Date
    let weatherContent: WeatherModel
    let backgroundDataModel: BackgroundDataModel
    let imageIconDataModel: ImageIconDataModel
    let temperatureDataModel: TextDataModel
    let degreeDataModel: DegreeDataModel
    let celciusDataModel: TextDataModel
    let textDataModel: TextDataModel
    let updatedTime: TextDataModel
    let refreshImageIconDataModel: ImageIconDataModel
 
}

struct Provider: TimelineProvider {
    
    @AppStorage("selectedWeather", store: UserDefaults(suiteName: "group.co.appbrewery.Clima"))
    var selectedWeather: Data = Data()
    func placeholder(in context: Context) -> weatherEntry {
        
        weatherEntry.init(date: Date(),
                          weatherContent: WeatherModel(conditionId: 1, cityName: "Fail", temperature: 0.0),
                          
                          backgroundDataModel: BackgroundDataModel(backgroundColor: .black, backgroundImage: "background", backgroundImageWidth: 100, backgroundImageHeight: 100, backgroundImageXPosition: 0, backgroundImageYPosition: 0),
                          
                          
                          imageIconDataModel: ImageIconDataModel(iconImage: "weather",imageIconHeight: 20, imageIconWidth: 20, imageIconXPostion: 35, imageIconYPosition: 5, imageAspectRatio: .fit),
                          
                          
                          temperatureDataModel: TextDataModel(textColor: .black, text: "27", textWidth: 30, textHeight: 20, textXPosition: 50, textYPosition: 5, textAlignment: .trailing, textSize: 20, textFont: .largeTitle, textFontWeight: .bold),
                          
                          
                          degreeDataModel: DegreeDataModel(textColor: .black, text: "0", textSize: 1.0, baseLineOffset: 10.0, textXPosition: 79.0, textYPosition: 2),
                          
                          
                          celciusDataModel: TextDataModel(textColor: .black, text: "C", textWidth: 30, textHeight: 20, textXPosition: 83.5, textYPosition: 5, textAlignment: .leading, textSize: 70, textFont: .largeTitle, textFontWeight: .bold),
                          
                          
                          textDataModel: TextDataModel(textColor: .black, text: "City Name", textWidth: 50, textHeight: 20, textXPosition: 45, textYPosition: 28, textAlignment: .trailing, textSize: 18, textFont: .headline, textFontWeight: .medium),
                          
                          
                          updatedTime: TextDataModel(textColor: .black, text: "Updated 11:00 AM", textWidth: 80, textHeight: 10, textXPosition: 5, textYPosition: 60, textAlignment: .topTrailing, textSize: 10, textFont: .footnote, textFontWeight: .thin),
                          
                          refreshImageIconDataModel: ImageIconDataModel(iconImage: "refresh",imageIconHeight: 10, imageIconWidth: 10, imageIconXPostion: 88, imageIconYPosition: 59.5, imageAspectRatio: .fit)
                          
        )}
    
    func getSnapshot(in context: Context, completion: @escaping (weatherEntry) -> Void) {
        
        //        var entry: weatherEntry
        //          if let decodedData = try? JSONDecoder().decode(WeatherModel.self, from: selectedWeather) {
        //            entry = weatherEntry(date: Date(), weatherContent: decodedData)
        //        completion(entry)
        //
        //    }
        WeatherManagerEx.getWeatherData(for: "\(getAreaData())") { (success) in
            DispatchQueue.main.async {
                let entries = WeatherModel(conditionId: success.conditionId, cityName: success.cityName, temperature: success.temperature)
                completion(Entry(date: Date(),
                                 weatherContent: entries,
                                 
                                 backgroundDataModel: BackgroundDataModel(backgroundColor: .black, backgroundImage: "background", backgroundImageWidth: 100, backgroundImageHeight: 100, backgroundImageXPosition: 0, backgroundImageYPosition: 0),
                                 
                                 
                                 imageIconDataModel: ImageIconDataModel(iconImage: "weather",imageIconHeight: 20, imageIconWidth: 20, imageIconXPostion: 35, imageIconYPosition: 5, imageAspectRatio: .fit),
                                 
                                
                                 temperatureDataModel: TextDataModel(textColor: .black, text: "27", textWidth: 30, textHeight: 20, textXPosition: 50, textYPosition: 5, textAlignment: .trailing, textSize: 20, textFont: .largeTitle, textFontWeight: .bold),
                                 
                                 
                                 degreeDataModel: DegreeDataModel(textColor: .black, text: "0", textSize: 1.0, baseLineOffset: 10.0, textXPosition: 79.0, textYPosition: 2),
                                 
                                 
                                 celciusDataModel: TextDataModel(textColor: .black, text: "C", textWidth: 30, textHeight: 20, textXPosition: 83.5, textYPosition: 5, textAlignment: .leading, textSize: 70, textFont: .largeTitle, textFontWeight: .bold),
                                 
                                 
                                 textDataModel: TextDataModel(textColor: .black, text: "City Name", textWidth: 50, textHeight: 20, textXPosition: 45, textYPosition: 28, textAlignment: .trailing, textSize: 18, textFont: .headline, textFontWeight: .medium),
                                 
                                
                                 updatedTime: TextDataModel(textColor: .black, text: "Updated 11:00 AM", textWidth: 80, textHeight: 10, textXPosition: 5, textYPosition: 60, textAlignment: .topTrailing, textSize: 10, textFont: .footnote, textFontWeight: .thin),
                                 
                                 refreshImageIconDataModel: ImageIconDataModel(iconImage: "refresh",imageIconHeight: 10, imageIconWidth: 10, imageIconXPostion: 88, imageIconYPosition: 59.5, imageAspectRatio: .fit)
                ))
            }
        }
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<weatherEntry>) -> Void) {
        
        WeatherManagerEx.getWeatherData(for:"\(getAreaData())" ) { success in
            var entries = [Entry]()
            DispatchQueue.main.async {
                for index in 0 ..< 60 {
                    let ent = WeatherModel(conditionId: success.conditionId, cityName: success.cityName, temperature: success.temperature)
                    let date = Calendar.current.date(byAdding: .second, value: index * 1, to: Date())!
                    WidgetCenter.shared.reloadTimelines(ofKind: "WeatherSimple")
                    entries.append(Entry(date: date,
                                         weatherContent: ent,
                                         
                                         backgroundDataModel: BackgroundDataModel(backgroundColor: .black, backgroundImage: "background", backgroundImageWidth: 100, backgroundImageHeight: 100, backgroundImageXPosition: 0, backgroundImageYPosition: 0),
                                         
                                         
                                         imageIconDataModel: ImageIconDataModel(iconImage: "weather",imageIconHeight: 20, imageIconWidth: 20, imageIconXPostion: 35, imageIconYPosition: 5, imageAspectRatio: .fit),
                                         
                                         
                                         temperatureDataModel: TextDataModel(textColor: .black, text: "27", textWidth: 30, textHeight: 20, textXPosition: 50, textYPosition: 5, textAlignment: .trailing, textSize: 20, textFont: .largeTitle, textFontWeight: .bold),
                                         
                                         
                                         degreeDataModel: DegreeDataModel(textColor: .black, text: "0", textSize: 1.0, baseLineOffset: 10.0, textXPosition: 79.0, textYPosition: 2),
                                         
                                         
                                         celciusDataModel: TextDataModel(textColor: .black, text: "C", textWidth: 30, textHeight: 20, textXPosition: 83.5, textYPosition: 5, textAlignment: .leading, textSize: 70, textFont: .largeTitle, textFontWeight: .bold),
                                         
                                         
                                         textDataModel: TextDataModel(textColor: .black, text: "City Name", textWidth: 50, textHeight: 20, textXPosition: 45, textYPosition: 28, textAlignment: .trailing, textSize: 18, textFont: .headline, textFontWeight: .medium),
                                         
                                         
                                         updatedTime: TextDataModel(textColor: .black, text: "Updated 11:00 AM", textWidth: 80, textHeight: 10, textXPosition: 5, textYPosition: 60, textAlignment: .topTrailing, textSize: 10, textFont: .footnote, textFontWeight: .thin),
                                         
                                         refreshImageIconDataModel: ImageIconDataModel(iconImage: "refresh",imageIconHeight: 10, imageIconWidth: 10, imageIconXPostion: 88, imageIconYPosition: 59.5, imageAspectRatio: .fit)
                                         
                    ))
                }
                let timeline = Timeline(entries: entries, policy: .atEnd)
                completion(timeline)
            }
        }
        //        var entry: weatherEntry
        //          if let decodedData = try? JSONDecoder().decode(WeatherModel.self, from: selectedWeather) {
        //            entry = weatherEntry(date: Date(), weatherContent: decodedData)
        //
        //            let timeline = Timeline(entries: [entry], policy: .atEnd)
        //            completion(timeline)
        //    }
    }
    
    // Get Area Name from encoded url
    func getAreaData()->String{
        
        guard let decodedData = try? JSONDecoder().decode(WeatherModel.self, from: selectedWeather) else {
            
            return ""
        }
        return "\(decodedData.cityName)"
    }
}

struct weatherEntryView: View {
    //let textDataModel: TextDataModel
    @Environment(\.widgetFamily) private var widgetFamily
    let entry:Provider.Entry
    var body: some View {
        
        
        ZStack{
            
            if widgetFamily == .systemSmall {
                let degreesChar = "\u{00B0}"
              
                // BackgroundDataModel
                BackgroundDataModel(backgroundColor: entry.backgroundDataModel.backgroundColor, backgroundImage: entry.backgroundDataModel.backgroundImage, backgroundImageWidth: entry.backgroundDataModel.backgroundImageWidth, backgroundImageHeight: entry.backgroundDataModel.backgroundImageHeight, backgroundImageXPosition: entry.backgroundDataModel.backgroundImageXPosition, backgroundImageYPosition: entry.backgroundDataModel.backgroundImageYPosition)
                
                // ImageIconDataModel
                ImageIconDataModel(iconImage: entry.weatherContent.conditionName, imageIconHeight: entry.imageIconDataModel.imageIconHeight, imageIconWidth: entry.imageIconDataModel.imageIconHeight, imageIconXPostion: entry.imageIconDataModel.imageIconXPostion, imageIconYPosition: entry.imageIconDataModel.imageIconYPosition, imageAspectRatio: entry.imageIconDataModel.imageAspectRatio)
                
                // TemperatureDataModel
                TextDataModel(textColor: entry.temperatureDataModel.textColor, text: entry.weatherContent.temperatureString, textWidth: entry.temperatureDataModel.textWidth, textHeight: entry.temperatureDataModel.textHeight, textXPosition: entry.temperatureDataModel.textXPosition, textYPosition: entry.temperatureDataModel.textYPosition,textAlignment: entry.temperatureDataModel.textAlignment, textSize: entry.temperatureDataModel.textSize, textFont: entry.temperatureDataModel.textFont,textFontWeight: entry.temperatureDataModel.textFontWeight)
                
                //DegreeDataModel
                DegreeDataModel(textColor: entry.degreeDataModel.textColor, text: degreesChar, textSize: entry.degreeDataModel.textSize, baseLineOffset: entry.degreeDataModel.baseLineOffset, textXPosition: entry.degreeDataModel.textXPosition, textYPosition: entry.degreeDataModel.textYPosition)
                
                // CelciusDataModel
                TextDataModel(textColor: entry.celciusDataModel.textColor, text: entry.celciusDataModel.text, textWidth: entry.celciusDataModel.textWidth, textHeight: entry.celciusDataModel.textHeight, textXPosition: entry.celciusDataModel.textXPosition, textYPosition: entry.celciusDataModel.textYPosition, textAlignment: entry.celciusDataModel.textAlignment, textSize: entry.celciusDataModel.textSize, textFont: entry.celciusDataModel.textFont, textFontWeight: entry.celciusDataModel.textFontWeight)
                
                // TextDataModel
                TextDataModel(textColor: entry.textDataModel.textColor, text: entry.weatherContent.cityName, textWidth: entry.textDataModel.textWidth, textHeight: entry.textDataModel.textHeight, textXPosition: entry.textDataModel.textXPosition, textYPosition: entry.textDataModel.textYPosition, textAlignment: entry.textDataModel.textAlignment, textSize: entry.textDataModel.textSize, textFont: entry.textDataModel.textFont, textFontWeight: entry.textDataModel.textFontWeight)
                
                // UpdatedTimeDataModel
                TextDataModel(textColor: entry.updatedTime.textColor, text: "Updated \(entry.date.formatTime(date: entry.date))", textWidth: entry.updatedTime.textWidth, textHeight: entry.updatedTime.textHeight, textXPosition: entry.updatedTime.textXPosition, textYPosition: entry.updatedTime.textYPosition, textAlignment: entry.updatedTime.textAlignment, textSize: entry.updatedTime.textSize, textFont: entry.updatedTime.textFont, textFontWeight: entry.updatedTime.textFontWeight)
                
                // RefreshImageIconDataModel
                ImageIconDataModel(iconImage: entry.refreshImageIconDataModel.iconImage, imageIconHeight: entry.refreshImageIconDataModel.imageIconHeight, imageIconWidth: entry.refreshImageIconDataModel.imageIconWidth, imageIconXPostion: entry.refreshImageIconDataModel.imageIconXPostion, imageIconYPosition: entry.refreshImageIconDataModel.imageIconYPosition, imageAspectRatio: entry.refreshImageIconDataModel.imageAspectRatio)
                
            }

        }
        
    }
}



@main
struct WeatherSimple:Widget {
    let kind = "WeatherSimple"
    //var systemData = ".systemSmall"
    var body: some WidgetConfiguration{
        StaticConfiguration(kind: kind, provider: Provider()) { (entry) in
            weatherEntryView(entry: entry)
        }
        .configurationDisplayName("Weather Widget")
        .description("Display weather information")
        //.supportedFamilies([.systemLarge])
    }
}

struct Weather_Previews: PreviewProvider {
    static var previews: some View {
        weatherEntryView(
            
            entry: weatherEntry(date: Date(),
                                
                                weatherContent: WeatherModel(conditionId: 23, cityName: "Dhaka", temperature: 38.5),
                                
                                // BackgroundDataModelEntryPreview
                                backgroundDataModel: BackgroundDataModel(backgroundColor: .black, backgroundImage: "background", backgroundImageWidth: 100, backgroundImageHeight: 100, backgroundImageXPosition: 0, backgroundImageYPosition: 0),
                                
                                // ImageIconDataModelEntryPreview
                                imageIconDataModel: ImageIconDataModel(iconImage: "weather",imageIconHeight: 20, imageIconWidth: 20, imageIconXPostion: 35, imageIconYPosition: 5, imageAspectRatio: .fit),
                                
                                // TemperatureDataModelEntryPreview
                                temperatureDataModel: TextDataModel(textColor: .black, text: "27", textWidth: 30, textHeight: 20, textXPosition: 50, textYPosition: 5, textAlignment: .trailing, textSize: 20, textFont: .largeTitle, textFontWeight: .bold),
                                
                                // DegreeDataModelEntryPreview
                                degreeDataModel: DegreeDataModel(textColor: .black, text: "0", textSize: 1.0, baseLineOffset: 10.0, textXPosition: 79.0, textYPosition: 4),
                                
                                // CelciusDataModelEntryPreview
                                celciusDataModel: TextDataModel(textColor: .black, text: "C", textWidth: 30, textHeight: 20, textXPosition: 83.5, textYPosition: 5, textAlignment: .leading, textSize: 70, textFont: .largeTitle, textFontWeight: .bold),
                                
                                // CelciusDataModelEntryPreview
                                textDataModel: TextDataModel(textColor: .black, text: "City Name", textWidth: 50, textHeight: 20, textXPosition: 45, textYPosition: 28, textAlignment: .trailing, textSize: 18, textFont: .headline, textFontWeight: .medium),
                                
                                // UpdatedDataModelEntryView
                                updatedTime: TextDataModel(textColor: .black, text: "Updated 11:00 AM", textWidth: 80, textHeight: 10, textXPosition: 5, textYPosition: 60, textAlignment: .topTrailing, textSize: 10, textFont: .body, textFontWeight: .thin),
                                
                                refreshImageIconDataModel: ImageIconDataModel(iconImage: "refresh",imageIconHeight: 10, imageIconWidth: 10, imageIconXPostion: 88, imageIconYPosition: 59.5, imageAspectRatio: .fit)
                                
                                
            ))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
        //
        //        weatherEntryView(entry: weatherEntry(date: Date(), weatherContent: WeatherModel(conditionId: 23, cityName: "Dhaka", temperature: 33.5)))
        //            .previewContext(WidgetPreviewContext(family: .systemMedium))
        //        weatherEntryView(entry: weatherEntry(date: Date(), weatherContent: WeatherModel(conditionId: 23, cityName: "Dhaka", temperature: 33.5)))
        //            .previewContext(WidgetPreviewContext(family: .systemLarge))
        
    }
    
}

//
//struct UpdatedTextView: View {
//    var body: some View {
//        GeometryReader{geometry in
//            Text("Updated\(" 11:00 AM")")
//                .minimumScaleFactor(0.01)
//                .frame(width: geometry.size.width/1.5, height: 20)
//                .offset(x: 20, y: geometry.size.height/1.8)
//        }
//    }
//}
//
//struct RefreshImageView: View {
//    var body: some View {
//        GeometryReader{geometry in
//            Image("refresh")
//                .resizable()
//                .aspectRatio(contentMode: .fit)
//                .colorMultiply(.red)
//                .background(Color.white)
//                .frame(width: 30, height: 30, alignment: .trailing)
//                .offset(x: (geometry.size.width)-35, y: geometry.size.height/1.9)
//
//
//        }
//    }
//}





