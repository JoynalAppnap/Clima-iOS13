//
//  CelciusDataModel.swift
//  WeatherSimpleExtension
//
//  Created by Appnap WS04 on 8/10/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation
import SwiftUI

struct CelciusDataModel: View {
    
    let textColor: Color
    let text: String
    let textWidth: CGFloat
    let textHeight: CGFloat
    let textXPosition: CGFloat
    let textYPosition: CGFloat
    
    var body: some View {
        
        GeometryReader{ geometry in
            Text(text)
                .foregroundColor(textColor)
                .font(.body)
                .frame(width: (geometry.size.width*textWidth)/100, height: (geometry.size.height*textHeight)/100)
                .offset(x: (geometry.size.width*(textXPosition))/100, y: (geometry.size.width*(textYPosition))/100)
            
        }
    }
}
