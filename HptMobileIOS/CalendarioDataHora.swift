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
    func retornarData(dataSelecionada: String)
}

class CalendarioDataHora: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource{
    
    
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
    
    var indiceDia: Int = 28
    var indiceMes: Int = 07
    var indiceAno: Int = 2017
    var indiceHora: Int = 12
    var indiceMinuto: Int = 19
    
    
    
    override func viewDidLoad() {
        
        
        horaPickerView.selectRow(indiceHora, inComponent: 0, animated: true)
        minutosPickerView.selectRow(indiceMinuto, inComponent: 0, animated: true)
        
        subView.clipsToBounds = true
        subView.layer.cornerRadius = 10
        
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
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        collectionView.deselectItem(at: celulaSelecionada, animated: true)
        (collectionView.cellForItem(at: celulaSelecionada) as? CelulaVazia)?.eventoImageView.isHidden = true
        (collectionView.cellForItem(at: indexPath) as? CelulaVazia)?.eventoImageView.isHidden = false
        indiceDia = Int(((collectionView.cellForItem(at: indexPath) as? CelulaVazia)?.diaLabel.text)!)!
        celulaSelecionada = indexPath
        
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
        dataDelegate?.retornarData(dataSelecionada: "")
        
        dismiss(animated: true, completion: nil)
        
    }
    
    
    
    
    
    
}
