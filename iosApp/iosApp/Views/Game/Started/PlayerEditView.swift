import SwiftUI

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
          name: wrapper.state.blueForward.bindName(to: wrapper.store)
        )
        PlayerView(
          player: wrapper.state.blueDefender,
          randomize: { wrapper.randomizeName(for: wrapper.state.blueDefender) },
          name: wrapper.state.blueDefender.bindName(to: wrapper.store)
        )
      }.padding()
      VStack {
        Text("Red Team")
          .font(.title)
          .padding(.bottom)
        PlayerView(
          player: wrapper.state.redForward,
          randomize: { wrapper.randomizeName(for: wrapper.state.redForward) },
          name: wrapper.state.redForward.bindName(to: wrapper.store)
        )
        PlayerView(
          player: wrapper.state.redDefender,
          randomize: { wrapper.randomizeName(for: wrapper.state.redDefender) },
          name: wrapper.state.redDefender.bindName(to: wrapper.store)
        )
      }
      .padding()
    }
  }
}

struct PlayerEditView_Previews: PreviewProvider {
  static var previews: some View {
    PlayerEditView()
      .environmentObject(MainScreenStoreWrapper())
      .previewLayout(.sizeThatFits)
  }
}
