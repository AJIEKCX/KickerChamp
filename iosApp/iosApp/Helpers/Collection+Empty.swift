import Foundation

extension Collection {
  var nonEmpty: Self? {
    isEmpty ? nil : self
  }
}
