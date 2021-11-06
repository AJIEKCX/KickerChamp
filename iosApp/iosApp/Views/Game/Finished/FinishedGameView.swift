import SwiftUI
import shared

struct FinishedGameView: View {
  @EnvironmentObject
  var wrapper: MainScreenStoreWrapper

  @State var animated = false

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
    }.offset(y: animated ? 0 : 300)
      .onAppear {
        withAnimation(.easeOut(duration: 0.35)) {
          animated = true
        }
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
    .environmentObject(MainScreenStoreWrapper())
  }
}
