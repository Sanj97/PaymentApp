//
//  AuthView.swift
//  PaymentDemoApp
//
//  Created by Sanjar Yalgashev on 08/05/25.
//

import SwiftUI

struct AuthView: View {
    @State private var username = ""
    @State private var password = ""
    @State private var isLoading = false
    @State private var error: String?
    @State private var isAuthenticated = false
    
    var body: some View {
        ZStack {
            Color(.authBackground).ignoresSafeArea()
            
            VStack {
                Spacer()
                
                VStack(spacing: 24) {
                    Text("Welcome Back")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.white)
                    
                    VStack(spacing: 16) {
                        TextField("Username", text: $username)
                            .padding()
                            .background(Color.white.opacity(0.6))
                            .cornerRadius(12)
                            .foregroundColor(.white)
                            .autocapitalization(.none)
                            .accessibilityIdentifier("username_field")
                        
                        SecureField("Password", text: $password)
                            .padding()
                            .background(Color.white.opacity(0.6))
                            .cornerRadius(12)
                            .foregroundColor(.white)
                            .accessibilityIdentifier("password_field")
                    }
                    
                    if let error = error {
                        Text(error)
                            .foregroundColor(.red)
                    }
                    
                    if isLoading {
                        ProgressView()
                    } else {
                        Button(action: {
                            Task {
                                await login()
                            }
                        }) {
                            Text("Log In")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(.white)
                                .foregroundColor(.authBackground)
                                .cornerRadius(12)
                                .accessibilityIdentifier("login_button")
                        }
                    }
                }
                .padding(.horizontal, 32)
                
                Spacer()
            }
            
            NavigationLink("", destination: PinCodeView(), isActive: $isAuthenticated)
                .hidden()
        }
    }
    
    private func login() async {
        error = nil
        isLoading = true
        do {
            let success = try await AuthService.login(username: username, password: password)
            if success {
                isAuthenticated = true
            }
        } catch {
            self.error = error.localizedDescription
        }
        isLoading = false
    }
}
