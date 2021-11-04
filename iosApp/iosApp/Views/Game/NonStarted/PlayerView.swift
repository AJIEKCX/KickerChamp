import SwiftUI
import shared

struct PlayerView: View {
  let player: Player
  let randomize: () -> Void
  @Binding var name: String

  var body: some View {
    VStack(alignment: .leading) {
      HStack {
        Text(title(for: player))
          .foregroundColor(color(for: player))
        Spacer()
        Button(
          "🎲",
          action: randomize
        )
          .buttonStyle(.bordered)
          .controlSize(.mini)
      }
      TextField("Name", text: $name, prompt: Text("Name"))
        .textFieldStyle(.roundedBorder)
    }
  }

  private func title(for: Player) -> String {
    switch player {
    case is BlueForward:
      return "⚔️🔵 Blue Forward"
    case is BlueDefender:
      return "🥅🔵 Blue Defender"
    case is RedForward:
      return "⚔️🔴 Red Forward"
    case is RedDefender:
      return "🥅🔴 Red Defender"
    default:
      return "Unknown"
    }
  }

  private func color(for: Player) -> Color {
    switch player {
    case is BlueTeam:
      return .blue
    case is RedTeam:
      return .red
    default:
      return .primary
    }
  }
}

struct PlayerView_Previews: PreviewProvider {
  @State static var name: String = ""
  static var previews: some View {
    Group {
      PlayerView(
        player: BlueForward(name: "Johnny"),
        randomize: {},
        name: $name
      )
      PlayerView(
        player: RedDefender(name: "Jacky"),
        randomize: {},
        name: $name
      )
    }
    .previewLayout(.sizeThatFits)
  }
}
