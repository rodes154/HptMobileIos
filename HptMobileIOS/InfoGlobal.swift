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
    
    private static var formatter = DateFormatter()
    
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
    public static func getDataAtual(tipo: String) -> String{
        switch tipo {
        case "simples":
            formatter.dateFormat = "dd/MM/yyyy"
        case "completa":
            formatter.dateFormat = "E, d MMM yyyy"
        case "mesAno":
            formatter.dateFormat = "MMM yyyy"
        case "extensa":
            formatter.dateFormat = "EEEE, d MMMM, yyyy"
        case "extensaHora":
            formatter.dateFormat = "EEEE, d MMMM, yyyy HH:mm:ss"
            
            
        case "dia":
            formatter.dateFormat = "dd"
        case "mes":
            formatter.dateFormat = "MM"
        case "ano":
            formatter.dateFormat = "yyyy"
            
            
            
        default:
            formatter.dateFormat = "dd/MM/yyyy"
        }
        
        
        
        
        return formatter.string(from: dataAtual)
    }
    
    
}
