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
    
    var dict: Dictionary<String, String> = [:]
    var sessao: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //REMOVER
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if( segue.identifier == "showTabController"){
            let vc = segue.destination as? HomeView
            vc?.sessao = sessao
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }

    @IBAction func buttonPressed(_ sender: Any) {
        
        
        
        let conn = ConexaoWebService()
        conn.inserirParametro(paramKey: "param1", paramValue: loginTextField.text!)
        conn.inserirParametro(paramKey: "param2", paramValue: passTextField.text!)
        conn.realizarConexao(funcao: "validarLogin", metodo: "POST") { objeto in
                
                DispatchQueue.main.async(execute: {
                    var tempDict: Dictionary<String, String>
                    tempDict = objeto as! Dictionary<String, String>
                    if(tempDict["checagemLogin"]=="1"){
                        self.sessao = tempDict["sessao"]
                        self.prepare(for: UIStoryboardSegue.init(identifier: "showTabController", source: self, destination: self), sender: self)
                        self.performSegue(withIdentifier: "showTabController", sender: nil)
                    } else{
                        self.credIncorretasLabel.isHidden=false
                    }
                })
        }
    }
}
