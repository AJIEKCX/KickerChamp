import SwiftUI
import shared

struct StartedGameViewRef: View {
  @EnvironmentObject
  var wrapper: MainScreenStoreWrapper

  var state: MainGameState.Started

  var body: some View {
    VStack {
      Spacer()
      VStack {
        TeamScoreboardViewRef(
          name: "Blue",
          color: .blue,
          onIncrement: wrapper.store.onIncrementBlue,
          onDecrement: wrapper.store.onDecrementBlue,
          onSet: {
            wrapper.store.onSetScoreBlue(score: Int32($0))
          },
          score: state.blueScore
        )
      }
      Spacer(minLength: 16)
      VStack {
        TeamScoreboardViewRef(
          name: "Red",
          color: .red,
          onIncrement: wrapper.store.onIncrementRed,
          onDecrement: wrapper.store.onDecrementRed,
          onSet: {
            wrapper.store.onSetScoreRed(score: Int32($0))
          },
          score: state.redScore
        )
      }
      Spacer()
    }
  }
}

struct TeamScoreboardViewRef: View {
  let name: String
  let color: Color
  let onIncrement: () -> Void
  let onDecrement: () -> Void
  let onSet: (Int) -> Void
  let score: Int

  var body: some View {
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
      HStack {
        Button(action: {
          onDecrement()
        }) {
          Text("—")
            .frame(maxWidth: .infinity)
        }
        .disabled(score < 1)
        Button(action: {
          onIncrement()
        }) {
          Text("+")
            .frame(maxWidth: .infinity)
        }
        .disabled(score > 9)
      }
      .padding(.horizontal)
      .buttonBorderShape(.roundedRectangle)
      .buttonStyle(.bordered)
      .controlSize(.large)
      HStack {
        ForEach(0..<(winScore()+1), id: \.self) { number in
          RoundedRectangle(cornerRadius: 4)
            .frame(width: number == score ? 16 : 8, height: 8)
            .id(number)
        }
        .animation(.default, value: score)
      }
      .padding()
    }
    .foregroundColor(color)
  }
}

struct StartedGameViewRef_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      StartedGameView(state: .init(blueScore: 0, redScore: 4))
        .previewDevice("iPod touch (7th generation)")
      StartedGameView(state: .init(blueScore: 6, redScore: 4))
    }
    .environmentObject(MainScreenStoreWrapper())
  }
}

private func winScore() -> Int {
  Int(MainScreenStore.companion.WIN_SCORE)
}
