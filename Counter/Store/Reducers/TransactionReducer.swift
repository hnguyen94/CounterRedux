import Foundation

enum TransactionReducer {
  static func makeTransactionState(_ state: TransactionState, _ action: TransactionAction) -> TransactionState {
    switch action {
    case let .withdraw(unformattedMoney):
      let calculatedBalance = state.balance.withdrawn(with: unformattedMoney.formattedMoney)
      return TransactionState(balance: calculatedBalance)
      
    case let .deposit(unformattedMoney):
      let calculatedBalance = state.balance.deposited(with: unformattedMoney.formattedMoney)
      return TransactionState(balance: calculatedBalance)
    }
  }
}

extension String {
  var formattedMoney: Int {
    Int(self) ?? 0
  }
}

extension Int {
  func withdrawn(with money: Int) -> Int {
    self - money
  }
  
  func deposited(with money: Int) -> Int {
    self + money
  }
}
