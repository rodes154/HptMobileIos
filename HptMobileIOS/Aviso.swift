//
//  Aviso.swift
//  HptMobileIOS
//
//  Created by Rodrigo Lotrario on 04/08/17.
//  Copyright © 2017 Rodrigo Lotrario. All rights reserved.
//

import Foundation
import UIKit

class Aviso: UIViewController{
    
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var textoLabel: UILabel!
    
    var aviso: String = ""
    
    override func viewDidLoad() {
        textoLabel.adjustsFontSizeToFitWidth = true
        subView.clipsToBounds = true
        subView.layer.cornerRadius = 10
        subView.layer.borderWidth = 1
        subView.layer.borderColor = UIColor.lightGray.cgColor
        
        textoLabel.text = aviso
    }
    
    
    @IBAction func confirmarButton(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        
    }
    
    public func aviso(aviso: String){
        self.aviso = aviso
    }
    
}
