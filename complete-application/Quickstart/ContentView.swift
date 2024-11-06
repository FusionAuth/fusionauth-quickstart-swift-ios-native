import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var authState: FusionAuthStateObject

    var body: some View {
        VStack {
            if authState.isLoggedIn() {
                LoggedInView()
            } else {
                LoginView()
            }
        }
        .padding()
    }
}

#if swift(>=5.9)
#Preview {
    ContentView()
}
#else
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
