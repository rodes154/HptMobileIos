//
//  AbaClientes.swift
//  HptMobileIOS
//
//  Created by Rodrigo Lotrario on 29/06/17.
//  Copyright © 2017 Rodrigo Lotrario. All rights reserved.
//

import Foundation
import UIKit

class AbaClientes: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate{
    
    @IBOutlet weak var clientesTableView: UITableView!
    @IBOutlet weak var labelAguarde: UILabel!
    @IBOutlet weak var searchButton: UIBarButtonItem!
    
    var nomes: Array<String> = []
    var unidade: Array<String> = []
    
    var nomesFiltrados: Array<String> = []
    var unidadeFiltrado: Array<String> = []
    
    var pesquisando: Bool = false
    
    var rightButton = UIBarButtonItem()
    var searchBar = UISearchBar()
    
    
    override func viewDidLoad() {
        buscarClientes()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(pesquisando){
            return nomesFiltrados.count
        }else{
            return nomes.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "celulaClientes", for: indexPath) as! CelulaPadrao
        if(pesquisando){
            cell.labelPrincipal.text = nomesFiltrados[indexPath.row]
            cell.labelSecundaria.text = unidadeFiltrado[indexPath.row]
        }else{
            cell.labelPrincipal.text = nomes[indexPath.row]
            cell.labelSecundaria.text = unidade[indexPath.row]
        }
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        clientesTableView.deselectRow(at: indexPath, animated: true)
       
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle == .delete){
            nomes.remove(at: indexPath.item)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
        }
    }
    
    private func buscarClientes(){
        
        let conn = ConexaoWebService()
        conn.realizarConexao(funcao: "consultarClientes", metodo: "GET") { (objeto) in
            DispatchQueue.main.async(execute:  {
                
                let tempObject = objeto as! Dictionary<String,Any>
                
                for i in 0...tempObject.count-1{
                    if(tempObject.keys.contains(String(i))){
                        
                        let tempList = tempObject[String(i)] as! Array<String>
                        self.nomes.append(tempList[0])
                        self.unidade.append(tempList[1])
                    }
                }
                self.clientesTableView.reloadData()
                self.clientesTableView.isHidden = false
                self.labelAguarde.isHidden = true
                
            })
            
        }
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        pesquisando = false
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        UISearchBar.animate(withDuration: 0.5) { 
            self.navigationItem.titleView = nil
            self.title = "Clientes"
            self.navigationItem.rightBarButtonItem = self.rightButton
        }
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if(searchText==""){
            pesquisando = false
        }else{
            pesquisando = true
            limparFiltro()
            for i in 0...nomes.count-1{
                let auxSearch = searchText.lowercased().folding(options: .diacriticInsensitive, locale: .current)
                let auxNomes = nomes[i].lowercased().folding(options: .diacriticInsensitive, locale: .current)
                let auxUnidade = unidade[i].lowercased().folding(options: .diacriticInsensitive, locale: .current)
                if(auxNomes.contains(auxSearch) || auxUnidade.contains(auxSearch)){
                    nomesFiltrados.append(nomes[i])
                    unidadeFiltrado.append(unidade[i])
                }
            }
        }
        clientesTableView.reloadData()
    }
    func limparFiltro(){
        nomesFiltrados = []
        unidadeFiltrado = []
    }
    
    @IBAction func searchButtonClicked(_ sender: Any) {
        
        self.rightButton = self.navigationItem.rightBarButtonItem!
        self.navigationItem.rightBarButtonItem = nil
        searchBar.showsCancelButton = true
        searchBar.delegate = self
        UIView.animate(withDuration: 0.5) {
            self.navigationItem.titleView = self.searchBar
            self.searchBar.becomeFirstResponder()
        }
        
    }
}
