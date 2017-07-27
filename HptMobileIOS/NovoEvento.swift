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
    @IBOutlet weak var localPickerView: UIPickerView!
    @IBOutlet weak var responsavelPickerView: UIPickerView!
    @IBOutlet var pesquisarLocalView: PesquisarLocalNovoEvento!
    @IBOutlet weak var efeitoImageView: UIImageView!
    @IBOutlet weak var topoView: UIView!
    
    override func viewDidLoad() {
        bordas()
        view.frame.size.width = InfoGlobal.getWidth()
        
    }
    
    private func bordas(){
        localPickerView.layer.borderWidth = 0.3
        localPickerView.layer.cornerRadius = 5
        localPickerView.layer.borderColor = UIColor.lightGray.cgColor
        
        responsavelPickerView.layer.borderWidth = 0.3
        responsavelPickerView.layer.cornerRadius = 5
        responsavelPickerView.layer.borderColor = UIColor.lightGray.cgColor
        
        topoView.layer.cornerRadius = 10
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 10
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    @IBAction func pesquisarLocalButton(_ sender: Any) {
        view.bringSubview(toFront: efeitoImageView)
        pesquisarLocalView.center = view.center
        view.addSubview(pesquisarLocalView)
        pesquisarLocalView.load()
        
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
        }
    }
}
