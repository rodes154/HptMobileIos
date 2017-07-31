//
//  CalendarioDataHora.swift
//  HptMobileIOS
//
//  Created by Rodrigo Lotrario on 27/07/17.
//  Copyright © 2017 Rodrigo Lotrario. All rights reserved.
//

import Foundation
import UIKit

protocol retornarDataDelegate{
    func retornarData(dataSelecionada: Date)
}

class CalendarioDataHora: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource{
    
    @IBOutlet weak var selecionarButton: UIButton!
    @IBOutlet weak var cancelarButton: UIButton!
    @IBOutlet weak var dataSelecionadaLabel: UILabel!
    
    @IBOutlet weak var horaView: UIView!
    @IBOutlet weak var subView: UIView!
    
    @IBOutlet weak var calendarioViewCollection: UICollectionView!
    @IBOutlet weak var horaPickerView: UIPickerView!
    @IBOutlet weak var minutosPickerView: UIPickerView!
    
    @IBOutlet weak var domLabel: UILabel!
    @IBOutlet weak var segLabel: UILabel!
    @IBOutlet weak var terLabel: UILabel!
    @IBOutlet weak var quaLabel: UILabel!
    @IBOutlet weak var quiLabel: UILabel!
    @IBOutlet weak var sexLabel: UILabel!
    @IBOutlet weak var sabLabel: UILabel!
    
    var dataDelegate: retornarDataDelegate? = nil
    
    var celulaSelecionada: IndexPath = [0,0]
    var formatter = DateFormatter()
    
    var indiceDia: String = ""
    var indiceMes: String = ""
    var indiceAno: Int = 2017
    var indiceHora: String = ""
    var indiceMinuto: String = "00"
    
    
    
    
    override func viewDidLoad() {
        
        indiceHora = InfoGlobal.getDataAtual(tipo: "hora24")
        indiceDia = InfoGlobal.getDataAtual(tipo: "dia")
        indiceMes = InfoGlobal.getDataAtual(tipo: "mes")
        indiceAno = Int(InfoGlobal.getDataAtual(tipo: "ano"))!
        
        
        horaPickerView.selectRow(Int(indiceHora)!, inComponent: 0, animated: true)
        minutosPickerView.selectRow(00, inComponent: 0, animated: true)
        
        
        subView.clipsToBounds = true
        subView.layer.cornerRadius = 10
        
        atualizarLabelInferior()
        
    }
    
    private func atualizarLabelInferior(){
        
        UILabel.animate(withDuration: 0.2, animations: {
            self.dataSelecionadaLabel.transform = CGAffineTransform.init(scaleX: 1.2, y: 1.2)
        }) { (finished) in
            UILabel.animate(withDuration: 0.2, animations: {
                self.dataSelecionadaLabel.transform = CGAffineTransform.identity
                self.dataSelecionadaLabel.text = "\(self.indiceDia)/\(self.indiceMes)/\(self.indiceAno)     \(self.indiceHora):\(self.indiceMinuto)"
            })
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: calendarioViewCollection.frame.width/7, height: 30)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 31
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "celulaCalendario", for: indexPath) as! CelulaVazia
        cell.diaLabel.text = String(indexPath.row+1)
        if(indexPath.row+1==Int(indiceDia)!){
            cell.eventoImageView.isHidden = false
            celulaSelecionada = indexPath
        }
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        collectionView.deselectItem(at: celulaSelecionada, animated: true)
        (collectionView.cellForItem(at: celulaSelecionada) as? CelulaVazia)?.eventoImageView.isHidden = true
        (collectionView.cellForItem(at: indexPath) as? CelulaVazia)?.eventoImageView.isHidden = false
        indiceDia = ((collectionView.cellForItem(at: indexPath) as? CelulaVazia)?.diaLabel.text)!
        celulaSelecionada = indexPath
        atualizarLabelInferior()
        
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        var number : String = String(row)
        if(row<10){
            number = "0\(row)"
        }
        
        switch pickerView {
        case horaPickerView:
            indiceHora = number
        case minutosPickerView:
            indiceMinuto = number
        default: break
            
        }
        atualizarLabelInferior()
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        
        switch pickerView {
        case horaPickerView:
            return 24
        case minutosPickerView:
            return 60
        default:
            return 1
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        var number: String = String(row)
        if(row<10){
            number = "0\(row)"
        }
        
        switch pickerView {
        case horaPickerView:
            return String(number)
        case minutosPickerView:
            return String(number)
        default:
            return "a"
        }
        
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    @IBAction func selecionarButtonClicked(_ sender: Any) {
        formatter.dateFormat = "dd/MM/yyyy HH:mm"
        dataDelegate?.retornarData(dataSelecionada: formatter.date(from: "\(indiceDia)/\(indiceMes)/\(indiceAno) \(indiceHora):\(indiceMinuto)")!)
        
        dismiss(animated: true, completion: nil)
        
    }
    @IBAction func cancelarButtonClick(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        
        
    }
    
    
    
    
    
    
}
