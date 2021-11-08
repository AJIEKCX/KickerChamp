import SwiftUI
import shared

struct PlayerEditView: View {
  @EnvironmentObject
  var wrapper: MainScreenStoreWrapper

  var body: some View {
    Group {
      VStack {
        Text("Blue Team")
          .font(.title)
          .padding(.bottom)
        PlayerView(
          player: wrapper.state.blueForward,
          randomize: { wrapper.randomizeName(for: wrapper.state.blueForward) },
          name: binding(player: wrapper.state.blueForward)
        )
        PlayerView(
          player: wrapper.state.blueDefender,
          randomize: { wrapper.randomizeName(for: wrapper.state.blueDefender) },
          name: binding(player: wrapper.state.blueDefender)
        )
      }.padding()
      VStack {
        Text("Red Team")
          .font(.title)
          .padding(.bottom)
        PlayerView(
          player: wrapper.state.redForward,
          randomize: { wrapper.randomizeName(for: wrapper.state.redForward) },
          name: binding(player: wrapper.state.redForward)
        )
        PlayerView(
          player: wrapper.state.redDefender,
          randomize: { wrapper.randomizeName(for: wrapper.state.redDefender) },
          name: binding(player: wrapper.state.redDefender)
        )
      }
      .padding()
    }
  }

  private func binding(player: Player) -> Binding<String> {
    .init(get: {
      player.name
    }, set: { name in
      wrapper.store.onPlayerNameChanged(player: player, name: name)
    })
  }
}


struct PlayerEditView_Previews: PreviewProvider {
  static var previews: some View {
    PlayerEditView()
      .environmentObject(MainScreenStoreWrapper())
      .previewLayout(.sizeThatFits)
  }
}

