//
//  AuthServiceTests.swift
//  PaymentDemoAppTests
//
//  Created by Sanjar Yalgashev on 08/05/25.
//

import XCTest
@testable import PaymentDemoApp

final class AuthServiceTests: XCTestCase {

    func testLoginSuccess() async throws {
        let result = try await AuthService.login(username: "admin", password: "1234")
        XCTAssertTrue(result)
    }

    func testLoginFailure() async throws {
        do {
            _ = try await AuthService.login(username: "wrong", password: "bad")
            XCTFail("Login should have failed")
        } catch let error as AuthService.AuthError {
            XCTAssertEqual(error, .invalidCredentials)
        }
    }
}
