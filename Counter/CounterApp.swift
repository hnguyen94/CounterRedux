import SwiftUI

@main
struct CounterApp: App {
  var body: some Scene {
    WindowGroup {
      let appState = AppState(transaction: TransactionState(balance: 0, requestState: .initial, isFallbackState: false))
      let store = Store(appState: appState)
      ContentView().environmentObject(store)
    }
  }
}
