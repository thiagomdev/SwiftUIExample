import SwiftUI

@main
struct Main: App {
    var body: some Scene {
        WindowGroup {
            MainFactory.make()
        }
    }
}
