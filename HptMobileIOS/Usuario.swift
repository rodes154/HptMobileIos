//
//  Usuario.swift
//  HptMobileIOS
//
//  Created by Rodrigo Lotrario on 04/08/17.
//  Copyright © 2017 Rodrigo Lotrario. All rights reserved.
//

import Foundation

class Usuario: NSObject{
    
    var id: String = ""
    var nome: String = ""
    var md5: String = ""
    
    init(JsonDict: Dictionary<String, AnyObject>) {
        
        super.init()
        
        self.setValuesForKeys(JsonDict)
        
        print("\(id)    \(nome)     \(md5)")
        
    }
    
    
}
