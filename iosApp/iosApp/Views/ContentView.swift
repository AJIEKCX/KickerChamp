import SwiftUI
import shared

struct ContentView: View {
  @ObservedObject
  var wrapper: MainScreenStoreWrapper

	var body: some View {
    VStack {
      HStack {
        PlayerView(
          textPosition: .up,
          player: wrapper.state.blueForward,
          name: wrapper.state.blueForward.binding(store: wrapper.store)
        )
        Spacer()
        PlayerView(
          textPosition: .up,
          player: wrapper.state.redForward,
          name: wrapper.state.redForward.binding(store: wrapper.store)
        )
      }
      Spacer()
      VStack {
        Button("Start game",
          action: { wrapper.store.onStartGameClicked() }
        )
          .disabled(!wrapper.state.isStartButtonEnabled)
      }
      Spacer()
      HStack {
        PlayerView(
          textPosition: .down,
          player: wrapper.state.blueDefender,
          name: wrapper.state.blueDefender.binding(store: wrapper.store)
        )
        Spacer()
        PlayerView(
          textPosition: .down,
          player: wrapper.state.redDefender,
          name: wrapper.state.redDefender.binding(store: wrapper.store)
        )
      }
    }.padding()
	}
}

extension Player {
  func binding(store: MainScreenStore) -> Binding<String> {
    Binding(
      get: { self.name },
      set: { [unowned self] in store.onPlayerNameChanged(player: self, name: $0) }
    )
  }
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
    ContentView(wrapper: .init())
	}
}
