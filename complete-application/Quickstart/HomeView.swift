import SwiftUI
import FusionAuth

struct HomeView: View {
    @State var userInfo: UserInfo?

    var body: some View {
        if userInfo == nil {
            VStack {
                ProgressView()
                    .padding()
                Text("Retrieving user info")
            }
            .onAppear {
                getUserInfo()
            }
        } else {
            VStack {
                if userInfo?.given_name == nil || userInfo?.family_name == nil {
                    if userInfo?.email == nil {
                        Text("Welcome \(userInfo?.name ?? "") ").padding(.bottom, 20).font(.headline)
                    } else {
                        Text("Welcome \(userInfo?.email ?? "") ").padding(.bottom, 20).font(.headline)
                    }
                } else {
                    Text("Welcome \(userInfo?.given_name ?? "") \(userInfo?.family_name ?? "")").padding(.bottom, 20).font(.headline)
                }
                Text("Your balance is:")
                Text("$0.00").font(.largeTitle)
                Button("Refresh token") {
                    Task {
                        do {
                            let accessToken = try await AuthorizationManager
                                .oauth()
                                .freshAccessToken()

                            guard let accessToken else {
                                print("Access token is not returned")
                                return
                            }

                            print("Refreshed access token: \(accessToken)")
                        } catch let error as NSError {
                            print(error)
                        }
                    }
                }
                Button("Log out") {
                    Task {
                        do {
                            try await AuthorizationManager
                                .oauth()
                                .logout(options: OAuthLogoutOptions())
                        } catch let error as NSError {
                            print(error)
                        }
                    }
                }.buttonStyle(SecondaryButtonStyle())
            }
        }
    }

    func getUserInfo() {
        Task {
            do {
                self.userInfo = try await AuthorizationManager
                    .oauth()
                    .userInfo()
            } catch let error as NSError {
                print("JSON decode failed: \(error.localizedDescription)")
            }
        }
    }
}
