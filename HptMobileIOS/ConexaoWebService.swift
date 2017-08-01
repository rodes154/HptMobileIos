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
    
    //private let endereco = "http://192.168.0.116:8080/HptMobileWS/pacoteFuncoes/"
    private let endereco = "http://177.69.102.161:22119/HptMobileWS/pacoteFuncoes/"
    private var requestUrl :URLRequest?
    private var parametros = ""
    
    public func inserirParametro(paramKey: String, paramValue: String){
        parametros = parametros+paramKey+"="+paramValue+"&"
    }
    private func configurar(metodo: String, funcao: String){
        
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
    
    
    
    public func realizarConexao(funcao: String, metodo: String, completionHandler:@escaping (Dictionary<String, Any>) -> ()) 	{
        
        configurar(metodo: metodo, funcao: funcao)
        
        var dictFromJson:Dictionary<String, Any>?
        
        let task = URLSession.shared.dataTask(with: requestUrl!) { data, response, error in
    
            let json = try? JSONSerialization.jsonObject(with: data!, options: [])
            dictFromJson = (json as?[String:Any])!
            completionHandler(dictFromJson!)
            
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
