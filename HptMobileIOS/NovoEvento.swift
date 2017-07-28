//
//  NovoEvento.swift
//  HptMobileIOS
//
//  Created by Rodrigo Lotrario on 26/07/17.
//  Copyright © 2017 Rodrigo Lotrario. All rights reserved.
//

import Foundation
import UIKit

class NovoEvento: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate{
    
    @IBOutlet weak var mainScrollView: UIScrollView!
    @IBOutlet weak var mainNavigationBar: UINavigationBar!
    
    @IBOutlet var pesquisarLocalView: PesquisarLocalNovoEvento!
    
    @IBOutlet weak var efeitoImageView: UIImageView!
    @IBOutlet weak var topoView: UIView!
    
    @IBOutlet weak var localPickerView: UIPickerView!
    @IBOutlet weak var responsavelPickerView: UIPickerView!
    
    
    private var locais: Array<String> = []
    private var responsaveis: Array<String> = []
    
    override func viewDidLoad() {
        bordas()
        view.frame.size.width = InfoGlobal.getWidth()
        
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
    
    private func dataButtonClick(){
        performSegue(withIdentifier: "selecionarData", sender: self)
    }
    
    @IBAction func pesquisarLocalButton(_ sender: Any) {
        view.bringSubview(toFront: efeitoImageView)
        pesquisarLocalView.center = view.center
        view.addSubview(pesquisarLocalView)
        pesquisarLocalView.load()
        
    }
    
    
    @IBAction func pesquisarResponsavelButton(_ sender: Any) {
        dataButtonClick()
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
