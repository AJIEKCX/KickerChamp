import SwiftUI
import shared

struct ContentView: View {

  let gameState: MainGameState

  var body: some View {
    NavigationView {
      switch gameState {
      case let .nonStarted(isStartButtonEnabled):
        NonStartedGameView(isStartButtonEnabled: isStartButtonEnabled)
          .navigationBarTitle("KickerChamp", displayMode: .inline)
      case .started:
        StartedGameView()
          .navigationBarTitle("Game ongoing", displayMode: .inline)
      case let .finished(finished):
        FinishedGameView(state: finished)
          .navigationBarTitle("Finished game", displayMode: .inline)
      }
    }
    .navigationViewStyle(.stack)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView(gameState: .finished(.init(winnerTeam: .blue)))
  }
}
