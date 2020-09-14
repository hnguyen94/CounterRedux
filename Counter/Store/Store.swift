import Combine



/// Store maintaining the state
class Store: ObservableObject {
  @Published var appState: AppState
  
  init(appState: AppState) {
    self.appState = appState
  }
  
  func dispatch(_ action: AppAction) {
    appState = AppReducer.makeAppState(state: appState, action: action)
  }
}
