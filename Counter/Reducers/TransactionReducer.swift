import Foundation

enum TransactionReducer {
  static func makeTransactionState(_ state: TransactionState, _ action: TransactionAction) -> TransactionState {
    switch action {
    case let .withdraw(unformattedMoney):
      return Self.withdrawHandler(currentState: state, unformattedMoney: unformattedMoney)
      
    case let .deposit(unformattedMoney):
      return Self.depositHandler(currentState: state, unformattedMoney: unformattedMoney)
    }
  }
}

// MARK: - Helpers

extension TransactionReducer {
  static func withdrawHandler(currentState: TransactionState, unformattedMoney: String) -> TransactionState {
    guard let formattedMoney = unformattedMoney.formattedMoney else {
      return TransactionState(balance: currentState.balance, requestState: .failed(.failedFormatting))
    }
    
    guard formattedMoney != 0 else {
      return TransactionState(balance: currentState.balance, requestState: .initial)
    }
    
    let calculatedBalance = currentState.balance.withdrawn(with: formattedMoney)
    return TransactionState(balance: calculatedBalance, requestState: .succeed)
  }
  
  static func depositHandler(currentState: TransactionState, unformattedMoney: String) -> TransactionState {
    guard let formattedMoney = unformattedMoney.formattedMoney else {
      return TransactionState(balance: currentState.balance, requestState: .failed(.failedFormatting))
    }
    
    let calculatedBalance = currentState.balance.deposited(with: formattedMoney)
    return TransactionState(balance: calculatedBalance, requestState: .succeed)
  }
}

private extension String {
  var formattedMoney: Int? {
    if self.isEmpty { return 0 }
    
    return Int(self)
  }
}

private extension Int {
  func withdrawn(with money: Int) -> Int {
    self - money
  }
  
  func deposited(with money: Int) -> Int {
    self + money
  }
}
