//
//  DetalhesTarefa.swift
//  HptMobileIOS
//
//  Created by Rodrigo Lotrario on 14/07/17.
//  Copyright © 2017 Rodrigo Lotrario. All rights reserved.
//

import UIKit

class DetalhesEvento: UIView, UITableViewDataSource, UITableViewDelegate{
    
        
    
    @IBOutlet weak var finalizadoButton: UIButton!
    @IBOutlet weak var pendenteButton: UIButton!
    @IBOutlet weak var canceladoButton: UIButton!
    @IBOutlet weak var comentarioButton: UIButton!
    @IBOutlet weak var tarefasTableView: UITableView!
    @IBOutlet weak var linhaInferiorLabel: UILabel!
    
    @IBOutlet weak var localLabel: UILabel!
    @IBOutlet weak var horarioLabel: UILabel!
    @IBOutlet weak var tituloLabel: UILabel!
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "celulaDescricao", for: indexPath) as! CelulaPadraoSimples
        cell.descricaoLabel.text = "Tarefa \(indexPath.row)"
        
        return cell
        
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    
    public func definirTamanho(largura: CGFloat, altura: CGFloat){
        
        self.frame = CGRect(x: largura/7, y: altura/8, width: largura-(largura/3.5), height: altura-(altura/4))
        
    }
    
    
    
    @IBAction func tarefaFinalizadaClicked(_ sender: Any) {
        
        resetarBotoes(b1: pendenteButton, b2: canceladoButton)
        finalizadoButton.isSelected = !finalizadoButton.isSelected
        finalizadoButton.setImage(UIImage(named: "finalizadoIconVerde"), for: .selected)
        
    }
    
    @IBAction func tarefaPendenteClicked(_ sender: Any) {
    
        resetarBotoes(b1: finalizadoButton, b2: canceladoButton)
        pendenteButton.isSelected = !pendenteButton.isSelected
        pendenteButton.setImage(UIImage(named: "pendenteIconAmarelo"), for: .selected)
        
    }
    
    @IBAction func tarefaCanceladaClicked(_ sender: Any) {
        
        resetarBotoes(b1: finalizadoButton, b2: pendenteButton)
        canceladoButton.isSelected = !canceladoButton.isSelected
        canceladoButton.setImage(UIImage(named: "canceladoIconVermelho"), for: .selected)
        
    }
    
    @IBAction func tarefaComentarioClicked(_ sender: Any) {
        comentarioButton.isSelected = !comentarioButton.isSelected
        comentarioButton.setImage(UIImage(named: "comentarioIconAzul"), for: .selected)
        
    }
    
    private func resetarBotoes(b1: UIButton, b2: UIButton){
        b1.isSelected = false
        b2.isSelected = false
    }
    public func informacoes(data: Array<String>){
        localLabel.text = data[3]
        horarioLabel.text = "\(data[1]) - \(data[2])"
        tituloLabel.text = data[0]
    }
}
