//
//  DetalhesDia.swift
//  HptMobileIOS
//
//  Created by Rodrigo Lotrario on 25/07/17.
//  Copyright © 2017 Rodrigo Lotrario. All rights reserved.
//

import UIKit

class DetalhesDia: UIView, UITableViewDataSource{
    
    
    private var eventosArray: Array<Array<String>> = []
    
    @IBOutlet weak var diaLabel: UILabel!
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventosArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "celulaDiaSelecionado", for: indexPath) as! CelulaDiaCalendario
        
        cell.descricaoLabel.text = eventosArray[indexPath.row][0]
        cell.horarioInicioLabel.text = eventosArray[indexPath.row][1]
        cell.horarioFinalLabel.text = eventosArray[indexPath.row][2]
        
        
        return cell
        
    }
    public func definirTamanho(largura: CGFloat, altura: CGFloat){
        
        self.frame = CGRect(x: largura/7, y: altura/8, width: largura-(largura/3.5), height: altura-(altura/4))
        
    }
    
    public func eventos(eventos: Array<Array<String>>){
        
        eventosArray = eventos
        
    }
    public func dia(diaNumero: Int){
        
        
        
    }
    
}
