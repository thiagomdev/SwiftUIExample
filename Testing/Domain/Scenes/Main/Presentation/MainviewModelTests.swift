//
//  MainviewModelTests.swift
//  SwiftUI_Tests
//
//  Created by Thiago Monteiro on 27/05/25.
//

import Testing
@testable import SwiftUI_

@Suite("MainviewModel", .serialized)
actor MainviewModelTests {

    @Test(arguments: ["00000-000"])
    func load(cep: String) async throws {
        let (sut, networkingSpy) = makeSut()
        networkingSpy.expectedCep = .fixture(cep: cep)
        
        let expected = try #require(networkingSpy.expectedCep)
        #expect(expected != nil)
        
        try await sut.load(data: cep)
        
        #expect(networkingSpy.fetchCepCalled == true)
        #expect(networkingSpy.fetchCepCount == 1)
        #expect(networkingSpy.messages == [.fetchCep(data: cep)])
    }
    
    @Test
    func logradouro() async throws {
        let (sut, networkingSpy) = makeSut()
        networkingSpy.expectedCep = .fixture(logradouro: "")
        
        let logradouro = sut.logradouro
        
        #expect(networkingSpy.expectedCep?.logradouro == logradouro)
    }
    
    @Test
    func bairro() async throws {
        let (sut, networkingSpy) = makeSut()
        networkingSpy.expectedCep = .fixture(bairro: "")
        
        let bairro = sut.bairro
        
        #expect(networkingSpy.expectedCep?.bairro == bairro)
    }
    
    @Test
    func localidade() async throws {
        let (sut, networkingSpy) = makeSut()
        networkingSpy.expectedCep = .fixture(localidade: "")
        
        let localidade = sut.localidade
        
        #expect(networkingSpy.expectedCep?.localidade == localidade)
    }
    
    @Test
    func regiao() async throws {
        let (sut, networkingSpy) = makeSut()
        networkingSpy.expectedCep = .fixture(regiao: "")
        
        let regiao = sut.regiao
        
        #expect(networkingSpy.expectedCep?.regiao == regiao)
    }
}

extension MainviewModelTests {
    private func makeSut() -> (sut: MainViewModel, networkingSpy: NetworkingSpy) {
        let networkingSpy = NetworkingSpy()
        let sut = MainViewModel(networking: networkingSpy)
        return (sut, networkingSpy)
    }
}
