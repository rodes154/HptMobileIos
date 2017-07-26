//
//  AbaAgenda.swift
//  HptMobileIOS
//
//  Created by Rodrigo Lotrario on 29/06/17.
//  Copyright © 2017 Rodrigo Lotrario. All rights reserved.
//

import Foundation
import UIKit

class AbaAgenda: ViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    
    let meses: Array<String> = ["Janeiro","Fevereiro","Março","Abril","Maio","Junho","Julho","Agosto","Setembro","Outubro","Novembro","Dezembro"]
    let diasSemanaExtenso: Array<String> = ["Domingo","Segunda","Terça","Quarta","Quinta","Sexta","Sábado"]
    let diasNoMes: Array<Int> = [31,28,31,30,31,30,31,31,30,31,30,31]
    
    @IBOutlet weak var calendarioCollectionView: UICollectionView!
    @IBOutlet weak var mesNavigationItem: UINavigationItem!
    @IBOutlet weak var proximoButton: UIBarButtonItem!
    @IBOutlet weak var anteriorButton: UIBarButtonItem!
    @IBOutlet weak var mesNavigationBar: UINavigationBar!
    @IBOutlet var diaSelecionadoView: UIView!
    
    
    
    @IBOutlet weak var segLabel: UILabel!
    
    var dateGlobal = Date()
    var mesAtual: Int?
    let formatter = DateFormatter()
    var selecaoReal: Int = 0
    var selecaoAtt: Int = 0
    var intervalo: Int = 0
    var indiceMes: Int = 0
    var indiceAno: Int = 0
    
    
    override func viewDidLoad() {
        definirIndices()
        atualizarMeses()
        permissao()
        mesAtual = Calendar.current.component(.month, from: dateGlobal)
    }
    private func permissao(){
        if(Credenciais.getAcesso() != 1){
            self.navigationItem.rightBarButtonItem = nil
        }
    }
    private func atualizarMeses(){
        mesNavigationItem.title = meses[indiceMes-1]
        anteriorButton.title = meses[indiceMes-2]
        proximoButton.title = meses[indiceMes]
        calendarioCollectionView.reloadData()
    }
    private func definirIndices(){
        indiceMes = Calendar.current.component(.month, from: dateGlobal)
        indiceAno = Calendar.current.component(.year, from: dateGlobal)
        intervalo  = Calendar.current.component(.weekday, from: dateGlobal)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "diaSelecionado"){
            let diaView = segue.destination as? DiaSelecionado
            diaView?.dia = selecaoAtt
            diaView?.largura = view.frame.width
            diaView?.altura = view.frame.height
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width-10)/7, height: (collectionView.frame.height)/8)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
       
        return diasNoMes[indiceMes-1]+6
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        selecaoReal = indexPath.row
        selecaoAtt = indexPath.row-intervalo+2
        
        if(indexPath.row < intervalo-1 || (indexPath.row)-1 > diasNoMes[indiceMes-1]){
            
        }else{
            prepare(for: UIStoryboardSegue.init(identifier: "diaSelecionado", source: self, destination: self), sender: self)
            performSegue(withIdentifier: "diaSelecionado", sender: self)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "celulaCalendario", for: indexPath) as! CelulaVazia
        
       
        let numeroCelula = indexPath.row+2-intervalo
        
        if(indexPath.item >= intervalo-1 && numeroCelula <= diasNoMes[indiceMes-1]){
            cell.diaLabel.text = String(numeroCelula)
            if(indexPath==[0,Calendar.current.component(.day, from: dateGlobal)+1]  && indiceMes==mesAtual){
                cell.diaLabel.textColor = UIColor .cyan
                cell.eventoImageView.image = UIImage(named: "circuloVermelho")
                
            }else{
                cell.eventoImageView.image = UIImage(named: "circuloCinza")
                cell.diaLabel.textColor = UIColor .black
            }
        }else{
            cell.diaLabel.text = nil
            cell.eventoImageView.image = nil
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "calendarioHeader", for: indexPath) as! CalendarioHeader
        headerView.ajustarDias(largura: CGFloat((view.frame.width-10)/7))
        
        return headerView
    }
    
    @IBAction func proximoButton(_ sender: Any) {
        formatter.dateFormat = "MM/yyyy"
        dateGlobal = formatter.date(from: "\(indiceMes+1)/\(indiceAno)")!
        definirIndices()
        atualizarMeses()
        
    }
    
    @IBAction func anteriorButton(_ sender: Any) {
        formatter.dateFormat = "MM/yyyy"
        dateGlobal = formatter.date(from: "\(indiceMes-1)/\(indiceAno)")!
        definirIndices()
        atualizarMeses()

    }
    
    @IBAction func adcionarEventoButton(_ sender: Any) {
        performSegue(withIdentifier: "adicionarEvento", sender: self)
    }
    
}
