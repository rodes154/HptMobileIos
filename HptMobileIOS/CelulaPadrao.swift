//
//  CelulaContatos.swift
//  HptMobileIOS
//
//  Created by Rodrigo Lotrario on 03/07/17.
//  Copyright © 2017 Rodrigo Lotrario. All rights reserved.
//

import UIKit

class CelulaPadrao: UITableViewCell {
    
    @IBOutlet weak var labelPrincipal: UILabel!
    @IBOutlet weak var labelSecundaria: UILabel!
    @IBOutlet weak var labelDireitaSuperior: UILabel!
    @IBOutlet weak var circuloImageView: UIImageView!
    @IBOutlet weak var labelNotificacao: UILabel!
    
    public func semNotificacoes(){
        labelNotificacao.isHidden = true
        circuloImageView.isHidden = true
    }
    
    
    
}
