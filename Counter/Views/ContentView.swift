import SwiftUI

struct ContentView: View {
  @EnvironmentObject var store: Store
  @State var money: String = ""
  
  var body: some View {
    VStack {
      Text("Status")
        .foregroundColor(store.appState.transaction.progress.resultColor)
      
      Text("\(store.appState.transaction.balance)€")
        .foregroundColor(store.appState.transaction.balance.balanceColor)
        .padding()
      
      TextField("e.g. 100€", text: $money)
        .padding()
      
      HStack {
        Button("Deposit Money") {
          store.dispatch(.transaction(.deposit(money)))
          money = ""
        }
        
        Button("Withdraw Money") {
          store.dispatch(.transaction(.withdraw(money)))
          money = ""
        }
      }.padding()
      
      Button("Reset Money") {
        store.dispatch(.transaction(.reset))
        money = ""
      }
      
      
    }
  }
}

// MARK: - View Logic

extension TransactionState.Progress {
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

private extension Int {
  var balanceColor: Color {
    switch self {
    case _ where self > 0:
    return .green
    case _ where self < 0:
    return .red
    default:
      return .black
    }
  }
}


// MARK - Preview

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    let appState = AppState(transaction: TransactionState(balance: 0, progress: .initial, isFallbackState: false))
    let store = Store(appState: appState)
    ContentView().environmentObject(store)
  }
}

