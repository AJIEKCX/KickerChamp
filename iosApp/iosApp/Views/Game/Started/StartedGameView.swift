import SwiftUI
import shared

struct StartedGameView: View {

  @ObservedObject
  var wrapper: MainScreenStoreWrapper

  let state: GameState.Started

  var body: some View {
    VStack {
      VStack {
        PlayerScoreView(
          name: "Blue",
          color: .blue,
          onIncrement: wrapper.store.onIncrementBlue,
          onDecrement: {}, // :(
          onSet: { _ in }, // :(
          score: state.blueScore
        )
      }
      Spacer()
      VStack {
        PlayerScoreView(
          name: "Red",
          color: .red,
          onIncrement: wrapper.store.onIncrementRed,
          onDecrement: {}, // :(
          onSet: { _ in }, // :(
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
    .foregroundColor(color)
  }
}

struct StartedGameView_Previews: PreviewProvider {
  static var previews: some View {
    StartedGameView(wrapper: .init(), state: .init(blueScore: 6, redScore: 4))
      .previewInterfaceOrientation(.landscapeLeft)
  }
}
