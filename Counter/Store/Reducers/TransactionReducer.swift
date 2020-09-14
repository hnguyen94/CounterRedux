import Foundation

enum TransactionReducer {
  static func makeTransactionState(_ state: TransactionState, _ action: TransactionAction) -> TransactionState {
    switch action {
    case .withdraw:
      return TransactionState(balance: state.balance - 1)
    case .deposit:
      return TransactionState(balance: state.balance + 1)
    }
  }
}
