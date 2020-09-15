import SwiftUI

struct ContentView: View {
  @EnvironmentObject var store: Store
  @State var money: String = ""
  
  var body: some View {
    VStack {
      Text("\(store.appState.transaction.balance)€")
        .padding()
      
      TextField("e.g. 100€", text: $money)
        .padding()

      HStack {
        Button("Deposit Money") {
          store.dispatch(.transaction(.deposit(money)))
        }
        
        Button("Withdraw Money") {
          store.dispatch(.transaction(.withdraw(money)))
        }
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

