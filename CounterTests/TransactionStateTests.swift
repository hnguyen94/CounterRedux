import XCTest
@testable import Counter

class TransactionStateTests: XCTestCase {
  // MARK: - View Logic
  
  func test_resultColor_whenInitial_toBeGray() {
    // Given
    let sut = TransactionState(balance: 0, requestState: .initial)

    // Then
    XCTAssertEqual(sut.requestState.resultColor, .gray)
  }
  
  func test_resultColor_whenSucceed_toBeGreen() {
    // Given
    let sut = TransactionState(balance: 0, requestState: .succeed)

    // Then
    XCTAssertEqual(sut.requestState.resultColor, .green)
  }
  
  func test_resultColor_whenFailed_toBeRed() {
    // Given
    let sut = TransactionState(balance: 0, requestState: .failed(.failedFormatting))

    // Then
    XCTAssertEqual(sut.requestState.resultColor, .red)
  }
  

}
