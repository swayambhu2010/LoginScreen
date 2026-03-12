//
//  LoginFlowIntegrationTests.swift
//  LoginScreenTests
//
//  Created by Swayambhu BANERJEE on 11/03/26.
//

import XCTest
@testable import LoginScreen

@MainActor
final class LoginFlowIntegrationTests: XCTestCase {

    var viewModel: LoginViewModel!
        
        // TEST: Full login flow
        func testCompleteLoginFlow_FromCredentialsToSuccess() async {
            // This uses real UseCase + mocked Repository
            let mockRepository = MockLoginRepository()
            mockRepository.loginResult = .success(UserModel(userName: "testuser", token: "token123"))
            
            let loginUseCase = LoginUseCase(loginRepository: mockRepository)
            viewModel = LoginViewModel(loginUseCase: loginUseCase)
            
            // User enters credentials
            viewModel.userName = "testuser"
            viewModel.password = "ValidPass123"
            
            // User taps login
            viewModel.validation()
            
            // Should be logged in
            XCTAssertTrue(viewModel.isValidPassword)
            XCTAssertTrue(mockRepository.saveUserCalled)
        }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
