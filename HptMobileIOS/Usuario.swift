//
//  Usuario.swift
//  HptMobileIOS
//
//  Created by Rodrigo Lotrario on 04/08/17.
//  Copyright © 2017 Rodrigo Lotrario. All rights reserved.
//

import Foundation

class Usuario{
    
    private static var id = Int()
    private static var nome = String()
    private static var hash = String()
    
    public static func getNome () -> String{
        return self.nome
    }
    public static func setNome(nome: String){
        self.nome = nome
    }
    
    public static func getHash() -> String{
        return self.hash
    }
    public static func setHash(hash: String){
        self.hash = hash
    }
    
    public static func getId() -> Int{
        return self.id
    }
    public static func setId(id: Int){
        self.id = id
    }
    
    
}
