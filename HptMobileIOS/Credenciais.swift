//
//  CredenciaisClass.swift
//  HptMobileIOS
//
//  Created by Rodrigo Lotrario on 26/07/17.
//  Copyright © 2017 Rodrigo Lotrario. All rights reserved.
//

import Foundation

class Credenciais {
    private static var sessao: String?
    private static var acesso: Int?
    
    public static func setSessao(param: String?){
        sessao = param
    }
    public static func getSessao() -> String?{
        return sessao
    }
    public static func setAcesso(param: Int){
        acesso = param
    }
    public static func getAcesso() -> Int?{
        return acesso
    }
    
    
    
    
    
}
