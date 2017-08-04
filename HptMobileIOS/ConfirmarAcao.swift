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
    @IBOutlet weak var acaoLabel: UILabel!
    
    var acaoDelegate: protocoloConfirmarAcao? = nil
    public var acao: String = ""
    
    override func viewDidLoad() {
        
        acaoLabel.adjustsFontSizeToFitWidth = true
        acaoLabel.text = acao
        subView.layer.cornerRadius = 10
        subView.clipsToBounds = true
        
    }
    
    @IBAction func confirmarButton(_ sender: Any) {
        
        acaoDelegate?.retornoAcao(confirmar: true)
        dismiss(animated: true, completion: nil)
        
    }
    @IBAction func cancelarButton(_ sender: Any) {
        
        acaoDelegate?.retornoAcao(confirmar: false)
        dismiss(animated: true, completion: nil)
        
    }
    
    
}
