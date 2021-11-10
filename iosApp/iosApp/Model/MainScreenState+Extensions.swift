import shared

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
