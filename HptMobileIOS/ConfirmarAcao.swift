//
//  ConfirmarAcao.swift
//  HptMobileIOS
//
//  Created by Rodrigo Lotrario on 01/08/17.
//  Copyright © 2017 Rodrigo Lotrario. All rights reserved.
//

import Foundation
import UIKit

protocol protocoloConfirmarAcao {
    func retornoAcao(confirmar: Bool)
}

class ConfirmarAcao: UIViewController {
    
    @IBOutlet weak var subView: UIView!
    var confirmarAcao: protocoloConfirmarAcao? = nil
    public var acao: String = ""
    
    override func viewDidLoad() {
        
        subView.layer.cornerRadius = 10
        subView.clipsToBounds = true
        
    }
    
}
