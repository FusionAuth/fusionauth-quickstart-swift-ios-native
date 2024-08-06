//
//  LoggedInView.swift
//  TestApp
//
//  Created by Colin Frick on 15.05.24.
//

import SwiftUI

struct LoggedInView: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image("changebank")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150)
                    .padding()
                Spacer()
            }
            .frame(maxWidth: .infinity, alignment: .topLeading)

            TabView {
                HomeView().tabItem {
                    Label("Home", systemImage: "house")
                }
                MakeChangeView().tabItem {
                    Label("Make Change", systemImage: "centsign.circle")
                }
            }.accentColor(Color(red: 0.0353, green: 0.3882, blue: 0.1412))
        }
    }
}

#Preview {
    LoggedInView()
}
