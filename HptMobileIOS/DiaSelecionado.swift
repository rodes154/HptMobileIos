//
//  DiaSelecionado.swift
//  HptMobileIOS
//
//  Created by Rodrigo Lotrario on 30/06/17.
//  Copyright © 2017 Rodrigo Lotrario. All rights reserved.
//

import Foundation
import UIKit

class DiaSelecionado: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var diaSelecionadoView: UIView!
    @IBOutlet weak var diaLabel: UILabel!
    @IBOutlet var detalhesTarefaView: DetalhesTarefa!
    @IBOutlet weak var descricaoTableView: UITableView!
    
    
    public var dia: Int = 0
    private var nomes: Array<String> = []
    
    override func viewDidLoad() {
        
        diaSelecionadoView.layer.cornerRadius = 10
        carregarNomes()
        alterarDia(dia: dia)
    }
    
    public func alterarDia(dia: Int){
        self.diaLabel.text = "Dia \(dia)"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return nomes.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        construirDetalhesView(nomeTarefa: "Nome tarefa")
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "celulaDiaSelecionado", for: indexPath) as! CelulaDiaCalendario
        
        cell.descricaoLabel.text = nomes[indexPath.row]
        cell.horarioInicioLabel.text = String(indexPath.row)
        cell.horarioFinalLabel.text = String(indexPath.row)
        
        
        return cell
        
    }
    
    private func carregarNomes(){
        
        let conn = ConexaoWebService()
        conn.realizarConexao(funcao: "consultarPessoa", metodo: "GET") { (objeto) in
            
            DispatchQueue.main.async(execute: {
                
                print("recebido")
                self.nomes = objeto[String(1)] as! Array<String>
                print(self.nomes.count)
                self.descricaoTableView.reloadData()
                
                
            })
        }
    }
    
    private func construirDetalhesView(nomeTarefa: String){
        detalhesTarefaView.center = self.view.center
        detalhesTarefaView.layer.cornerRadius = 10
        detalhesTarefaView.alpha = 0
        self.view.addSubview(detalhesTarefaView)
        UIView.animate(withDuration: 0.3) {
            self.detalhesTarefaView.alpha = 1
        }
        
    }
    
    @IBAction func voltarButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
