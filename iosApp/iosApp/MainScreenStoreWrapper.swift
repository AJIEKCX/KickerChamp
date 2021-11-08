import SwiftUI
import shared

let databaseDriverFactory = DatabaseDriverFactory()

final class MainScreenStoreWrapper: ObservableObject {
  let store = MainScreenStore(
    database: Database(
      databaseDriverFactory: databaseDriverFactory
    )
  )

  private var generator = RandomNameGenerator()

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
      print("new main state!\r\(state)")
      self?.state = state
    }
  }

  func randomizeName(for player: Player) {
    store.onPlayerNameChanged(player: player, name: generator.generate())
  }
}

extension MainScreenState {
  var isStartButtonEnabled: Bool {
    if let nonStarted = gameState as? GameState.NonStarted {
      return nonStarted.isStartButtonEnabled
    }
    return false
  }
}
