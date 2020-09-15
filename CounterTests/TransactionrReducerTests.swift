import XCTest
@testable import Counter

class TransactionReducerTests: XCTestCase {
  func test_transactionReducer_whenWithdraw_expectBalanceToBe1() {
    // Given
    let transactionState = TransactionState(balance: 2, requestState: .initial)
    
    // When
    let transactionStateUnderTest = TransactionReducer.makeTransactionState(transactionState, .withdraw("1"))
    
    // Then
    XCTAssertEqual(transactionStateUnderTest, .init(balance: 1, requestState: .succeed))
    
  }
  
  func test_transactionReducer_whenWithdraw_expectBalanceToBeNegative() {
    // Given
    let transactionState = TransactionState(balance: 0, requestState: .initial)
    
    // When
    let transactionStateUnderTest = TransactionReducer.makeTransactionState(transactionState, .withdraw("1"))
    
    // Then
    XCTAssertEqual(transactionStateUnderTest, .init(balance: -1, requestState: .succeed))
  }
  
  func test_transactionReducer_whenDeposit_expectBalanceToBe1() {
    // Given
    let transactionState = TransactionState(balance: 0, requestState: .succeed)
    
    // When
    let transactionStateUnderTest = TransactionReducer.makeTransactionState(transactionState, .deposit("1"))
    
    // Then
    XCTAssertEqual(transactionStateUnderTest, .init(balance: 1, requestState: .succeed))
  }
  
  func test_transactionReducer_whenWithdrawWithError_expectRequestStateFailedFormatting() {
    // Given
    let transactionState = TransactionState(balance: 0, requestState: .initial)
    
    // When
    let transactionStateUnderTest = TransactionReducer.makeTransactionState(transactionState, .deposit("laksjdlkasjd!l-"))
    
    // Then
    XCTAssertEqual(transactionStateUnderTest, .init(balance: 0, requestState: .failed(.failedFormatting), isFallbackState: true))
  }
  
  func test_transactionReducer_whenWithdrawWithEmptyTextField_expectRequestStateSucceed() {
    // Given
    let transactionState = TransactionState(balance: 0, requestState: .initial)
    
    // When
    let transactionStateUnderTest = TransactionReducer.makeTransactionState(transactionState, .withdraw(""))
    
    // Then
    XCTAssertEqual(transactionStateUnderTest, .init(balance: 0, requestState: .initial, isFallbackState: true))
  }
  
  func test_transactionReducer_whenDepositWithEmptyTextField_expectRequestStateSucceed() {
    // Given
    let transactionState = TransactionState(balance: 0, requestState: .initial)
    
    // When
    let transactionStateUnderTest = TransactionReducer.makeTransactionState(transactionState, .deposit(""))
    
    // Then
    XCTAssertEqual(transactionStateUnderTest, .init(balance: 0, requestState: .initial, isFallbackState: true))
  }
}
