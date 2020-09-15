import XCTest
@testable import Counter

class TransactionReducerTests: XCTestCase {
  func test_transactionReducer_whenWithdraw_expectBalanceToBe1() {
    // Given
    let transactionState = TransactionState(balance: 2, progress: .initial)
    
    // When
    let transactionStateUnderTest = TransactionReducer.makeTransactionState(transactionState, .withdraw("1"))
    
    // Then
    XCTAssertEqual(transactionStateUnderTest, .init(balance: 1, progress: .succeed))
    
  }
  
  func test_transactionReducer_whenWithdraw_expectBalanceToBeNegative() {
    // Given
    let transactionState = TransactionState(balance: 0, progress: .initial)
    
    // When
    let transactionStateUnderTest = TransactionReducer.makeTransactionState(transactionState, .withdraw("1"))
    
    // Then
    XCTAssertEqual(transactionStateUnderTest, .init(balance: -1, progress: .succeed))
  }
  
  func test_transactionReducer_whenDeposit_expectBalanceToBe1() {
    // Given
    let transactionState = TransactionState(balance: 0, progress: .succeed)
    
    // When
    let transactionStateUnderTest = TransactionReducer.makeTransactionState(transactionState, .deposit("1"))
    
    // Then
    XCTAssertEqual(transactionStateUnderTest, .init(balance: 1, progress: .succeed))
  }
  
  func test_transactionReducer_whenWithdrawWithError_expectprogressFailedFormatting() {
    // Given
    let transactionState = TransactionState(balance: 0, progress: .initial)
    
    // When
    let transactionStateUnderTest = TransactionReducer.makeTransactionState(transactionState, .deposit("laksjdlkasjd!l-"))
    
    // Then
    XCTAssertEqual(transactionStateUnderTest, .init(balance: 0, progress: .failed(.failedFormatting), isFallbackState: true))
  }
  
  func test_transactionReducer_whenWithdrawWithEmptyTextField_expectprogressSucceed() {
    // Given
    let transactionState = TransactionState(balance: 0, progress: .initial)
    
    // When
    let transactionStateUnderTest = TransactionReducer.makeTransactionState(transactionState, .withdraw(""))
    
    // Then
    XCTAssertEqual(transactionStateUnderTest, .init(balance: 0, progress: .initial, isFallbackState: true))
  }
  
  func test_transactionReducer_whenDepositWithEmptyTextField_expectprogressSucceed() {
    // Given
    let transactionState = TransactionState(balance: 0, progress: .initial)
    
    // When
    let transactionStateUnderTest = TransactionReducer.makeTransactionState(transactionState, .deposit(""))
    
    // Then
    XCTAssertEqual(transactionStateUnderTest, .init(balance: 0, progress: .initial, isFallbackState: true))
  }
}
