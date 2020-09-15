import Foundation

enum AppReducer {
  static func makeAppState(state: AppState, action: AppAction) -> AppState {
    switch action {
    case let .transaction(action):
      let newTransactionState = TransactionReducer.makeTransactionState(state.transaction, action)
      return AppState(transaction: newTransactionState)
    }
  }
}

