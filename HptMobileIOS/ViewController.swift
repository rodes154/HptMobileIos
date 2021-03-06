//
//  ViewController.swift
//  HptMobileIOS
//
//  Created by Rodrigo Lotrario on 07/06/17.
//  Copyright © 2017 Rodrigo Lotrario. All rights reserved.
//

import UIKit
import Foundation


class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    @IBOutlet weak var getButton: UIButton!
    @IBOutlet weak var credIncorretasLabel: UILabel!	
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    

    @IBAction func buttonPressed(_ sender: Any) {
        
        
        //self.performSegue(withIdentifier: "showTabController", sender: self)
        
        
        
        let conn = ConexaoWebService()
        conn.inserirParametro(paramKey: "param1", paramValue: loginTextField.text!)
        conn.inserirParametro(paramKey: "param2", paramValue: passTextField.text!)
        conn.realizarConexao(pacote: "usuario", funcao: "login", metodo: "POST") { objeto in
            
                DispatchQueue.main.async(execute: {
                    
                    if (objeto is NSNull) {
                        self.credIncorretasLabel.transform = CGAffineTransform.init(scaleX: 1.5, y: 1.5)
                        UILabel.animate(withDuration: 0.2, animations: {
                            self.credIncorretasLabel.transform = CGAffineTransform.identity
                        })
                        self.credIncorretasLabel.isHidden=false
                        return
                    } else {
                        
                        let tempDict = objeto as! Dictionary<String,String>
                        InfoGlobal.setWidth(width: self.view.frame.width)
                        InfoGlobal.setHeight(height: self.view.frame.height)
                        self.performSegue(withIdentifier: "showTabController", sender: nil)
                    }
                })
        }
    }
}
