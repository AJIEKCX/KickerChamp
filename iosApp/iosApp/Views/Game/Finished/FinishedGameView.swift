import SwiftUI
import shared

struct FinishedGameView: View {
  @EnvironmentObject
  var wrapper: MainScreenStoreWrapper

  @State var animated = false
  @State var animateGradient = false

  let state: MainGameState.Finished

  var body: some View {
    ZStack {
      LinearGradient(
        colors: [.init(white: 0.5), .init(white: 1)],
        startPoint: animateGradient ? .topLeading : .topTrailing,
        endPoint: animateGradient ? .bottomTrailing : .bottomLeading
      )
        .ignoresSafeArea()
        .onAppear {
          withAnimation(
            .linear(duration: 2.0)
              .repeatForever(autoreverses: true)
          ) {
            animateGradient.toggle()
          }
        }
      VStack {
        Text(state.winnerTeam == .blue ? "Blue wins!" : "Red wins!")
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
  }

  private func color(for team: MainTeam) -> Color {
    switch team {
    case .blue: return Color.blue
    case .red: return Color.red
    }
  }
}

struct FinishedGameView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      FinishedGameView(state: .init(winnerTeam: .red, winner: "Red"))
      FinishedGameView(state: .init(winnerTeam: .blue, winner: "Blue"))
    }
    .environmentObject(MainScreenStoreWrapper())
  }
}
