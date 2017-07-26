//
//  Aba5Tabela.swift
//  HptMobileIOS
//
//  Created by Rodrigo Lotrario on 27/06/17.
//  Copyright © 2017 Rodrigo Lotrario. All rights reserved.
//

import Foundation
import UIKit

class AbaPacotesTabela: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    var tableDict: Dictionary<Int,Array<String>>?
    var listaGeral: Array<Any> = []
    
    var keys: Array<Any> = []
    var nomes: Array<String> = []
    var logs: Array<String> = []
    var data: Array<String> = []
    
    public var index: Int?
    
    var pesquisando: Bool = false
    
    @IBOutlet weak var labelAguarde: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buscarPacotes()
        
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return nomes.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        cell.textLabel?.text = self.nomes[indexPath.row]
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        index = indexPath.row
        tableView.deselectRow(at: [0,index!], animated: false)
        prepare(for: UIStoryboardSegue.init(identifier: "mostrarDescicao", source: self, destination: self), sender: nil)
        performSegue(withIdentifier: "mostrarDescricao", sender: nil)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "mostrarDescricao"){
            let nextView = segue.destination as! AbaPacotesDescricao
            nextView.preencherDescricao(indice: index!+1, descricao: logs[index!])
        }
    }
    
    private func buscarPacotes(){
        
        let conn = ConexaoWebService()
        conn.realizarConexao(funcao: "consultarPacotes", metodo: "GET") { (objeto) in
            
            DispatchQueue.main.async(execute: {
                
                for i in 0...objeto.count-1{
                    if(objeto.keys.contains(String(i))){
                        self.keys.append(i)
                        let tempList = objeto[String(i)] as! Array<String>
                        self.nomes.append(tempList[0])
                        self.logs.append(tempList[1])
                        self.data.append(tempList[2])
                    }
                }
                self.listaGeral.append(self.keys)
                self.listaGeral.append(self.nomes)
                self.listaGeral.append(self.logs)
                self.listaGeral.append(self.data)
                
                self.tableView.reloadData()
                self.tableView.isHidden = false
                self.labelAguarde.isHidden = true
                self.prepare(for: UIStoryboardSegue.init(identifier: "mostrarTabela", source: self, destination: self), sender: nil)
                
            })
        }
        
    }
    
}
