import XCTest
@testable import Counter

class TransactionReducerTests: XCTestCase {
  func test_transactionReducer_whenWithdraw_expectBalanceToBe1() {
    // Given
    let transactionState = TransactionState(balance: 2)
    
    // When
    let transactionStateUnderTest = TransactionReducer.makeTransactionState(transactionState, .withdraw("1"))
    
    // Then
    XCTAssertEqual(transactionStateUnderTest, .init(balance: 1))
    
  }
  
  func test_transactionReducer_whenWithdraw_expectBalanceToBeNegative() {
    // Given
    let transactionState = TransactionState(balance: 0)
    
    // When
    let transactionStateUnderTest = TransactionReducer.makeTransactionState(transactionState, .withdraw("1"))
    
    // Then
    XCTAssertEqual(transactionStateUnderTest, .init(balance: -1))
  }
  
  func test_transactionReducer_whenDeposit_expectBalanceToBe1() {
    // Given
    let transactionState = TransactionState(balance: 0)
    
    // When
    let transactionStateUnderTest = TransactionReducer.makeTransactionState(transactionState, .deposit("1"))
    
    // Then
    XCTAssertEqual(transactionStateUnderTest, .init(balance: 1))
  }
}
