//
//  PesquisaSimples.swift
//  HptMobileIOS
//
//  Created by Rodrigo Lotrario on 08/08/17.
//  Copyright © 2017 Rodrigo Lotrario. All rights reserved.
//

import Foundation
import UIKit

protocol protocoloPesquisaSimples {
    func retornoPesquisa(selecionado: String)
}

class PesquisaSimples: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate{
    
    @IBOutlet weak var pesquisaSearchBar: UISearchBar!
    @IBOutlet weak var resultadoTableView: UITableView!
    @IBOutlet weak var subView: UIView!
    
    var pesquisando: Bool = false
    var pesquisaDelegate: protocoloPesquisaSimples? = nil
    var dataArray: Array<String> = ["1","2"]
    var dataFiltradaArray: Array<String> = []
    
    
    
    
    override func viewDidLoad() {
        
        subView.clipsToBounds = true
        subView.layer.cornerRadius = 10
        
        bordas(objeto: resultadoTableView)
        
        view.alpha = 0
        UIView.animate(withDuration: 0.3) {
            self.view.alpha = 1
        }
    }
    
    func bordas(objeto: AnyObject){
        objeto.layer.cornerRadius = 7
        objeto.layer.borderColor = UIColor.lightGray.cgColor
        objeto.layer.borderWidth = 1
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        subView.endEditing(true)
        searchBar.showsCancelButton = false
        pesquisando = false
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        subView.endEditing(true)
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        pesquisando = false
        subView.endEditing(true)
        resultadoTableView.reloadData()
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if(searchText == ""){
            pesquisando = false
        } else {
            pesquisando = true
            dataFiltradaArray = []
            for i in 0...dataArray.count-1{
                let auxSearch = searchText.lowercased().folding(options: .diacriticInsensitive, locale: .current)
                let auxData = dataArray[i].lowercased().folding(options: .diacriticInsensitive, locale: .current)
                if(auxData.contains(auxSearch)){
                    dataFiltradaArray.append(dataArray[i])
                }
            }
            
        }
        resultadoTableView.reloadData()
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(pesquisando){
            return dataFiltradaArray.count
        } else {
            return dataArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celulaPesquisaSimples", for: indexPath) as! CelulaSimplesTableView
        
        if(pesquisando){
            cell.descricaoLabel.text = dataFiltradaArray[indexPath.row]
        } else {
            cell.descricaoLabel.text = dataArray[indexPath.row]
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        subView.endEditing(true)
        pesquisaDelegate?.retornoPesquisa(selecionado: ((tableView.cellForRow(at: indexPath)) as! CelulaSimplesTableView).descricaoLabel.text!)        
        dismiss(animated: true, completion: nil)
        
        
    }
    
    @IBAction func cancelarButton(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        
    }
    
    
    
    
}
