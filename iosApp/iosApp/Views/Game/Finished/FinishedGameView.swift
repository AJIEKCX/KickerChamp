import SwiftUI
import shared

struct FinishedGameView: View {

  @ObservedObject
  var wrapper: MainScreenStoreWrapper

  let state: GameState.Finished

  var body: some View {
    VStack {
      Text(state.winner)
        .foregroundColor(color(for: state.winnerTeam))
      Button("Start new game", action: { wrapper.store.onRestartGameClicked() })
        .buttonStyle(.borderedProminent)
      Button("Revenge", action: { wrapper.store.onRevengeClicked() })
        .buttonStyle(.bordered)
        .tint(color(for: state.winnerTeam))
      NavigationLink(destination: HighScoresView()) {
        Text("High scores")
      }
      .buttonStyle(.bordered)
    }
  }

  private func color(for team: Team) -> Color {
    team is BlueTeam ? Color.blue : Color.red
  }
}

struct FinishedGameView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      FinishedGameView(wrapper: .init(), state: .init(winnerTeam: RedTeamCompanion(), winner: "Red"))
      FinishedGameView(wrapper: .init(), state: .init(winnerTeam: BlueTeamCompanion(), winner: "Blue"))
    }
  }
}
