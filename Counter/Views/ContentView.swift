import SwiftUI

struct ContentView: View {
  @EnvironmentObject var store: Store
  @State var money: String = ""
  
  var body: some View {
    VStack {
      Text("Status")
        .foregroundColor(store.appState.transaction.requestState.resultColor)
      
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

// MARK: - View Logic

private extension TransactionState.RequestState {
  var resultColor: Color {
    switch self {
    case .succeed:
      return .green
    case .failed(_):
      return .red
    case .initial:
      return .gray
    }
  }
}


// MARK - Preview

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    let appState = AppState(transaction: TransactionState(balance: 0, requestState: .initial))
    let store = Store(appState: appState)
    ContentView().environmentObject(store)
  }
}

