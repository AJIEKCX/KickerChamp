import SwiftUI
import shared

struct NonStartedGameView: View {
  @EnvironmentObject
  var wrapper: MainScreenStoreWrapper

  @Environment(\.verticalSizeClass)
  var verticalSizeClass

  let isStartButtonEnabled: Bool

  var body: some View {
    VStack {
      ScrollView {
        PlayerEditView()
      }
      if verticalSizeClass == .compact {
        HStack {
          ButtonsGroup(
            onStartGameClicked: wrapper.store.onStartGameClicked,
            isStartButtonEnabled: isStartButtonEnabled,
            onHighScoresClicked: {}
          )
        }
        .padding(.top)
        .background(Material.thin)
      } else {
        VStack {
          ButtonsGroup(
            onStartGameClicked: wrapper.store.onStartGameClicked,
            isStartButtonEnabled: isStartButtonEnabled,
            onHighScoresClicked: {}
          )
        }
        .padding(.top)
        .background(Material.thin)
      }
    }
  }
}

struct ButtonsGroup: View {
  let onStartGameClicked: () -> Void
  let isStartButtonEnabled: Bool
  let onHighScoresClicked: () -> Void
  var body: some View {
    Group {
      Button(
        "Start game",
        action: { onStartGameClicked() }
      )
        .disabled(!isStartButtonEnabled)
        .buttonStyle(.borderedProminent)
      NavigationLink(destination: HighScoresView()) {
        Text("High Scores")
      }
      .buttonStyle(.bordered)
    }
    .frame(maxWidth: .infinity)
  }
}

extension Player {
  func bindName(to store: MainScreenStore) -> Binding<String> {
    Binding(
      get: { self.name },
      set: { [unowned self] in store.onPlayerNameChanged(player: self, name: $0) }
    )
  }
}

struct NonStartedGameView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      NonStartedGameView(wrapper: .init(), isStartButtonEnabled: true)
      NonStartedGameView(wrapper: .init(), isStartButtonEnabled: true)
        .preferredColorScheme(.dark)
        .previewInterfaceOrientation(.landscapeLeft)
    }
    .environmentObject(MainScreenStoreWrapper())
  }
}
