//
//  InfoGlobal.swift
//  HptMobileIOS
//
//  Created by Rodrigo Lotrario on 26/07/17.
//  Copyright © 2017 Rodrigo Lotrario. All rights reserved.
//

import Foundation
import UIKit

class InfoGlobal {
    
    private static var appWidth: CGFloat = 0
    private static var appHeight: CGFloat = 0
    private static var dataAtual = Date()
    
    public static func setWidth(width: CGFloat){
        appWidth = width
    }
    public static func getWidth() -> CGFloat{
        return appWidth
    }
    public static func setHeight(height: CGFloat){
        appHeight = height
    }
    public static func getHeight() -> CGFloat{
        return appHeight
    }
    
    
}
