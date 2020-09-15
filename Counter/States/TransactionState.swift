import Foundation

struct TransactionState {
  enum RequestState: Equatable {
    case succeed
    case failed(TransactionError)
    case initial
  }
  
  let balance: Int
  let requestState: RequestState
  let isFallbackState: Bool
  
  init(balance: Int, requestState: RequestState, isFallbackState: Bool = false) {
    self.balance = balance
    self.requestState = requestState
    self.isFallbackState = isFallbackState
  }
}

extension TransactionState: Equatable {}

//  MARK: - Error

enum TransactionError: Error {
  case failedFormatting
  case bar
}
