import SwiftUI

@main
struct iOSApp: App {
  @StateObject var mainScreenStoreWrapper = MainScreenStoreWrapper()
  @StateObject var highScoreStoreWrapper = HighScoreStoreWrapper()

	var body: some Scene {
		WindowGroup {
      ContentView(gameState: mainScreenStoreWrapper.gameState)
        .environmentObject(mainScreenStoreWrapper)
        .environmentObject(highScoreStoreWrapper)
		}
	}
}
