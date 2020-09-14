import XCTest
@testable import Counter

class TransactionReducerTests: XCTestCase {
  func test_transactionReducer_whenWithdraw_expectBalanceToBe1() {
    // Given
    let transactionState = TransactionState(balance: 2)
    
    // When
    let transactionStateUnderTest = TransactionReducer.makeTransactionState(transactionState, .withdraw)
    
    // Then
    XCTAssertEqual(transactionStateUnderTest, .init(balance: 1))
  }
}
