import SwiftUI
import shared

struct StartedGameView: View {
  @EnvironmentObject
  var wrapper: MainScreenStoreWrapper

  let state: GameState.Started

  var body: some View {
    VStack {
      VStack {
        PlayerScoreView(
          name: "Blue",
          color: .blue,
          onIncrement: wrapper.store.onIncrementBlue,
          onDecrement: wrapper.store.onDecrementBlue,
          onSet: { wrapper.store.onSetScoreBlue(score: $0) },
          score: state.blueScore
        )
      }
      VStack {
        PlayerScoreView(
          name: "Red",
          color: .red,
          onIncrement: wrapper.store.onIncrementRed,
          onDecrement: wrapper.store.onDecrementRed,
          onSet: { wrapper.store.onSetScoreRed(score: $0) },
          score: state.redScore
        )
      }
    }
  }
}

struct PlayerScoreView: View {
  let name: String
  let color: Color
  let onIncrement: () -> Void
  let onDecrement: () -> Void
  let onSet: (Int32) -> Void
  let score: Int32

  private var winScore: Int {
    Int(MainScreenStore.companion.WIN_SCORE)
  }

  var body: some View {
    VStack {
      VStack {
        Text("\(name) Team")
          .font(.title)
          .padding(.horizontal)
          .background(
            color.opacity(0.4),
            in: RoundedRectangle(cornerRadius: 8, style: .continuous)
          )
        Text("\(score)")
          .font(.title.monospacedDigit())
          .accessibilityLabel("\(name) Team Score: \(score)")
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
        .controlSize(.large)
        LazyVGrid(
          columns: Array(
            repeating: GridItem(.adaptive(minimum: 30, maximum: 100)),
            count: 6
          ),
          alignment: .center
        ) {
          ForEach(0..<(winScore+1)) { number in
            Button("\(number)", action: {
              onSet(Int32(number))
            })
              .buttonStyle(.bordered)
              .disabled(number == score)
              .lineLimit(1)
          }
        }
      }
    }
    .foregroundColor(color)
  }
}

struct StartedGameView_Previews: PreviewProvider {
  static var previews: some View {
    StartedGameView(wrapper: .init(), state: .init(blueScore: 6, redScore: 4))
      .environmentObject(MainScreenStoreWrapper())
      .previewDevice("iPod touch (7th generation)")
      .previewInterfaceOrientation(.portrait)
  }
}
