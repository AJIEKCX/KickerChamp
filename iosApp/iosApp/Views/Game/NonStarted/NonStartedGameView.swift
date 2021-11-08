import SwiftUI
import shared

struct NonStartedGameView: View {
  @EnvironmentObject
  var wrapper: MainScreenStoreWrapper

  @Environment(\.verticalSizeClass)
  var verticalSizeClass

  var body: some View {
    VStack {
      ScrollView {
        PlayerEditView()
      }
      HStack {
        Button(
          "Start game",
          action: { wrapper.store.onStartGameClicked() }
        )
          .disabled(!wrapper.state.isStartButtonEnabled)
          .buttonStyle(.borderedProminent)
          .frame(maxWidth: .infinity)
        NavigationLink(destination: HighScoresView()) {
          Text("High Scores")
        }
        .buttonStyle(.bordered)
        .frame(maxWidth: .infinity)
      }
      .frame(maxWidth: .infinity)
      .padding(.top)
      .background(Material.thin)
      .controlSize(.large)
    }
  }
}

struct NonStartedGameView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      NonStartedGameView()
      NonStartedGameView()
        .preferredColorScheme(.dark)
        .previewInterfaceOrientation(.landscapeLeft)
    }
    .environmentObject(MainScreenStoreWrapper())
  }
}
