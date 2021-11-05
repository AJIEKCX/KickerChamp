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
      StartedGameView(wrapper: wrapper, state: started)
    } else if let finished = wrapper.state.gameState as? GameState.Finished {
      FinishedGameView(wrapper: wrapper, state: finished)
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView(wrapper: .init())
  }
}
