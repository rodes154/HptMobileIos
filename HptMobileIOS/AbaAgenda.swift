//
//  AbaAgenda.swift
//  HptMobileIOS
//
//  Created by Rodrigo Lotrario on 29/06/17.
//  Copyright © 2017 Rodrigo Lotrario. All rights reserved.
//

import Foundation
import UIKit

class AbaAgenda: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    
    let diasNoMes: Array<Int> = [31,28,31,30,31,30,31,31,30,31,30,31]
    
    
    @IBOutlet weak var calendarioCollectionView: UICollectionView!
    @IBOutlet weak var mesAnoLabel: UILabel!
    
    let formatter = DateFormatter()
    
    var intervalo: Int = 0
    var indiceDia: String = ""
    var indiceMes: String = ""
    var indiceAno: Int = 0
    
    var diaSelecionado: String = ""
    

    override func viewDidLoad() {
        
        indiceMes = InfoGlobal.getDataAtual(tipo: "mes")
        indiceAno = Int(InfoGlobal.getDataAtual(tipo: "ano"))!
        indiceDia = InfoGlobal.getDataAtual(tipo: "dia")
        
        
        atualizarIntervalo()
        atualizarLabelSuperior()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "diaSelecionado"){
            let diaView = segue.destination as? DiaSelecionado
            formatter.dateFormat = "dd/MM/yyyy"
            diaView?.data = formatter.date(from: "\(diaSelecionado)/\(indiceMes)/\(indiceAno)")!
            diaView?.largura = view.frame.width
            diaView?.altura = view.frame.height
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width)/7, height: (collectionView.frame.height)/8)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
       
        return diasNoMes[Int(indiceMes)!-1]+intervalo
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if(indexPath.row < intervalo){
            
        }else{
            diaSelecionado = String(indexPath.row-intervalo+1)
            prepare(for: UIStoryboardSegue.init(identifier: "diaSelecionado", source: self, destination: self), sender: self)
            performSegue(withIdentifier: "diaSelecionado", sender: self)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "celulaCalendario", for: indexPath) as! CelulaSimplesCollectionView
        cell.imagem.image = UIImage(named: "circuloCinza")
        cell.label.transform = CGAffineTransform.identity
        
        if(indexPath.row<intervalo){
            cell.label.isHidden = true
            cell.imagem.isHidden = true
        }else{
            cell.label.isHidden = false
            cell.imagem.isHidden = false
            cell.label.text = String((indexPath.row+1)-intervalo)
            if(indexPath.row+1-intervalo==Int(indiceDia)!&&indiceMes==InfoGlobal.getDataAtual(tipo: "mes")){
                cell.label.transform = CGAffineTransform.init(scaleX: 1.5, y: 1.5)
            }
        }
        return cell
    }    
    private func atualizarIntervalo(){
        formatter.dateFormat = "dd/MM/yyyy"
        let dataTemp = formatter.date(from: "01/\(indiceMes)/\(indiceAno)")
        formatter.dateFormat = "EEEE"
        intervalo = formatter.weekdaySymbols.index(of: formatter.string(from: dataTemp!))!
    }
    private func atualizarLabelSuperior(){
        mesAnoLabel.text = "\((formatter.shortMonthSymbols[Int(indiceMes)!-1]).capitalized) de \(indiceAno)"
    }
    
    @IBAction func proximoButton(_ sender: Any) {
        
        if(indiceMes=="12"){
            indiceMes="01"
            indiceAno=indiceAno+1
        }else{
            if(Int(indiceMes)!<9){
                indiceMes = "0\(Int(indiceMes)!+1)"
            }else{
                indiceMes = String(Int(indiceMes)!+1)
            }
        }
        
        atualizarIntervalo()
        calendarioCollectionView.reloadData()
        atualizarLabelSuperior()
        
        
    }
    
    @IBAction func anteriorButton(_ sender: Any) {
        
        if(indiceMes=="01"){
            indiceMes="12"
            indiceAno=indiceAno-1
        }else{
            if(Int(indiceMes)!<11){
                indiceMes = "0\(Int(indiceMes)!-1)"
            }else{
                indiceMes = String(Int(indiceMes)!-1)
            }
            
        }
        
        atualizarIntervalo()
        calendarioCollectionView.reloadData()
        atualizarLabelSuperior()

    }
    
    @IBAction func adcionarEventoButton(_ sender: Any) {
        performSegue(withIdentifier: "adicionarEvento", sender: self)
    }
    
}
