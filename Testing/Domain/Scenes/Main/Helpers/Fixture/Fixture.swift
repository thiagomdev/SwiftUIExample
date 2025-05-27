//
//  Fixture.swift
//  SwiftUI_
//
//  Created by Thiago Monteiro on 27/05/25.
//

@testable import SwiftUI_
extension Cep {
    static func fixture(
        cep: String = "",
        logradouro: String = "",
        bairro: String = "",
        localidade: String = "",
        regiao: String = "") -> Self {
            
        .init(
            cep: cep,
            logradouro: logradouro,
            bairro: bairro,
            localidade: localidade,
            complemento: "",
            unidade: "",
            uf: "",
            estado: "",
            regiao: regiao,
            ibge: "",
            gia: "",
            ddd: "",
            siafi: ""
        )
    }
}
