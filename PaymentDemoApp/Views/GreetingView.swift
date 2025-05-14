//
//  GreetingView.swift
//  PaymentDemoApp
//
//  Created by Sanjar Yalgashev on 08/05/25.
//

import SwiftUI

struct GreetingView: View {
    @State private var showText = false
    @State private var goToAuth = false

    var body: some View {
        ZStack {
            Color.greetingBackground.ignoresSafeArea()

            VStack(spacing: 20) {
                Image(systemName: "bolt.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.yellow)
                    .scaleEffect(showText ? 1.0 : 0.5)
                    .opacity(showText ? 1 : 0)

                Text("Welcome to App")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(Color.greetingTitle)
                    .opacity(showText ? 1 : 0)
            }
            .onAppear {
                withAnimation(.easeInOut(duration: 1.2)) {
                    showText = true
                }

                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    goToAuth = true
                }
            }

            NavigationLink(
                destination: AuthView(),
                isActive: $goToAuth
            ) {
                EmptyView()
            }
        }
    }
}
