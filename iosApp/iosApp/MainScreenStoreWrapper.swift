import SwiftUI
import shared

class MainScreenStoreWrapper: ObservableObject {
  let store = MainScreenStore(
    database: Database(
      databaseDriverFactory: DatabaseDriverFactory()
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
      self?.state = state
    }
  }

  func randomizeName(for player: Player) {
    store.onPlayerNameChanged(player: player, name: generator.generate())
  }
}
