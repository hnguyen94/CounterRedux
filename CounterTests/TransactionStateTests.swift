import XCTest
@testable import Counter

class TransactionStateTests: XCTestCase {
  // MARK: - View Logic
  
  func test_resultColor_whenInitial_toBeGray() {
    // Given
    let sut = TransactionState(balance: 0, progress: .initial)

    // Then
    XCTAssertEqual(sut.progress.resultColor, .gray)
  }
  
  func test_resultColor_whenSucceed_toBeGreen() {
    // Given
    let sut = TransactionState(balance: 0, progress: .succeed)

    // Then
    XCTAssertEqual(sut.progress.resultColor, .green)
  }
  
  func test_resultColor_whenFailed_toBeRed() {
    // Given
    let sut = TransactionState(balance: 0, progress: .failed(.failedFormatting))

    // Then
    XCTAssertEqual(sut.progress.resultColor, .red)
  }
  

}
