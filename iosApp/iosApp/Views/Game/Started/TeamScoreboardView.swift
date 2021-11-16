import SwiftUI
import shared

struct TeamScoreboardView: View {
  let onIncrement: () -> Void
  let score: Int

  var body: some View {
    VStack {
      Text("One team scoreboard")
    }
  }
}

struct TeamScoreboardView_Previews: PreviewProvider {
  static var previews: some View {
    TeamScoreboardView(
      onIncrement: {},
      score: 0
    )
  }
}

private func winScore() -> Int {
  Int(MainScreenStore.companion.WIN_SCORE)
}
