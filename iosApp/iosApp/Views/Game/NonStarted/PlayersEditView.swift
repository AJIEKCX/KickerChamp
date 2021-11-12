import SwiftUI
import shared

struct PlayersEditView: View {
  var body: some View {
    Group {
      Text("Edit everyone")
      PlayerEditView()
      PlayerEditView()
      PlayerEditView()
      PlayerEditView()
    }
  }
}

struct PlayersEditView_Previews: PreviewProvider {
  static var previews: some View {
    PlayersEditView()
      .previewLayout(.sizeThatFits)
  }
}

