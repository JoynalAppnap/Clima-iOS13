//
//  DegreeDataModel.swift
//  WeatherSimpleExtension
//
//  Created by Appnap WS04 on 8/10/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation
import SwiftUI

struct DegreeDataModel: View {
    
    let textColor: Color
    let text: String
    let textSize: CGFloat
    let baseLineOffset: CGFloat
    // let textWidth: CGFloat
    // let textHeight: CGFloat
    let textXPosition: CGFloat
    let textYPosition: CGFloat
    
    var body: some View {
        GeometryReader{ geometry in
            Text(text)
                .font(.callout)
                .font(.system(size: textSize)) // 1.0
                .baselineOffset(baseLineOffset) // 10.0
                .foregroundColor(textColor)
                //.background(Color.green)
                .offset(x: (geometry.size.width*textXPosition)/100, y: (geometry.size.width*textYPosition)/100)
        }
    }
}
