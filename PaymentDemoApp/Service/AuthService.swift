//
//  AuthService.swift
//  PaymentDemoApp
//
//  Created by Sanjar Yalgashev on 08/05/25.
//

import Foundation

class AuthService {
    static func login(username: String, password: String) async throws -> Bool {
        try await Task.sleep(nanoseconds: 2 * 1_000_000_000) // 2 seconds
        if username.lowercased() == "admin" && password == "1234" {
            return true
        } else {
            throw AuthError.invalidCredentials
        }
    }

    enum AuthError: Error, LocalizedError {
        case invalidCredentials

        var errorDescription: String? {
            switch self {
            case .invalidCredentials:
                return "Invalid username or password."
            }
        }
    }
}
