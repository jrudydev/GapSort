import XCTest
@testable import GapSort

final class GapSortTests: XCTestCase {
  
    func testSort() throws {
      let gapSort = IntegerGapSort(values: [3, 1, 6, 4])
      XCTAssertEqual(gapSort.sortedArray(), [1, 3, 4, 6])
    }
  
}
