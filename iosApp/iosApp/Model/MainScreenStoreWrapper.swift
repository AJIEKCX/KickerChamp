import SwiftUI
import shared

final class MainScreenStoreWrapper: ObservableObject {
  let store = MainScreenStore(database: database)

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

  @Published
  private(set) var gameState: MainGameState = .nonStarted(isStartButtonEnabled: false)

  private var generator = RandomNameGenerator()

  init() {
    subscribe()
  }

  deinit {
    stateWatcher?.close()
  }

  private func subscribe() {
    stateWatcher = store.watchState().watch { [weak self] state in
      guard let self = self else { return }
      print("Main\r\t\(state)")
      self.state = state
      self.gameState = .init(state.gameState)
    }
  }

  func randomizeName(for player: Player) {
    let generatedName = generator.generate()
    print("Generated name\r\t\(generatedName)")
    store.onPlayerNameChanged(player: player, name: generatedName)
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

enum MainTeam {
  case blue
  case red

  static func create(_ team: Team) -> MainTeam {
    switch team {
    case is BlueTeam: return .blue
    case is RedTeam: return .red
    default: fatalError("wrong team")
    }
  }
}

enum MainGameState: Hashable {
  case nonStarted(isStartButtonEnabled: Bool)
  struct Started: Hashable {
    let blueScore: Int32
    let redScore: Int32
  }
  case started(Started)
  struct Finished: Hashable {
    let winnerTeam: MainTeam
    let winner: String
  }
  case finished(Finished)

  init(_ gameState: GameState) {
    if let nonStarted = gameState as? GameState.NonStarted {
      self = .nonStarted(isStartButtonEnabled: nonStarted.isStartButtonEnabled)
      return
    }
    if let started = gameState as? GameState.Started {
      self = .started(.init(
        blueScore: started.blueScore,
        redScore: started.redScore
      ))
      return
    }
    if let finished = gameState as? GameState.Finished {
      self = .finished(.init(
        winnerTeam: MainTeam.create(finished.winnerTeam),
        winner: finished.winner
      ))
      return
    }
    self = .nonStarted(isStartButtonEnabled: false)
  }
}
