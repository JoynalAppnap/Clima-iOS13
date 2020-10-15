//
//  TextDataModel.swift
//  WeatherSimpleExtension
//
//  Created by Appnap WS04 on 7/10/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation
import SwiftUI

struct TextDataModel: View {
    
    let textColor: Color
    let text: String
    let textWidth: CGFloat
    let textHeight: CGFloat
    let textXPosition: CGFloat
    let textYPosition: CGFloat
    let textAlignment: Alignment
    let textSize: CGFloat
    let textFont: Font
    let textFontWeight: Font.Weight
    
    
    var body: some View {
       
        GeometryReader{ geometry in
            Text(text)
                .fontWeight(textFontWeight)
                .foregroundColor(textColor)
                .font(textFont)
                .font(.system(size: textSize))
                .minimumScaleFactor(0.01)
                .frame(width: (geometry.size.width*textWidth)/100, height: (geometry.size.height*textHeight)/100,alignment: textAlignment)
                .offset(x: (geometry.size.width*(textXPosition))/100, y: (geometry.size.width*(textYPosition))/100)
                
            
        }
    }
}

extension Date{
    func formatTime(date: Date)->String{
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        return formatter.string(from: date)
    }
}
