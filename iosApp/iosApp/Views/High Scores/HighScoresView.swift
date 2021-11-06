import SwiftUI

struct HighScoresView: View {
  @EnvironmentObject
  var wrapper: HighScoreStoreWrapper

  var body: some View {
    HighScoresList2(scores: wrapper.state.playerScores)
  }
}

import shared

struct HighScoresList: View {
  let scores: [OrderedPlayerScores]

  var body: some View {
    List(scores) { score in
        HStack {
          Text("\(score.position)")
          Text(score.name)
          Text("\(score.wins)")
          Text("\(score.goalsDiff)")
        }
    }
    .padding()
  }
}

struct HighScoresList2: View {
  let scores: [OrderedPlayerScores]

  var body: some View {
    ScrollView {
      LazyVGrid(
        columns: [
          .init(.flexible(minimum:10, maximum: 40), alignment: .leading),
          .init(.flexible(minimum: 10, maximum: .infinity), alignment: .leading),
          .init(.flexible(minimum:20, maximum: 100), alignment: .trailing),
          .init(.flexible(minimum:20, maximum: 100), alignment: .trailing)
        ],
        spacing: 16
      ) {
        Text("#")
        Text("Игрок")
        Text("Побед")
        Text("Разница")
        ForEach(scores) { score in
          Group {
            Text("\(score.position)")
              .font(.body.monospacedDigit())
            Text(score.name)
              .font(.headline)
            Text("\(score.wins)")
              .font(.body.monospacedDigit())
            Text("\(score.goalsDiff > 0 ? "+" : "")\(score.goalsDiff)")
              .font(.body.monospacedDigit())
          }
        }
      }
      .padding()
    }
  }

}

struct HighScoresView_Previews: PreviewProvider {
  static let scores: [OrderedPlayerScores] = [
    .init(
      position: 1,
      name: "Wow",
      wins: 5,
      goalsDiff: 9
    ),
    .init(
      position: 2,
      name: "Wow",
      wins: 4,
      goalsDiff: 9
    ),
    .init(
      position: 3,
      name: "Long name",
      wins: 1,
      goalsDiff: -18
    )
  ]
  static var previews: some View {
    Group {
      HighScoresList(scores: scores)
      HighScoresList2(scores: scores)
    }.previewLayout(.sizeThatFits)
  }
}
