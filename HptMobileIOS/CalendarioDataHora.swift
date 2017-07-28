//
//  CalendarioDataHora.swift
//  HptMobileIOS
//
//  Created by Rodrigo Lotrario on 27/07/17.
//  Copyright © 2017 Rodrigo Lotrario. All rights reserved.
//

import Foundation
import UIKit

class CalendarioDataHora: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource{
    
    @IBOutlet weak var calendarioViewCollection: UICollectionView!
    @IBOutlet weak var horaView: UIView!
    @IBOutlet weak var subView: UIView!
    
    
    override func viewDidLoad() {
        
        subView.clipsToBounds = true
        subView.layer.cornerRadius = 10
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 31
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "celulaCalendario", for: indexPath) as! CelulaVazia
        cell.diaLabel.text = String(indexPath.row+1)
        
        return cell
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 5
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    
    
    
    
    
}
