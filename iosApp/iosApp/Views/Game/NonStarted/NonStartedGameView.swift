import SwiftUI
import shared

struct NonStartedGameView: View {
  @EnvironmentObject
  var wrapper: MainScreenStoreWrapper

  let isStartButtonEnabled: Bool

  var body: some View {
    VStack {
      ScrollView {
        PlayersEditView()
      }
      HStack {
        Button(
          "Start game",
          action: { wrapper.store.onStartGameClicked() }
        )
          .disabled(!isStartButtonEnabled)
          .buttonStyle(.borderedProminent)
          .frame(maxWidth: .infinity)
        NavigationLink(destination: HighScoresView()) {
          Text("High Scores")
        }
        .buttonStyle(.bordered)
        .frame(maxWidth: .infinity)
      }
      .frame(maxWidth: .infinity)
      .padding(.vertical)
      .background(Material.thin)
      .controlSize(.large)
    }
  }
}

struct NonStartedGameView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      NonStartedGameView(isStartButtonEnabled: true)
      NonStartedGameView(isStartButtonEnabled: false)
        .preferredColorScheme(.dark)
        .previewInterfaceOrientation(.landscapeLeft)
    }
    .environmentObject(MainScreenStoreWrapper())
  }
}
