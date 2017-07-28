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
    
    @IBOutlet weak var localPickerView: UIPickerView!
    @IBOutlet weak var responsavelPickerView: UIPickerView!
    
    @IBOutlet weak var inicioButton: UIButton!
    @IBOutlet weak var finalButton: UIButton!
    
    var formatter = DateFormatter()
    
    private var locais: Array<String> = []
    private var responsaveis: Array<String> = []
    
    override func viewDidLoad() {
        bordas()
        view.frame.size.width = InfoGlobal.getWidth()
        
        inicioButton.setTitle(InfoGlobal.getDataAtual(tipo: "completa"), for: .normal)
        finalButton.setTitle(InfoGlobal.getDataAtual(tipo: "completa"), for: .normal)
        
    }
    
    private func bordas(){
        
        topoView.layer.cornerRadius = 10
        
        
        
        bordasPickerView(picker: localPickerView)
        bordasPickerView(picker: responsavelPickerView)
        
    }
    private func bordasPickerView(picker: UIPickerView){
        picker.layer.borderWidth = 0.3
        picker.layer.cornerRadius = 5
        picker.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    func retornarData(dataSelecionada: String) {
        inicioButton.setTitle(dataSelecionada, for: .normal)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier=="selecionarData"){
            let dataVC = segue.destination as? CalendarioDataHora
            dataVC?.dataDelegate = self
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
        
        prepare(for: UIStoryboardSegue.init(identifier: "selecionarData", source: self, destination: self), sender: nil)
        performSegue(withIdentifier: "selecionarData", sender: self)
        
    }
    
    @IBAction func pesquisarResponsavelButton(_ sender: Any) {
        
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
