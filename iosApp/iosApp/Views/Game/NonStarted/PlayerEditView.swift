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
        PlayerEditView(
          player: wrapper.state.blueDefender,
          randomize: { wrapper.randomizeName(for: wrapper.state.blueDefender) },
          name: binding(player: wrapper.state.blueDefender)
        )
        PlayerEditView(
          player: wrapper.state.blueForward,
          randomize: { wrapper.randomizeName(for: wrapper.state.blueForward) },
          name: binding(player: wrapper.state.blueForward)
        )
      }.padding()
      VStack {
        Text("Red Team")
          .font(.title)
          .padding(.bottom)
        PlayerEditView(
          player: wrapper.state.redDefender,
          randomize: { wrapper.randomizeName(for: wrapper.state.redDefender) },
          name: binding(player: wrapper.state.redDefender)
        )
        PlayerEditView(
          player: wrapper.state.redForward,
          randomize: { wrapper.randomizeName(for: wrapper.state.redForward) },
          name: binding(player: wrapper.state.redForward)
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

