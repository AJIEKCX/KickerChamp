import SwiftUI
import shared

struct StartedGameView: View {
  @EnvironmentObject
  var wrapper: MainScreenStoreWrapper

  var state: MainGameState.Started // blueScore: Int; redScore: Int

  var body: some View {
    VStack {
      Text("Game just started. We should manage score!")
    }
  }
}

struct StartedGameView_Previews: PreviewProvider {
  static var previews: some View {
    StartedGameView(state: .init(blueScore: 0, redScore: 10))
    .environmentObject(MainScreenStoreWrapper())
  }
}

private func winScore() -> Int {
  Int(MainScreenStore.companion.WIN_SCORE)
}
