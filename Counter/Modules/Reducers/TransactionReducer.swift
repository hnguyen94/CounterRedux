import Foundation

enum TransactionReducer {
  static func makeTransactionState(_ state: TransactionState, _ action: TransactionAction) -> TransactionState {
    switch action {
    case let .withdraw(unformattedMoney):
      return Self.withdrawHandler(currentState: state, unformattedMoney: unformattedMoney)
      
    case let .deposit(unformattedMoney):
      return Self.depositHandler(currentState: state, unformattedMoney: unformattedMoney)
    case .reset:
      return .init(balance: 0, progress: .initial)
    }
  }
}

// MARK: - Helpers

extension TransactionReducer {
  static func validateState(currentState: TransactionState, unformattedMoney: String) -> TransactionState {
    guard let formattedMoney = unformattedMoney.formattedMoney else {
      return TransactionState(balance: currentState.balance, progress: .failed(.failedFormatting), isFallbackState: true)
    }
    
    guard formattedMoney != 0 else {
      return TransactionState(balance: currentState.balance, progress: .initial, isFallbackState: true)
    }
    
    let temporaryState = TransactionState(
      balance: formattedMoney,
      progress: currentState.progress,
      isFallbackState: false
    )
    
    return temporaryState
  }
  
  static func withdrawHandler(currentState: TransactionState, unformattedMoney: String) -> TransactionState {
    let validatedState = Self.validateState(currentState: currentState, unformattedMoney: unformattedMoney)
    
    if validatedState.isFallbackState { return validatedState }
    
    let calculatedBalance = currentState.balance.withdrawn(with: validatedState.balance)
    return TransactionState(balance: calculatedBalance, progress: .succeed)
  }
  
  static func depositHandler(currentState: TransactionState, unformattedMoney: String) -> TransactionState {
    let validatedState = Self.validateState(currentState: currentState, unformattedMoney: unformattedMoney)
    
    if validatedState.isFallbackState { return validatedState }
    
    let calculatedBalance = currentState.balance.deposited(with: validatedState.balance)
    return TransactionState(balance: calculatedBalance, progress: .succeed)
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
