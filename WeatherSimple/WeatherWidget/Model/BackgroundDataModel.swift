//
//  BackgroundDataModel.swift
//  WeatherSimpleExtension
//
//  Created by Appnap WS04 on 7/10/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation
import SwiftUI


struct BackgroundDataModel: View {
    
    let backgroundColor: Color
    let backgroundImage: String
    let backgroundImageWidth: CGFloat
    let backgroundImageHeight: CGFloat
    let backgroundImageXPosition: CGFloat
    let backgroundImageYPosition: CGFloat
    
    var body: some View {
        GeometryReader { geometry in
            Image(backgroundImage)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: (geometry.size.width*backgroundImageWidth)/100, height: (geometry.size.height*backgroundImageHeight)/100)
                .offset(x: (geometry.size.width*backgroundImageXPosition)/100, y: (geometry.size.width*backgroundImageYPosition)/100)
            
        }
    }
}
