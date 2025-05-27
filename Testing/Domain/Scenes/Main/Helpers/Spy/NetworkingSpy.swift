//
//  NetworkingSpy.swift
//  SwiftUI_
//
//  Created by Thiago Monteiro on 27/05/25.
//

@testable import SwiftUI_
final class NetworkingSpy: Networking {
    enum Message: Hashable {
        case fetchCep(data: String)
    }
    
    private(set) var messages = Set<Message>()
    
    var expectedCep: Cep?
    private(set) var fetchCepCalled: Bool = false
    private(set) var fetchCepCount: Int = 0
    
    func fetchCep(_ data: String) async throws -> Cep? {
        fetchCepCalled = true
        fetchCepCount += 1
        messages.insert(.fetchCep(data: data))
        return expectedCep
    }
}
