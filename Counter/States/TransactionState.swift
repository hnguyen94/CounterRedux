import Foundation

struct TransactionState {
  enum RequestState: Equatable {
    case succeed
    case failed(TransactionError)
    case initial
  }
  
  let balance: Int
  let requestState: RequestState
}

extension TransactionState: Equatable {}

//  MARK: - Error

enum TransactionError: Error {
  case failedFormatting
  case bar
}
