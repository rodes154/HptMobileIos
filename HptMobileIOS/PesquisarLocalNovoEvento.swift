//
//  PesquisarLocalNovoEvento.swift
//  HptMobileIOS
//
//  Created by Rodrigo Lotrario on 27/07/17.
//  Copyright © 2017 Rodrigo Lotrario. All rights reserved.
//

import Foundation
import UIKit

class PesquisarLocalNovoEvento: UIView, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var pesquisaTextField: UITextField!
    @IBOutlet weak var resultadoTableView: UITableView!
    
    public func load(){
        alpha = 0
        UIView.animate(withDuration: 0.3) { 
            self.alpha = 1
        }
        layer.cornerRadius = 10
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celulaPesquisaLocal", for: indexPath) as! CelulaPadraoSimples
        
        cell.descricaoLabel.text = String(indexPath.row)
        return cell
    }
    
    
    
    @IBAction func cancelarButton(_ sender: Any) {
    }
    
}
