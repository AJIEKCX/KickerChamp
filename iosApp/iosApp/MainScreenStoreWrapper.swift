import SwiftUI
import shared

class MainScreenStoreWrapper: ObservableObject {
  let store = MainScreenStore(
    database: Database(
      databaseDriverFactory: DatabaseDriverFactory()
    )
  )

  private var stateWatcher: Closeable?

  @Published
  private(set) var state: MainScreenState = .init(
    blueDefender: .init(name: ""),
    blueForward: .init(name: ""),
    redDefender: .init(name: ""),
    redForward: .init(name: ""),
    gameState: GameState.NonStarted(isStartButtonEnabled: false),
    dialogSate: nil
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

extension MainScreenState {
  var isStartButtonEnabled: Bool {
    guard let isStartButtonEnabled = (gameState as? GameState.NonStarted)?.isStartButtonEnabled else {
      return false
    }
    return isStartButtonEnabled
  }
}

extension Collection {
  var nonEmpty: Self? {
    isEmpty ? nil : self
  }
}
