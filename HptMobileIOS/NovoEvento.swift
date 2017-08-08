//
//  NovoEvento.swift
//  HptMobileIOS
//
//  Created by Rodrigo Lotrario on 26/07/17.
//  Copyright © 2017 Rodrigo Lotrario. All rights reserved.
//

import Foundation
import UIKit

class NovoEvento: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate,UITableViewDelegate, UITableViewDataSource, retornarDataDelegate, retornarTarefaDelegate, protocoloConfirmarAcao, protocoloPesquisaSimples{
    
    @IBOutlet weak var bottomNavigationBar: UINavigationBar!
    @IBOutlet weak var mainScrollView: UIScrollView!
    @IBOutlet weak var mainNavigationBar: UINavigationBar!
    
    @IBOutlet weak var topoView: UIView!
    @IBOutlet weak var tarefasView: UIView!
    
    @IBOutlet weak var localPickerView: UIPickerView!
    @IBOutlet weak var responsavelPickerView: UIPickerView!
    
    @IBOutlet weak var inicioButton: UIButton!
    @IBOutlet weak var finalButton: UIButton!
    
    @IBOutlet weak var tituloTextField: UITextField!
    @IBOutlet weak var tarefasTableView: UITableView!
    @IBOutlet weak var removerTarefaButton: UIButton!
    @IBOutlet weak var editarTarefaButton: UIButton!
    
    var retornoMap = NSMapTable<NSString,AnyObject>()
    
    var local: String = ""
    var responsavel: String = ""
    var filtro: String = ""
    var tarefas: Array<Array<String>> = []
    var formatter = DateFormatter()
    var dataInicio = Date()
    var dataFinal = Date()
    var dataButton: Int = 0
    
    private var locais: Array<String> = ["Local 01","Local 02","Local 03","Local 04","Local 05","Local 06","Local 07","Local 08"]
    private var responsaveis: Array<String> = ["Tecnico 1","Tecnico 2","Tecnico 3","Tecnico 4","Tecnico 5"]
    
    override func viewDidLoad() {
        bordas()
        view.frame.size.width = InfoGlobal.getWidth()
        
        
        local = locais[0]
        responsavel = responsaveis[0]
        
        inicioButton.setTitle(InfoGlobal.getDataAtual(tipo: "completaHora"), for: .normal)
        finalButton.setTitle(InfoGlobal.getDataAtual(tipo: "completaHora"), for: .normal)
        
        
    }
    
    private func bordas(){
        
        topoView.layer.cornerRadius = 10
        tarefasView.layer.cornerRadius = 10
        
        tarefasTableView.layer.cornerRadius = 5
        tarefasTableView.layer.borderWidth = 0.3
        tarefasTableView.layer.borderColor = UIColor.lightGray.cgColor
        
        
        
        bordasPickerView(picker: localPickerView)
        bordasPickerView(picker: responsavelPickerView)
        
    }
    private func bordasPickerView(picker: UIPickerView){
        picker.layer.borderWidth = 0.3
        picker.layer.cornerRadius = 5
        picker.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    func retornarData(dataSelecionada: Date) {
        if(dataButton==1){
            dataInicio = dataSelecionada
            formatter.dateFormat = "E, d MMM yyyy"
            inicioButton.setTitle(formatter.string(from: dataSelecionada).capitalized, for: .normal)
            formatter.dateFormat = "HH:mm"
            inicioButton.setTitle("\(inicioButton.currentTitle ?? String())     \(formatter.string(from: dataSelecionada))", for: .normal)
        }
        if(dataButton==2){
            dataFinal = dataSelecionada
            formatter.dateFormat = "E, d MMM yyyy"
            finalButton.setTitle(formatter.string(from: dataSelecionada).capitalized, for: .normal)
            formatter.dateFormat = "HH:mm"
            finalButton.setTitle("\(finalButton.currentTitle ?? String())     \(formatter.string(from: dataSelecionada))", for: .normal)
        }
        
    }

    func retornarTarefa(tarefa: Array<String>) {
        tarefas.append(tarefa)
        
        tarefasTableView.reloadData()
    }
    
    func retornoAcao(confirmar: Bool) {
        if(confirmar){
            tarefas.remove(at: (tarefasTableView.indexPathForSelectedRow?.row)!)
            tarefasTableView.reloadData()
            removerTarefaButton.isEnabled = false
            editarTarefaButton.isEnabled = false
        } else {
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tarefas.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celulaSimples", for: indexPath) as! CelulaSimplesTableView
        
        cell.descricaoLabel.text = tarefas[indexPath.row][0]
        cell.imagem.image = imagemPrioridade(numero: Int(tarefas[indexPath.row][2])!)
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        removerTarefaButton.isEnabled = true
        editarTarefaButton.isEnabled = true
        
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        removerTarefaButton.isEnabled = false
        editarTarefaButton.isEnabled = false
        
    }
    
    private func imagemPrioridade(numero: Int) -> UIImage{
        
        switch numero {
        case 1:
            return UIImage(named: "circuloVerde")!
        case 2:
            return UIImage(named: "circuloAmarelo")!
        case 3:
            return UIImage(named: "circuloVermelho")!
            
        default:
            return UIImage(named: "circuloVerde")!
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
        case localPickerView:
            local = locais[row]
            break
        case responsavelPickerView:
            responsavel = responsaveis[row]
        default:
            break
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        switch pickerView {
            
        case localPickerView:
            return locais.count
            
        case responsavelPickerView:
            return responsaveis.count
        
        default:
            return 1
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
        case localPickerView:
            return locais[row]
        case responsavelPickerView:
            return responsaveis[row]
        default:
            return ""
        }
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        switch pickerView {
        
        default:
            return 1
        }
        
    }
    
    func retornoPesquisa(selecionado: String) {
        
        if(filtro=="local"){
            for i in 0...locais.count-1{
                if(locais[i] == selecionado){
                    localPickerView.selectRow(i, inComponent: 0, animated: true)
                    local = selecionado
                }
            }
        } else {
            for i in 0...responsaveis.count-1{
                if(responsaveis[i] == selecionado){
                    responsavelPickerView.selectRow(i, inComponent: 0, animated: true)
                    responsavel = selecionado
                }
            }
        }
    }
    
    @IBAction func pesquisarLocalButton(_ sender: Any) {
        
        filtro = "local"
        let vc = storyboard?.instantiateViewController(withIdentifier: "pesquisaSimples") as? PesquisaSimples
        vc?.dataArray = self.locais
        vc?.pesquisaDelegate = self
        present(vc!, animated: true, completion: nil)
        
    }
    
    @IBAction func inicioButtonClick(_ sender: Any) {
        
        dataButton = 1
        let dataVC = storyboard?.instantiateViewController(withIdentifier: "calendarioDataHora") as? CalendarioDataHora
        dataVC?.dataDelegate = self
        dataVC?.indiceHora = InfoGlobal.getDataAtual(tipo: "hora24")
        dataVC?.indiceDia = InfoGlobal.getDataAtual(tipo: "dia")
        dataVC?.indiceMes = InfoGlobal.getDataAtual(tipo: "mes")
        dataVC?.indiceAno = Int(InfoGlobal.getDataAtual(tipo: "ano"))!
        present(dataVC!, animated: true, completion: nil)
        
    }
    @IBAction func finalButtonClick(_ sender: Any) {
        
        dataButton = 2
        let dataVC = storyboard?.instantiateViewController(withIdentifier: "calendarioDataHora") as? CalendarioDataHora
        dataVC?.dataDelegate = self
        dataVC?.indiceHora = InfoGlobal.getDataAtual(tipo: "hora24")
        dataVC?.indiceDia = InfoGlobal.getDataAtual(tipo: "dia")
        dataVC?.indiceMes = InfoGlobal.getDataAtual(tipo: "mes")
        dataVC?.indiceAno = Int(InfoGlobal.getDataAtual(tipo: "ano"))!
        present(dataVC!, animated: true, completion: nil)
    }
    
    @IBAction func pesquisarResponsavelButton(_ sender: Any) {
        
        filtro = "responsavel"
        let vc = storyboard?.instantiateViewController(withIdentifier: "pesquisaSimples") as? PesquisaSimples
        vc?.dataArray = self.responsaveis
        vc?.pesquisaDelegate = self
        present(vc!, animated: true, completion: nil)
        
        
    }
    
    @IBAction func novaTarefaButton(_ sender: Any) {
        
        let tarefaVC = storyboard?.instantiateViewController(withIdentifier: "novaTarefa") as? NovaTarefa
        tarefaVC?.tarefaDelegate = self
        present(tarefaVC!, animated: true, completion: nil)
        
    }
    @IBAction func removerTarefaButton(_ sender: Any) {
        
        let vc  = storyboard?.instantiateViewController(withIdentifier: "confirmarViewController") as? ConfirmarAcao
        vc?.acaoDelegate = self
        vc?.acao = "Excluir tarefa selecionada ?"
        present(vc!, animated: true, completion: nil)
        
    }
    
    @IBAction func confirmarButton(_ sender: Any) {
        
        retornoMap.setObject(tituloTextField.text! as AnyObject, forKey: "titulo")
        retornoMap.setObject(local as AnyObject, forKey: "local")
        retornoMap.setObject(responsavel as AnyObject, forKey: "responsavel")
        retornoMap.setObject(tarefas as AnyObject, forKey: "tarefa")
        print(retornoMap)
        
        
    }
    
    @IBAction func cancelarEventoButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}




















