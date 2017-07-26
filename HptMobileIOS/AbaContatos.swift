//
//  AbaContatos.swift
//  HptMobileIOS
//
//  Created by Rodrigo Lotrario on 29/06/17.
//  Copyright © 2017 Rodrigo Lotrario. All rights reserved.
//

import Foundation
import UIKit

class AbaContatos: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var contatosTableView: UITableView!
    @IBOutlet weak var aguardeLabel: UILabel!
    
    var rightButtons = [UIBarButtonItem]()
    var searchBar = UISearchBar()
    
    var nomesArray: Array<String> = []
    var mensagemArray: Array<String> = []
    var dataArray: Array<String> = []
    var notificacoesArray: Array<Int> = []
    
    var nomesFiltrados: Array<String> = []
    
    var pesquisando: Bool = false
    var indiceSelecionado: Int = 0
    
    
    override func viewDidLoad() {
        buscarContatos()
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let start = dataArray[indexPath.row].index(dataArray[indexPath.row].startIndex, offsetBy: 11)
        let end = dataArray[indexPath.row].index(dataArray[indexPath.row].endIndex, offsetBy: -5)
        let range = start..<end
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "celulaContatos", for: indexPath) as! CelulaPadrao
        cell.labelPrincipal.text = nomesArray[indexPath.row]
        cell.labelSecundaria.text = mensagemArray[indexPath.row]
        cell.labelDireitaSuperior.text = dataArray[indexPath.row].substring(with: range)
        cell.labelNotificacao.text = String(notificacoesArray[indexPath.row])
        
        if(notificacoesArray[indexPath.row]==0){
            cell.semNotificacoes()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nomesArray.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        indiceSelecionado = indexPath.row
        prepare(for: UIStoryboardSegue.init(identifier: "mostrarChat", source: self, destination: self), sender: nil)
        performSegue(withIdentifier: "mostrarChat", sender: nil)
        
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle == .delete){
            removerContato(indexPath.row)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "mostrarChat"){
            let cell = contatosTableView.cellForRow(at: [0,indiceSelecionado]) as! CelulaPadrao
            let nextScreen = segue.destination as? AbaContatosChat
            nextScreen?.title = cell.labelPrincipal.text
            
        }
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        UISearchBar.animate(withDuration: 0.5) {
            self.navigationItem.titleView = nil
            self.title = "Contatos"
            self.navigationItem.rightBarButtonItem = self.rightButtons[0]
            self.navigationItem.rightBarButtonItems?.append(self.rightButtons[1])
        }
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if(searchText==""){
            pesquisando = false
        }else{
            pesquisando = true
            limparFiltro()
            for i in 0...nomesArray.count-1{
                let auxSearch = searchText.lowercased().folding(options: .diacriticInsensitive, locale: .current)
            }
        }
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        pesquisando = false
    }
    
    private func removerContato(_ index: Int){
        //INSERIR REQUISICAO DE REMOCAO DO CONTATO PARA O WEBSERVICE
        nomesArray.remove(at: index)
        contatosTableView.deleteRows(at: [[0,index]], with: .automatic)
        
    }
    
    private func limparFiltro(){
        nomesFiltrados = []
    }
    
    private func buscarContatos(){
        
        let conn = ConexaoWebService()
        conn.inserirParametro(paramKey: "code", paramValue: Credenciais.getSessao()!)
        conn.realizarConexao(funcao: "consultarContatos", metodo: "GET") { (objeto) in
            
            DispatchQueue.main.async(execute: {
                
                self.nomesArray = objeto["Nomes"] as! Array<String>
                self.mensagemArray = objeto["Mensagem"] as! Array<String>
                self.dataArray = objeto["Data"] as! Array<String>
                self.notificacoesArray = objeto["Notificacoes"] as! Array<Int>
                
                
                self.contatosTableView.reloadData();
                self.aguardeLabel.isHidden = true
                self.contatosTableView.isHidden = false
            })
        }
        
    }
    
    @IBAction func searchButtonClicked(_ sender: Any) {
        rightButtons = self.navigationItem.rightBarButtonItems!
        self.navigationItem.rightBarButtonItems = nil
        searchBar.showsCancelButton = true
        searchBar.delegate = self
        UISearchBar.animate(withDuration: 0.5) {
            self.navigationItem.titleView = self.searchBar
            self.searchBar.becomeFirstResponder()
        }
    }
    
}
