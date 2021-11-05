import SwiftUI
import shared

struct ContentView: View {
  @ObservedObject
  var wrapper: MainScreenStoreWrapper

  var body: some View {
    NavigationView {
      if let nonStarted = wrapper.state.gameState as? GameState.NonStarted {
        NonStartedGameView(
          wrapper: wrapper,
          isStartButtonEnabled: nonStarted.isStartButtonEnabled
//            NavigationLink("High scores", destination: HighScoresView())
        )
          .navigationBarTitle("KickerChamp", displayMode: .inline)
      } else if let started = wrapper.state.gameState as? GameState.Started {
        StartedGameView(wrapper: wrapper, state: started)
          .navigationTitle("Game ongoing")
      } else if let finished = wrapper.state.gameState as? GameState.Finished {
        FinishedGameView(wrapper: wrapper, state: finished)
          .navigationTitle("Finished game!")
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView(wrapper: .init())
  }
}
