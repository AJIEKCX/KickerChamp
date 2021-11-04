import SwiftUI

struct PlayerEditView: View {
  @ObservedObject
  var wrapper: MainScreenStoreWrapper

  var body: some View {
    Group {
      VStack {
        Text("Blue Team")
          .font(.title)
          .padding(.bottom)
        PlayerView(
          player: wrapper.state.blueForward,
          name: wrapper.state.blueForward.bindName(to: wrapper.store)
        )
        PlayerView(
          player: wrapper.state.blueDefender,
          name: wrapper.state.blueDefender.bindName(to: wrapper.store)
        )
      }.padding()
      VStack {
        Text("Red Team")
          .font(.title)
          .padding(.bottom)
        PlayerView(
          player: wrapper.state.redForward,
          name: wrapper.state.redForward.bindName(to: wrapper.store)
        )
        PlayerView(
          player: wrapper.state.redDefender,
          name: wrapper.state.redDefender.bindName(to: wrapper.store)
        )
      }
      .padding()
    }
  }
}

struct PlayerEditView_Previews: PreviewProvider {
  static var previews: some View {
    PlayerEditView(wrapper: .init())
      .previewLayout(.sizeThatFits)
  }
}
