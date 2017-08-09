//
//  ConexaoWebService.swift
//  HptMobileIOS
//
//  Created by Rodrigo Lotrario on 22/06/17.
//  Copyright © 2017 Rodrigo Lotrario. All rights reserved.
//

import Foundation
import UIKit

class ConexaoWebService{
    
    private var endereco = "http://192.168.0.210:8080/HptMobileWS/"
    //private var endereco = "http://177.69.102.161:22119/HptMobileWS/"
    private var requestUrl :URLRequest?
    private var parametros = ""
    
    public func inserirParametro(paramKey: String, paramValue: String){
        parametros = parametros+paramKey+"="+paramValue+"&"
    }
    private func configurar(pacote: String, metodo: String, funcao: String){
        
        endereco = endereco+pacote+"/"
        
        switch metodo {
        case "GET":
            requestUrl = URLRequest(url: URL(string: endereco+funcao+"?"+parametros)!)
            break;
        case "POST":
            requestUrl = URLRequest(url: URL(string: endereco+funcao)!)
            requestUrl?.httpBody = parametros.data(using: .utf8)
            
            break;
        case "PUT":
            
            
            break;
            
            
        default:
            break;
        }
        
        requestUrl?.httpMethod = metodo
        
    }
    
    
    
    public func realizarConexao(pacote: String, funcao: String, metodo: String, completionHandler:@escaping (AnyObject) -> ()) 	{
        
        configurar(pacote: pacote, metodo: metodo, funcao: funcao)
        
        let task = URLSession.shared.dataTask(with: requestUrl!) { data, response, error in
    
            let json = try? JSONSerialization.jsonObject(with: data!, options: [])
            print(json)
            
            let usr: Usuario = Usuario(JsonDict: json! as! Dictionary<String, AnyObject>)
            
            completionHandler(json as AnyObject)
            
            if data == nil {
                print(error ?? String())
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(String(describing: response))")
            }
        }
        task.resume()
        
    }
    
}
