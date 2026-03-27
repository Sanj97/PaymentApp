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
    @State private var isPasswordVisible = false
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
                        
                        HStack(spacing: 8) {
                            ZStack {
                                SecureField("Password", text: $password)
                                    .opacity(isPasswordVisible ? 0 : 1)
                                    .allowsHitTesting(!isPasswordVisible)

                                TextField("Password", text: $password)
                                    .opacity(isPasswordVisible ? 1 : 0)
                                    .allowsHitTesting(isPasswordVisible)
                                    .autocapitalization(.none)
                            }

                            Button(action: {
                                isPasswordVisible.toggle()
                            }) {
                                Image(systemName: isPasswordVisible ? "eye.slash.fill" : "eye.fill")
                                    .foregroundColor(.white)
                            }
                            .buttonStyle(.plain)
                            .accessibilityIdentifier("toggle_password_visibility")
                        }
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
