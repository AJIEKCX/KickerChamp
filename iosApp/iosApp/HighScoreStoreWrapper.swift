import SwiftUI
import shared

class HighScoreStoreWrapper: ObservableObject {
  let store = HighScoreStore(
    database: Database(
      databaseDriverFactory: DatabaseDriverFactory()
    )
  )

  private var generator = RandomNameGenerator()

  private var stateWatcher: Closeable?

  @Published
  private(set) var state: HighScoreState = .init(
    playerScores: []
  )

  init() {
    subscribe()
  }

  deinit {
    stateWatcher?.close()
  }

  private func subscribe() {
    stateWatcher = store.watchState().watch { [weak self] state in
      self?.state = state
    }
  }
}

extension OrderedPlayerScores: Identifiable {
  public var id: Int {
    var hasher = Hasher()
    hasher.combine(name)
    hasher.combine(wins)
    hasher.combine(goalsDiff)
    return hasher.finalize()
  }
}
