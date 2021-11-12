import SwiftUI
import shared

private func winScore() -> Int {
  Int(MainScreenStore.companion.WIN_SCORE)
}

struct StartedGameView: View {
  @State var blueScore: Int = 0
  @State var redScore: Int = 0

  var body: some View {
    Text("Started game. Show scores and change.")
  }
}
struct StartedGameView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      StartedGameView(blueScore: 0, redScore: 4)
        .previewLayout(.sizeThatFits)
      StartedGameView(blueScore: 6, redScore: 4)
        .previewDevice("iPod touch (7th generation)")
        .previewInterfaceOrientation(.landscapeLeft)
    }
  }
}
