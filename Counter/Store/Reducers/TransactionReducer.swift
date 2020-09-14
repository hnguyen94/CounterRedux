import Foundation

enum TransactionReducer {
  static func makeTransactionState(_ state: TransactionState, _ action: TransactionAction) -> TransactionState {
    switch action {
    case .withdraw:
      return validatedTransactionState(state)
    case .deposit:
      return TransactionState(balance: state.balance + 1)
    }
  }
}

extension TransactionReducer {
  static func validatedTransactionState(_ currentTransactionState: TransactionState) -> TransactionState {
    if currentTransactionState.balance >= 1 {
      return TransactionState(balance: currentTransactionState.balance - 1)
    }
    
    return TransactionState(balance: currentTransactionState.balance)
  }
}
