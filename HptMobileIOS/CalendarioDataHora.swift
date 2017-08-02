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

class CalendarioDataHora: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource{
    
    @IBOutlet weak var selecionarButton: UIButton!
    @IBOutlet weak var cancelarButton: UIButton!
    @IBOutlet weak var dataSelecionadaLabel: UILabel!
    @IBOutlet weak var mesAnoLabel: UILabel!
    
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
    
    var indiceDiaInicioMes: Int = 0
    let diasNoMes: Array<Int> = [31,28,31,30,31,30,31,31,30,31,30,31]
    
    public var indiceDia: String = ""
    public var indiceMes: String = ""
    public var indiceAno: Int = 0
    public var indiceHora: String = ""
    var indiceMinuto: String = "00"
    
    
    
    
    override func viewDidLoad() {
        
        
        atualizarIndiceDiaInicioMes()
        horaPickerView.selectRow(Int(indiceHora)!, inComponent: 0, animated: true)
        minutosPickerView.selectRow(00, inComponent: 0, animated: true)
        
        
        subView.clipsToBounds = true
        subView.layer.cornerRadius = 10
        
        atualizarLabelInferior()
        atualizarLabelSuperior()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width/7, height: collectionView.frame.height/7)
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return diasNoMes[Int(indiceMes)!-1]+indiceDiaInicioMes
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "celulaCalendario", for: indexPath) as! CelulaVazia
        cell.eventoImageView.isHidden = true
        
        
        if(indexPath.row<indiceDiaInicioMes){
            cell.diaLabel.isHidden = true
        }else{
            cell.diaLabel.isHidden = false
            cell.diaLabel.text = String((indexPath.row+1)-indiceDiaInicioMes)
            if(indexPath.row+1-indiceDiaInicioMes==Int(indiceDia)!){
                cell.eventoImageView.isHidden = false
                celulaSelecionada = indexPath
                collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredVertically)
            }
        }
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if(indexPath.row<indiceDiaInicioMes){
            collectionView.deselectItem(at: indexPath, animated: false)
            collectionView.selectItem(at: celulaSelecionada, animated: false, scrollPosition: .centeredVertically)
            
        }else{
            collectionView.deselectItem(at: celulaSelecionada, animated: true)
            (collectionView.cellForItem(at: celulaSelecionada) as? CelulaVazia)?.eventoImageView.isHidden = true
            (collectionView.cellForItem(at: indexPath) as? CelulaVazia)?.eventoImageView.isHidden = false
            indiceDia = ((collectionView.cellForItem(at: indexPath) as? CelulaVazia)?.diaLabel.text)!
            celulaSelecionada = indexPath
            atualizarLabelInferior()
        }
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
            return ""
        }
        
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func atualizarIndiceDiaInicioMes(){
        
        formatter.dateFormat = "dd/MM/yyyy"
        let dataTemp = formatter.date(from: "01/\(indiceMes)/\(indiceAno)")
        formatter.dateFormat = "EEEE"
        indiceDiaInicioMes = formatter.weekdaySymbols.index(of: formatter.string(from: dataTemp!))!
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
    private func atualizarLabelSuperior(){
        mesAnoLabel.text = "\((formatter.shortMonthSymbols[Int(indiceMes)!-1]).capitalized) de \(indiceAno)"
        
    }
    
    @IBAction func selecionarButtonClicked(_ sender: Any) {
        formatter.dateFormat = "dd/MM/yyyy HH:mm"
        dataDelegate?.retornarData(dataSelecionada: formatter.date(from: "\(indiceDia)/\(indiceMes)/\(indiceAno) \(indiceHora):\(indiceMinuto)")!)
        
        dismiss(animated: true, completion: nil)
        
    }
    @IBAction func cancelarButtonClick(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func proximoMesButton(_ sender: Any) {
        
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
        
        calendarioViewCollection.deselectItem(at: celulaSelecionada, animated: true)
        atualizarIndiceDiaInicioMes()
        calendarioViewCollection.reloadData()
        atualizarLabelSuperior()
        atualizarLabelInferior()
        
    }
    
    @IBAction func anteriorMesButton(_ sender: Any) {
        
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
        calendarioViewCollection.deselectItem(at: celulaSelecionada, animated: true)
        atualizarIndiceDiaInicioMes()
        calendarioViewCollection.reloadData()
        atualizarLabelSuperior()
        atualizarLabelInferior()
        
    }
    
}
