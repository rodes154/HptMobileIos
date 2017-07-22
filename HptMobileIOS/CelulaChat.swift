//
//  CelulaChat.swift
//  HptMobileIOS
//
//  Created by Rodrigo Lotrario on 05/07/17.
//  Copyright © 2017 Rodrigo Lotrario. All rights reserved.
//

import UIKit

class CelulaChat: UITableViewCell{
    
    @IBOutlet weak var labelRemoto: UILabel!
    @IBOutlet weak var labelLocal: UILabel!
    @IBOutlet weak var viewLocal: UIView!
    @IBOutlet weak var viewRemoto: UIView!
    
    
    
    
    func load(){
        viewLocal.layer.masksToBounds = true
        viewLocal.layer.cornerRadius = 10
        viewRemoto.layer.masksToBounds = true
        viewRemoto.layer.cornerRadius = 10
        
        
        labelRemoto.lineBreakMode = .byWordWrapping
        labelRemoto.sizeToFit()
        labelLocal.lineBreakMode = .byWordWrapping
        labelLocal.sizeToFit()
        
        viewLocal.frame.size.width = labelLocal.frame.size.width
        viewLocal.sizeToFit()
        viewRemoto.frame.size.width = labelRemoto.frame.size.width
        viewRemoto.sizeToFit()
        
        sizeToFit()
        
        
        
        
        
    }
    
}
