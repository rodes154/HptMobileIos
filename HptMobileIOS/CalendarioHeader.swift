//
//  CalendarioHeader.swift
//  HptMobileIOS
//
//  Created by Rodrigo Lotrario on 12/07/17.
//  Copyright © 2017 Rodrigo Lotrario. All rights reserved.
//

import UIKit

class CalendarioHeader: UICollectionReusableView{
    
    @IBOutlet weak var domLabel: UILabel!
    @IBOutlet weak var segLabel: UILabel!
    @IBOutlet weak var terLabel: UILabel!
    @IBOutlet weak var quaLabel: UILabel!
    @IBOutlet weak var quiLabel: UILabel!
    @IBOutlet weak var sexLabel: UILabel!
    @IBOutlet weak var sabLabel: UILabel!
    
    public func ajustarDias(largura: CGFloat){
        let yLabel: CGFloat = 50
        let heightLabel: CGFloat = 15
        domLabel.frame = CGRect(x: 0, y: yLabel, width: largura, height: heightLabel)
        segLabel.frame = CGRect(x: domLabel.frame.maxX+2, y: yLabel, width: largura, height: heightLabel)
        terLabel.frame = CGRect(x: segLabel.frame.maxX+2, y: yLabel, width: largura, height: heightLabel)
        quaLabel.frame = CGRect(x: terLabel.frame.maxX+2, y: yLabel, width: largura, height: heightLabel)
        quiLabel.frame = CGRect(x: quaLabel.frame.maxX+1, y: yLabel, width: largura, height: heightLabel)
        sexLabel.frame = CGRect(x: quiLabel.frame.maxX+1, y: yLabel, width: largura, height: heightLabel)
        sabLabel.frame = CGRect(x: sexLabel.frame.maxX+1, y: yLabel, width: largura, height: heightLabel)
    }
    
    
}
