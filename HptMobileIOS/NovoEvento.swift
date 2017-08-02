//
//  NovoEvento.swift
//  HptMobileIOS
//
//  Created by Rodrigo Lotrario on 26/07/17.
//  Copyright © 2017 Rodrigo Lotrario. All rights reserved.
//

import Foundation
import UIKit

class NovoEvento: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, retornarDataDelegate{
    
    @IBOutlet weak var mainScrollView: UIScrollView!
    @IBOutlet weak var mainNavigationBar: UINavigationBar!
    
    @IBOutlet var pesquisarLocalView: PesquisarLocalNovoEvento!
    
    @IBOutlet weak var efeitoImageView: UIImageView!
    @IBOutlet weak var topoView: UIView!
    @IBOutlet weak var tarefasView: UIView!
    
    @IBOutlet weak var localPickerView: UIPickerView!
    @IBOutlet weak var responsavelPickerView: UIPickerView!
    
    @IBOutlet weak var inicioButton: UIButton!
    @IBOutlet weak var finalButton: UIButton!
    
    @IBOutlet weak var tarefasTableView: UITableView!
    
    var formatter = DateFormatter()
    var dataInicio = Date()
    var dataFinal = Date()
    var dataButton: Int = 0
    
    private var locais: Array<String> = ["Local 01","Local 02","Local 03","Local 04","Local 05","Local 06","Local 07","Local 08"]
    private var responsaveis: Array<String> = ["Tecnico 1","Tecnico 2","Tecnico 3","Tecnico 4","Tecnico 5"]
    
    override func viewDidLoad() {
        bordas()
        view.frame.size.width = InfoGlobal.getWidth()
        
        
        inicioButton.setTitle(InfoGlobal.getDataAtual(tipo: "completa"), for: .normal)
        finalButton.setTitle(InfoGlobal.getDataAtual(tipo: "completa"), for: .normal)
        
    }
    
    private func bordas(){
        
        topoView.layer.cornerRadius = 10
        tarefasView.layer.cornerRadius = 10
        
        tarefasTableView.layer.cornerRadius = 5
        tarefasTableView.layer.borderWidth = 0.3
        tarefasTableView.layer.borderColor = UIColor.lightGray.cgColor
        
        
        
        bordasPickerView(picker: localPickerView)
        bordasPickerView(picker: responsavelPickerView)
        
    }
    private func bordasPickerView(picker: UIPickerView){
        picker.layer.borderWidth = 0.3
        picker.layer.cornerRadius = 5
        picker.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    func retornarData(dataSelecionada: Date) {
        if(dataButton==1){
            dataInicio = dataSelecionada
            formatter.dateFormat = "E, d MMM yyyy"
            inicioButton.setTitle(formatter.string(from: dataSelecionada).capitalized, for: .normal)
            formatter.dateFormat = "HH:mm"
            inicioButton.setTitle("\(inicioButton.currentTitle ?? String())     \(formatter.string(from: dataSelecionada))", for: .normal)
        }
        if(dataButton==2){
            dataFinal = dataSelecionada
            formatter.dateFormat = "E, d MMM yyyy"
            finalButton.setTitle(formatter.string(from: dataSelecionada).capitalized, for: .normal)
            formatter.dateFormat = "HH:mm"
            finalButton.setTitle("\(finalButton.currentTitle ?? String())     \(formatter.string(from: dataSelecionada))", for: .normal)
        }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier=="selecionarData"){
            let dataVC = segue.destination as? CalendarioDataHora
            dataVC?.dataDelegate = self
            dataVC?.indiceHora = InfoGlobal.getDataAtual(tipo: "hora24")
            dataVC?.indiceDia = InfoGlobal.getDataAtual(tipo: "dia")
            dataVC?.indiceMes = InfoGlobal.getDataAtual(tipo: "mes")
            dataVC?.indiceAno = Int(InfoGlobal.getDataAtual(tipo: "ano"))!
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        switch pickerView {
            
        case localPickerView:
            return locais.count
            
        case responsavelPickerView:
            return responsaveis.count
        
        default:
            return 1
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
        case localPickerView:
            return locais[row]
        case responsavelPickerView:
            return responsaveis[row]
        default:
            return ""
        }
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        switch pickerView {
        
        default:
            return 1
        }
        
    }
    
    @IBAction func pesquisarLocalButton(_ sender: Any) {
        view.bringSubview(toFront: efeitoImageView)
        pesquisarLocalView.center = view.center
        view.addSubview(pesquisarLocalView)
        pesquisarLocalView.load()
        
    }
    
    @IBAction func inicioButtonClick(_ sender: Any) {
        
        dataButton = 1
        prepare(for: UIStoryboardSegue.init(identifier: "selecionarData", source: self, destination: self), sender: nil)
        performSegue(withIdentifier: "selecionarData", sender: self)
        
    }
    @IBAction func finalButtonClick(_ sender: Any) {
        
        dataButton = 2
        prepare(for: UIStoryboardSegue.init(identifier: "selecionarData", source: self, destination: self), sender: nil)
        performSegue(withIdentifier: "selecionarData", sender: self)
    }
    
    @IBAction func pesquisarResponsavelButton(_ sender: Any) {
        
        
        
    }
    
    @IBAction func novaTarefaButton(_ sender: Any) {
        
        performSegue(withIdentifier: "novaTarefa", sender: self)
        
    }
    
    
    @IBAction func cancelarEventoButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelarPesquisaLocalButton(_ sender: Any) {
        UIView.animate(withDuration: 0.3, animations: { 
            self.pesquisarLocalView.alpha = 0
        }) { (finished) in
            self.pesquisarLocalView.removeFromSuperview()
            self.view.bringSubview(toFront: self.mainScrollView)
            self.view.bringSubview(toFront: self.mainNavigationBar)
        }
    }
}
