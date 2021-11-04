import SwiftUI
import shared

struct ContentView: View {
  @ObservedObject
  var wrapper: MainScreenStoreWrapper

  var body: some View {
    if let nonStarted = wrapper.state.gameState as? GameState.NonStarted {
      NonStartedGameView(
        wrapper: wrapper,
        isStartButtonEnabled: nonStarted.isStartButtonEnabled
      )
    } else if let started = wrapper.state.gameState as? GameState.Started {
      Text("Started")
    } else if let finished = wrapper.state.gameState as? GameState.Finished {
      Text("Finished")
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView(wrapper: .init())
  }
}
