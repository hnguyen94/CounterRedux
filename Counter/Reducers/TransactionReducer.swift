import Foundation

enum TransactionReducer {
  static func makeTransactionState(_ state: TransactionState, _ action: TransactionAction) -> TransactionState {
    switch action {
    case let .withdraw(unformattedMoney):
      guard let formattedMoney = unformattedMoney.formattedMoney else {
        return TransactionState(balance: state.balance, requestState: .failed(.failedFormatting))
      }
      
      let calculatedBalance = state.balance.withdrawn(with: formattedMoney)
      return TransactionState(balance: calculatedBalance, requestState: .succeed)
      
    case let .deposit(unformattedMoney):
      guard let formattedMoney = unformattedMoney.formattedMoney else {
        return TransactionState(balance: state.balance, requestState: .failed(.failedFormatting))
      }
      
      let calculatedBalance = state.balance.deposited(with: formattedMoney)
      return TransactionState(balance: calculatedBalance, requestState: .succeed)
    }
  }
}

extension String {
  var formattedMoney: Int? { Int(self) }
}

extension Int {
  func withdrawn(with money: Int) -> Int {
    self - money
  }
  
  func deposited(with money: Int) -> Int {
    self + money
  }
}
