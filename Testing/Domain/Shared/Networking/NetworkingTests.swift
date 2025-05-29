//
//  NetworkingTests.swift
//  SwiftUI_Tests
//
//  Created by Thiago Monteiro on 27/05/25.
//

import Testing
import Foundation
@testable import SwiftUI_

@Suite("Networking", .serialized)
actor NetworkingTests {
    @Test(arguments: [("00000000")])
    func fetch(cep: String) async throws {
        let (sut, mock) = makeSut()
        let cepData = """
          {
             "cep": "\(cep)",
             "logradouro": "Praça da Sé",
             "complemento": "lado ímpar",
             "unidade": "",
             "bairro": "Sé",
             "localidade": "São Paulo",
             "uf": "SP",
             "estado": "São Paulo",
             "regiao": "Sudeste",
             "ibge": "3550308",
             "gia": "1004",
             "ddd": "11",
             "siafi": "7107"
          }
          """.data(using: .utf8)!
        
        mock.mockData = cepData
        mock.mockResponse = HTTPURLResponse(
            url: URL(string: "https://www.example.com")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: ["Content-Type": "application/json"])
        
        do {
            let result = try await sut.fetchCep(cep)
            #expect(result != nil)
            #expect(result?.cep == cep)
            #expect(result?.logradouro == "Praça da Sé")
            #expect(result?.localidade == "São Paulo")
            #expect(result?.uf == "SP")
        } catch {
            Issue.record(error, "Expected success but got error: \(error)")
        }
    }
    
    @Test
    func fetch_cep_different_status_codes() async throws {
        let (sut, mock) = makeSut()
        let errorData = """
           {
               "erro": "true"
           }
           """.data(using: .utf8)!
        
        mock.mockData = errorData
        mock.mockResponse = HTTPURLResponse(
            url: URL(string: "https://viacep.com.br/ws/00000000/json/")!,
            statusCode: 200, // ViaCEP retorna 200 mesmo para CEPs inválidos
            httpVersion: nil,
            headerFields: nil
        )
        
        await #expect(throws: DecodingError.self) {
            try await sut.fetchCep("00000000")
        }
    }
    
}

extension NetworkingTests {
    private func makeSut() -> (sut: Network, mock: NetworkMock) {
        let mock = NetworkMock()
        let sut = Network(session: mock)
        return (sut, mock)
    }
}
