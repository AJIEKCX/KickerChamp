import SwiftUI
import shared

struct StartedGameView: View {

  @ObservedObject
  var wrapper: MainScreenStoreWrapper

  let state: GameState.Started

  var body: some View {
    VStack {
      PlayerScoreView(
        onIncrement: wrapper.store.onIncrementRed,
        onDecrement: {}, // :(
        onSet: { _ in }, // :(
        score: state.redScore
      )
      PlayerScoreView(
        onIncrement: wrapper.store.onIncrementBlue,
        onDecrement: {}, // :(
        onSet: { _ in }, // :(
        score: state.blueScore
      )
    }
  }
}

struct PlayerScoreView: View {

  let onIncrement: () -> Void
  let onDecrement: () -> Void
  let onSet: (Int32) -> Void
  let score: Int32

  @ViewBuilder
  var body: some View {
    VStack {
      VStack {
        HStack {
          Button("-", action: {
            onDecrement()
          })
            .buttonStyle(.bordered)
            .disabled(score < 1)
          Button("+", action: {
            onIncrement()
          })
            .buttonStyle(.bordered)
            .disabled(score > 9)
        }
        HStack {
          ForEach(0..<10) { number in
            Button("\(number)", action: {
              onSet(Int32(number))
            })
              .buttonStyle(.bordered)
              .disabled(number == score)
          }
          .frame(maxWidth: .infinity)
        }
      }
    }
  }
}

struct StartedGameView_Previews: PreviewProvider {
  static var previews: some View {
    StartedGameView(wrapper: .init(), state: .init(blueScore: 6, redScore: 4))
  }
}
