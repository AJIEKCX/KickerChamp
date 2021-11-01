import SwiftUI
import shared

struct PlayerView: View {
  enum TextPosition {
    case up
    case down
  }

  let textPosition: TextPosition
  let player: Player
  @Binding var name: String

  var body: some View {
    VStack {
      if textPosition == .up {
        Text(position(for: player))
          .foregroundColor(color(for: player))
      }
      TextField("Name", text: $name, prompt: Text("Name"))
      if textPosition == .down {
        Text(position(for: player))
          .foregroundColor(color(for: player))
      }
    }
  }

  private func position(for: Player) -> String {
    switch player {
    case is BlueForward:
      return "Blue Forward ⚔️"
    case is BlueDefender:
      return "Blue Defender 🏰"
    case is RedForward:
      return "Red Forward ⚔️"
    case is RedDefender:
      return "Red Defender 🏰"
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
  @State static var name: String = "jey"
  static var previews: some View {
    Group {
      PlayerView(
        textPosition: .up,
        player: BlueForward(name: "Johnny"),
        name: $name
      )
    }
    .previewLayout(.sizeThatFits)
  }
}
