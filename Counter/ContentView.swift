import SwiftUI

struct ContentView: View {
  @EnvironmentObject var store: Store
  
  var body: some View {
    VStack {
      Text("\(store.appState.transaction.balance) €")
        .padding()
      Button("Deposit Money") {
        store.dispatch(.transaction(.deposit))
      }
      
      Button("Withdraw Money") {
        store.dispatch(.transaction(.withdraw))
      }
    }
  }
}
  
struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    let appState = AppState(transaction: TransactionState(balance: 0))
    let store = Store(appState: appState)
    ContentView().environmentObject(store)
  }
}

