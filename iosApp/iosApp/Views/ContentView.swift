import SwiftUI
import shared

struct ContentView: View {

  @EnvironmentObject
  var wrapper: MainScreenStoreWrapper

  var body: some View {
    NavigationView {
      switch wrapper.gameState {
      case .nonStarted:
        NonStartedGameView()
          .navigationBarTitle("KickerChamp", displayMode: .inline)
      case let .started(started):
        StartedGameView(state: started)
          .navigationBarTitle("Game ongoing", displayMode: .inline)
      case let .finished(finished):
        FinishedGameView(state: finished)
          .navigationBarTitle("Finished game", displayMode: .inline)
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
