import SwiftUI
import FusionAuth

struct LoginView: View {
    @State private var errorWhileLogin = false
    @State private var error: String?

    var body: some View {
        VStack {
            Image("changebank")
                .resizable()
                .scaledToFit()

            Text("Welcome to ChangeBank!")

            Button("Login") {
                Task {
                    do {
                        try await AuthorizationManager
                            .oauth()
                            .authorize(options: OAuthAuthorizeOptions())
                    } catch let error as NSError {
                        self.errorWhileLogin = true
                        self.error = error.localizedDescription
                    }
                }
            }.buttonStyle(PrimaryButtonStyle())
        }
        .padding()
        .alert(
            "Error occured while logging in",
            isPresented: $errorWhileLogin,
            presenting: error
        ) { _ in
            Button("OK", role: .cancel) { errorWhileLogin = false }
        } message: { error in
            Text(error)
        }
    }
}
