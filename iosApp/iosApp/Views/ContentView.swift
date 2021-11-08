import SwiftUI
import shared

struct ContentView: View {
  @EnvironmentObject
  var wrapper: MainScreenStoreWrapper

  var body: some View {
    NavigationView {
      if wrapper.state.gameState is GameState.NonStarted {
        NonStartedGameView()
          .navigationBarTitle("KickerChamp", displayMode: .inline)
      } else if let started = wrapper.state.gameState as? GameState.Started {
        StartedGameView(state: started)
          .navigationTitle("Game ongoing")
      } else if let finished = wrapper.state.gameState as? GameState.Finished {
        FinishedGameView(state: finished)
          .navigationTitle("Finished game!")
      }
    }
    .navigationViewStyle(.stack)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
      .environmentObject(MainScreenStoreWrapper())
  }
}
