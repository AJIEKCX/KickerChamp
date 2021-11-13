import SwiftUI
import shared

struct StartedGameView: View {
  @EnvironmentObject
  var wrapper: MainScreenStoreWrapper

  var state: MainGameState.Started

  var body: some View {
    Text("Game just started.")
  }
}

struct StartedGameView_Previews: PreviewProvider {
  static var previews: some View {
    StartedGameView(state: .init(blueScore: 0, redScore: 10))
      .previewLayout(.sizeThatFits)
    .environmentObject(MainScreenStoreWrapper())
  }
}

private func winScore() -> Int {
  Int(MainScreenStore.companion.WIN_SCORE)
}
