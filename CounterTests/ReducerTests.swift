import XCTest
@testable import Counter

class ReducerTests: XCTestCase {
  func test_reducer_whenIncrement_expectToBe1() throws {
    // Given
    let appState = AppState(counter: 0)
    
    // Then
    XCTAssertEqual(Reducer.update(appState, .increment), AppState(counter: 1))
  }
  
  func testPerformanceExample() throws {
    // This is an example of a performance test case.
    self.measure {
      // Put the code you want to measure the time of here.
    }
  }
  
}
