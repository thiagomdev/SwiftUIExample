import SwiftUI

enum MainFactory {
    @MainActor
    static func make() -> some View {
        let network = Network()
        let viewModel = MainViewModel(networking: network)
        let view = MainView(viewModel: viewModel)
        return view
    }
}
