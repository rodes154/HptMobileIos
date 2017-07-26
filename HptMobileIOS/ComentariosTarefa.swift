//
//  ComentariosTarefa.swift
//  HptMobileIOS
//
//  Created by Rodrigo Lotrario on 25/07/17.
//  Copyright © 2017 Rodrigo Lotrario. All rights reserved.
//

import UIKit

class ComentariosTarefa: UIView{
    
    @IBAction func salvarButton(_ sender: Any) {
        
        UIView.animate(withDuration: 0.3, animations: { 
            self.alpha = 0
        }) { (finished) in
            self.removeFromSuperview()
        }
    }
    public func definirTamanho(largura: CGFloat, altura: CGFloat){
        
        self.frame = CGRect(x: largura/7, y: altura/4, width: largura-(largura/3.5), height: altura-(altura/2))
        
    }
}
