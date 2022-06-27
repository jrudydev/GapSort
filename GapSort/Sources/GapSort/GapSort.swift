///
/// This class provides a way to calculate the intermitent arrays needed to calculate the exact
/// index position of each value using the Gap Sort.
///
/// Gap Sort Algorithm Example:
///
/// Unsorted array: [3 , 1, 6,  4]
///
/// Gap array: [-2, 5, -2]
///
/// Keep count of gaps to the left and right and increment the shift count when it is negetive.
///
/// Right Shift Array: [1, 0, 1, 0]
///
/// Left Shift Array: [0, 1, 0, 1]
///
/// Index of 3 =  shifts to the right (1) minus shifts to the left (0) = 1
///
final public class IntegerGapSort {
  
  ///
  /// List of unsorted values. Changing this value will reset the increamental sort.
  ///
  var unsortedValues: [Int] {
    didSet {
      resetSort(with: unsortedValues)
    }
  }
  
  ///
  /// Used to hold the incrementally sorted list.
  ///
  var incrementalValues: [Int]
  
  ///
  /// Used to keep track of which values have been sorted.
  ///
  var incrementalIndex: Int = 0
  
  ///
  /// A list of gaps between each unsorted integer in the list. This values is required to be `Int64`
  /// due to the fact that we are allowing negitive integers to to be sorted.
  ///
  lazy var gaps: [Int64] = {
    var gaps: [Int64] = []
    for x in 0..<unsortedValues.count-1 {
      gaps.append(Int64(unsortedValues[x+1]) - Int64(unsortedValues[x]))
    }
    return gaps
  }()
  
  ///
  /// A list of integers where each indexed value represents how many shifts to the right are need to
  /// sort the value in that index.
  ///
  lazy var rightShifts: [Int] = {
    shifts(array: gaps) + [0]
  }()
  
  ///
  /// A list of integers where each indexed value represents how many shifts to the left are need to
  /// sort the value in that index.
  ///
  lazy var leftShifts: [Int] = {
    [0] + shifts(array: gaps.reversed()).reversed()
  }()
  
  public init(values: [Int]) {
    self.unsortedValues = values
    self.incrementalValues = values
  }
  
  ///
  /// This is a method is used to calculate the shifts by counting the gaps and applying a shift when
  /// the gaps indicate two values are in the wrong order.
  ///
  private func shifts(array: [Int64]) -> [Int] {
    var shiftArray: [Int] = []
    
    var count: Int64 = 0
    var shifts: Int = 0
    for x in 0..<array.count {
      defer { count = 0; shifts = 0 }
      
      for y in x..<array.count {
        count += array[y]
        shifts += count.isPositive ? 0 : 1
      }
      
      shiftArray.append(shifts)
    }

    return shiftArray
  }
  
}

// MARK: RelativeIndex Conformance

extension IntegerGapSort: RelativeIndex {
  
  func indexFor(originalIndex index: Int) -> Int {
    index + rightShifts[index] - leftShifts[index]
  }
  
  func valueFor(orderedIndex index: Int) -> Int? {
    guard index < unsortedValues.count else { return nil }
    
    var searchIndex = 0
    var orderedIndex = indexFor(originalIndex: searchIndex)
    while orderedIndex != index {
      searchIndex += 1
      orderedIndex = indexFor(originalIndex: searchIndex)
    }
    
    return orderedIndex == index ? unsortedValues[orderedIndex] : nil
  }

}

// MARK: IncrementalSort Conformance

extension IntegerGapSort: IncrementalSort {

  func incrementalSort() -> [Int] {
    guard incrementalIndex < unsortedValues.count else { return incrementalValues }
    
    let index = indexFor(originalIndex: incrementalIndex)
    incrementalValues[index] = unsortedValues[incrementalIndex]
    incrementalIndex += 1
    
    return incrementalValues
  }

}
