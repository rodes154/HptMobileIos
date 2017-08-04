//
//  DiaSelecionado.swift
//  HptMobileIOS
//
//  Created by Rodrigo Lotrario on 30/06/17.
//  Copyright © 2017 Rodrigo Lotrario. All rights reserved.
//

import Foundation
import UIKit

class DiaSelecionado: UIViewController, UITableViewDelegate{
    
    @IBOutlet var detalhesEventoView: DetalhesEvento!
    @IBOutlet var detalhesDiaView: DetalhesDia!
    @IBOutlet var comentariosView: ComentariosTarefa!
    
    
    public var largura: CGFloat = 0
    public var altura: CGFloat = 0
    public var data = Date()
    private var eventosArray: Array<Array<String>> = []
    
    
    override func viewDidLoad() {
        
        self.view.frame = CGRect(x: 0, y: 0, width: largura, height: altura)
        carregarEventos()
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        construirDetalhesView(informacoes: eventosArray[indexPath.row])
    }
    
    private func carregarEventos(){
        
        let conn = ConexaoWebService()
        conn.realizarConexao(pacote: "eventos", funcao: "consultarEventos", metodo: "GET") { (objeto) in
            
            print(objeto)
            if(objeto is NSNull){
                self.construirDetalhesDia()
            }else{
                let tempDict = objeto as! Dictionary<String,String>
                
                DispatchQueue.main.async(execute: {
                    
                    for i in 0...tempDict.count-1{
                        self.eventosArray.append(objeto[String(i)] as! Array<String>)
                    }
                    self.construirDetalhesDia()
                })
            }
        }
    }
    
    private func construirDetalhesView(informacoes: Array<String>){
        detalhesEventoView.center = self.view.center
        detalhesEventoView.layer.cornerRadius = 10
        detalhesEventoView.alpha = 0
        detalhesEventoView.definirTamanho(largura: view.frame.width, altura: view.frame.height)
        detalhesEventoView.tarefasTableView.selectRow(at: [0,0], animated: true, scrollPosition: .top)
        detalhesEventoView.informacoes(data: informacoes)
        self.view.addSubview(detalhesEventoView)
        UIView.animate(withDuration: 0.3) {
            self.detalhesDiaView.alpha = 0
            self.detalhesEventoView.alpha = 1
        }
        
    }
    private func construirDetalhesDia(){
        
        detalhesDiaView.center = self.view.center
        detalhesDiaView.layer.cornerRadius = 10
        detalhesDiaView.alpha = 0
        detalhesDiaView.eventos(eventos: eventosArray)
        detalhesDiaView.definirTamanho(largura: view.frame.width, altura: view.frame.height)
        self.view.addSubview(detalhesDiaView)
        UIView.animate(withDuration: 0.3) { 
            self.detalhesDiaView.alpha = 1
        }
        
    }
    
    @IBAction func voltarButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func comentarioButton(_ sender: Any) {
        comentariosView.load(largura: view.frame.width, altura: view.frame.height, centro: view.center)
        view.addSubview(comentariosView)
        UIView.animate(withDuration: 0.3) {
            self.detalhesEventoView.alpha = 0
        }
    }
    @IBAction func eventoConcluidoButton(_ sender: Any) {
        self.detalhesDiaView.alpha = 1
        UIView.animate(withDuration: 0.3, animations: {
            self.detalhesEventoView.alpha = 0
        }) { (finished) in
            self.detalhesEventoView.removeFromSuperview()
        }
    }
    @IBAction func observacoesSalvarButton(_ sender: Any) {
        self.detalhesEventoView.alpha = 1
        UIView.animate(withDuration: 0.3) { 
            self.comentariosView.alpha = 0
        }
    }
}
