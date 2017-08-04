//
//  NovaTarefa.swift
//  HptMobileIOS
//
//  Created by Rodrigo Lotrario on 01/08/17.
//  Copyright © 2017 Rodrigo Lotrario. All rights reserved.
//

import Foundation
import UIKit

protocol retornarTarefaDelegate {
    func retornarTarefa(tarefa: Array<String>)
}

class NovaTarefa: UIViewController, UITextFieldDelegate, UITextViewDelegate{
    
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var descricaoTextView: UITextView!
    @IBOutlet weak var tituloTextField: UITextField!
    
    @IBOutlet weak var verdeImageView: UIImageView!
    @IBOutlet weak var amareloImageView: UIImageView!
    @IBOutlet weak var vermelhoImageView: UIImageView!
    
    var tarefaDelegate: retornarTarefaDelegate? = nil
    var prioridade: Int = 1
    
    override func viewDidLoad() {
        
        bordas()
    
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.subView.endEditing(true)
        return false
    }
    
    
    
    
    private func bordas(){
        
        subView.layer.cornerRadius = 10
        subView.clipsToBounds = true
        descricaoTextView.layer.cornerRadius = 5
        descricaoTextView.layer.borderColor = UIColor.lightGray.cgColor
        descricaoTextView.layer.borderWidth = 0.5
        
    }
    @IBAction func verdeButton(_ sender: Any) {
        
        prioridade = 1
        verdeImageView.isHidden = false
        limparPrioridade(imagem1: amareloImageView, imagem2: vermelhoImageView)
        
    }
    @IBAction func amareloButton(_ sender: Any) {
        
        prioridade = 2
        amareloImageView.isHidden = false
        limparPrioridade(imagem1: verdeImageView, imagem2: vermelhoImageView)
        
    }
    @IBAction func vermelhoButton(_ sender: Any) {
        
        prioridade = 3
        vermelhoImageView.isHidden = false
        limparPrioridade(imagem1: verdeImageView, imagem2: amareloImageView)
        
    }
    
    private func limparPrioridade(imagem1: UIImageView, imagem2: UIImageView){
        
        imagem1.isHidden = true
        imagem2.isHidden = true
        
    }
    @IBAction func cancelarButton(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        
    }
    @IBAction func inserirButton(_ sender: Any) {
        
        if(tituloTextField.text != ""){
            
            let dados: Array<String> = [tituloTextField.text!,descricaoTextView.text!,String(prioridade)]
            tarefaDelegate?.retornarTarefa(tarefa: dados)
            dismiss(animated: true, completion: nil)
            
        } else {
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "avisoViewController") as? Aviso
            vc?.aviso(aviso: "Preencha o título da tarefa")
            present(vc!, animated: true, completion: nil)
            
            
        }
        
    }
    
}
