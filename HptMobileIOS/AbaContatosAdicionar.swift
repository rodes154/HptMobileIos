//
//  AbaContatosAdicionar.swift
//  HptMobileIOS
//
//  Created by Rodrigo Lotrario on 29/06/17.
//  Copyright © 2017 Rodrigo Lotrario. All rights reserved.
//

import Foundation
import UIKit

class AbaContatosAdicionar: UIViewController {
    
    
    override func viewDidLoad() {
        let rightButton = UIBarButtonItem(image: UIImage(named: "infoIcon"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(AbaContatosAdicionar.rightButtonClicked))
        self.navigationItem.rightBarButtonItem = rightButton
    }
    
    func rightButtonClicked(){
        
    }
    
}
