import SwiftUI

struct MainView: View {
    @State private var inputText: String = ""
    @State private var viewModel: MainViewModeling
    
    init(viewModel: MainViewModeling) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(spacing: 8) {
            TextField("Digite um cep válido", text: $inputText)
            .multilineTextAlignment(.center)
            .textFieldStyle(.roundedBorder)
            .autocorrectionDisabled(true)
            .padding(.bottom, 8)
            
            Button("Buscar") {
                Task {
                    try await viewModel.load(data: inputText)
                    inputText = ""
                }
            }
            .foregroundStyle(.white)
            .frame(width: 100, height: 36).bold()
            .background(RoundedRectangle(cornerRadius: 4).foregroundStyle(.link))
            .padding(.bottom, 8)
            
            VStack(alignment: .leading, spacing: 12) {
                Text(viewModel.logradouro)
                Text(viewModel.bairro)
                Text(viewModel.localidade)
                Text(viewModel.regiao)
            }
            .font(.footnote)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding()
        Spacer()
    }
}
