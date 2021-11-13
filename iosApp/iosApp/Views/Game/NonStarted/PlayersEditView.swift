import SwiftUI
import shared

struct PlayersEditView: View {
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
          randomize: randomize(wrapper.state.blueDefender),
          name: binding(player: wrapper.state.blueDefender)
        )
        PlayerEditView(
          player: wrapper.state.blueForward,
          randomize: randomize(wrapper.state.blueForward),
          name: binding(player: wrapper.state.blueForward)
        )
      }.padding()
      VStack {
        Text("Red Team")
          .font(.title)
          .padding(.bottom)
        PlayerEditView(
          player: wrapper.state.redDefender,
          randomize: randomize(wrapper.state.redDefender),
          name: binding(player: wrapper.state.redDefender)
        )
        PlayerEditView(
          player: wrapper.state.redForward,
          randomize: randomize(wrapper.state.redForward),
          name: binding(player: wrapper.state.redForward)
        )
      }
      .padding()
    }
  }

  private func randomize(_ player: Player) -> (() -> Void) {
    {
    wrapper.store.onPlayerNameChanged(
      player: player,
      name: RandomNameGenerator.shared.generate()
    )
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


struct PlayersEditView_Previews: PreviewProvider {
  static var previews: some View {
    PlayersEditView()
      .environmentObject(MainScreenStoreWrapper())
      .previewLayout(.sizeThatFits)
  }
}

