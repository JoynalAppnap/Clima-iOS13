//
//  ImageIconDataModel.swift
//  WeatherSimpleExtension
//
//  Created by Appnap WS04 on 7/10/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation
import SwiftUI
import UIKit
struct ImageIconDataModel:View {
    let iconImage:String
    let imageIconHeight: CGFloat
    let imageIconWidth: CGFloat
    let imageIconXPostion: CGFloat
    let imageIconYPosition: CGFloat
    let imageAspectRatio: ContentMode
    var body: some View {
        
        GeometryReader{ geometry in
            Image(systemName: iconImage)
            .resizable()
            .aspectRatio(contentMode: imageAspectRatio)
            .frame(width: (geometry.size.width*imageIconWidth)/100, height: (geometry.size.height*imageIconHeight)/100)
            //.background(Color.green)
            .offset(x: (geometry.size.width*imageIconXPostion)/100, y: (geometry.size.width*imageIconYPosition)/100)
            
        }
    }
}

