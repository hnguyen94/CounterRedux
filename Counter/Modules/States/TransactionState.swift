import Foundation

struct TransactionState {
  enum Progress: Equatable {
    case succeed
    case failed(TransactionError)
    case initial
  }
  
  /// The current balance of the user.
  let balance: Int
  /// The `progress` is the state of the transaction itself
  let progress: Progress
  /// The `fallBackState` will be set to true when the validation isn't satisfied
  /// and will be used in `TransactionReducer` to handle either the succeeded calculation or the "invalid" formatting.
  let isFallbackState: Bool
  
  init(balance: Int, progress: Progress, isFallbackState: Bool = false) {
    self.balance = balance
    self.progress = progress
    self.isFallbackState = isFallbackState
  }
}

extension TransactionState: Equatable {}

//  MARK: - Error

enum TransactionError: Error {
  case failedFormatting
}
