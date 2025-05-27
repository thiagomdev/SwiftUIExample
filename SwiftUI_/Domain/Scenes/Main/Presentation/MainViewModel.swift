import SwiftUI
import Foundation


protocol MainViewModeling {
    func load(data: String) async throws
    
    var logradouro: String { get }
    var bairro: String { get }
    var localidade: String { get }
    var regiao: String { get }
}

final class MainViewModel: ObservableObject {
    @Published private var dataCep: Cep?
    private var networking: Networking
    
    init(networking: Networking) {
        self.networking = networking
    }
}

extension MainViewModel: MainViewModeling {
    func load(data: String) async throws {
        if let dataObject = try await networking.fetchCep(data) {
            await MainActor.run {
                dataCep = dataObject
            }
        }
    }
    
    var logradouro: String {
        guard let logradouro = dataCep?.logradouro else { return "" }
        return "Logradouro: \(logradouro)"
    }
    
    var bairro: String {
        guard let bairro = dataCep?.bairro else { return "" }
        return "Bairro: \(bairro)"
    }
    
    var localidade: String {
        guard let localidade = dataCep?.localidade else { return "" }
        return "Localidade: \(localidade)"
    }
    
    var regiao: String {
        guard let regiao = dataCep?.regiao else { return "" }
        return "Região: \(regiao)"
    }
}
