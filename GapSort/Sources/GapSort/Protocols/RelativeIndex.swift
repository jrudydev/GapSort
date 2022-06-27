//
//  RelativeIndex.swift
//  
//
//  Created by Rudy Gomez on 6/27/22.
//


///
/// This protocol defines an object that can caculate an ordereed index from an integer from withing an
/// unsorted array. It can also find the value associated with an orderd index.
///
protocol RelativeIndex {
  
  ///
  /// A list of unsorted integers.
  ///
  var unsortedValues: [Int] { get }
  
  ///
  /// Finds the ordered index for the value associtated with the passed in unsorted index.
  /// - Parameters: originalIndex - Unsorted index.
  /// - Returns: The correct ordered index.
  ///
  func indexFor(originalIndex: Int) -> Int
  
  ///
  /// Finds the value for the passed in ordered index.
  /// - Parameters: orderedIndex - Index for the value in an ordered array.
  /// - Returns: The value for the index.
  ///
  func valueFor(orderedIndex: Int) -> Int?

}

extension RelativeIndex  {
  
  ///
  /// Returns an ordered array by creating a temporary array and inserting each value into the correct index.
  ///
  func sortedArray() -> [Int] {
    var sortedArray: [Int] = Array(repeating: 0, count: unsortedValues.count)
    
    for x in 0..<unsortedValues.count {
      let orderedArray = indexFor(originalIndex: x)
      sortedArray[orderedArray] = unsortedValues[x]
    }
    
    return sortedArray
  }
  
}
