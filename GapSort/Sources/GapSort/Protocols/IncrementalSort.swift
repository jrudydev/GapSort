//
//  IncrementalSort.swift
//  
//
//  Created by Rudy Gomez on 6/27/22.
//


///
/// This protocol defines an object that will incrementally sort an array of integers.
///
protocol IncrementalSort: AnyObject {
  
  ///
  /// A list of unordered integer values.
  ///
  var unsortedValues: [Int] { get set }
  
  ///
  /// These values represent the current state of the sort.
  ///
  var incrementalValues: [Int] { get set }
  
  ///
  /// This index is need to keep track of what values have been sorted.
  ///
  var incrementalIndex: Int { get set }

  ///
  /// Call this method to sort just one value in the array.
  ///
  /// - Returns: The array with one additional value sorted.
  ///
  func incrementalSort() -> [Int]
}

extension IncrementalSort {
  
  ///
  /// This method resets the sort and will also allow you to modify the unordered list.
  ///
  /// - Parameters: values - This list will replace the unordered list if provided.
  ///
  func resetSort(with values: [Int]? = nil) {
    defer { incrementalValues = unsortedValues }
    
    guard let values = values else { return }
    
    unsortedValues = values
    incrementalIndex = 0
  }
  
}
