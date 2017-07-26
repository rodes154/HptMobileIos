//
//  NovoEvento.swift
//  HptMobileIOS
//
//  Created by Rodrigo Lotrario on 26/07/17.
//  Copyright © 2017 Rodrigo Lotrario. All rights reserved.
//

import Foundation
import UIKit

class NovoEvento: UIViewController{
    
    override func viewDidLoad() {
        title = "Novo Evento"
    }
    
    @IBAction func cancelarButton(_ sender: Any) {
        dismiss(animated: true) { 
            
        }
    }
}
