import Foundation

final class RandomNameGenerator {
  private var dictionary: [UInt32: String] = [
    0: "Alfa",
    1: "Bravo",
    2: "Charlie",
    3: "Delta",
    4: "Echo",
    5: "Foxtrot",
    6: "Golf",
    7: "Hotel",
    8: "India",
    9: "Juliett",
    10: "Kilo",
    11: "Lima",
    12: "Mike",
    13: "November",
    14: "Oscar",
    15: "Papa",
    16: "Quebec",
    17: "Romeo",
    18: "Sierra",
    19: "Tango",
    20: "Uniform",
    21: "Victor",
    22: "Whiskey",
    23: "X-Ray",
    24: "Yankee",
    25: "Zulu",
  ]

  func generate() -> String {
    let id = (UInt32(0)..<26).randomElement()!
    return dictionary[id]!
  }
}
