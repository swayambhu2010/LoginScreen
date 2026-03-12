//
//  LoginViewModelTests.swift
//  LoginScreenTests
//
//  Created by Swayambhu BANERJEE on 11/03/26.
//

import XCTest
@testable import LoginScreen

@MainActor
final class LoginViewModelTests: XCTestCase {
    var viewModel: LoginViewModel!
    var mockLoginUseCase: MockLoginUseCase!
    
    override func setUp() {
        super.setUp()
        mockLoginUseCase = MockLoginUseCase()
        viewModel = LoginViewModel(loginUseCase: mockLoginUseCase)
    }
    
    // TEST 1: Valid credentials should allow login
    func testValidationWithValidCredentials_ShouldSetIsValidPasswordTrue() async {
        // Arrange
        viewModel.userName = "testuser"
        viewModel.password = "ValidPass123"
        mockLoginUseCase.loginResult = .success(UserModel(userName: "testuser", token: "token123"))
        
        // Act
        viewModel.validation()
        
        // Assert
        XCTAssertTrue(viewModel.isValidPassword)
        XCTAssertNil(viewModel.errorMessage)
    }
    
    // TEST 2: Invalid credentials should reject login
    func testValidationWithInvalidCredentials_ShouldSetIsValidPasswordFalse() async {
        // Arrange
        viewModel.userName = "testuser"
        viewModel.password = "wrongpass"
        mockLoginUseCase.loginResult = .failure(.badrequest)
        
        // Act
        viewModel.validation()
        
        // Assert
        XCTAssertFalse(viewModel.isValidPassword)
        XCTAssertNotNil(viewModel.errorMessage)
    }
    
    // TEST 3: Password validation - too short
    func testPasswordValidation_LessThan8Characters_ShouldShowError() {
        // Arrange
        let shortPassword = "short"
        
        // Act
        viewModel.validatePassword(shortPassword)
        
        // Assert
        XCTAssertEqual(viewModel.passwordHintText, "Please enter minimum 8 characters")
    }
    
    // TEST 4: Password validation - valid length
    func testPasswordValidation_8OrMoreCharacters_ShouldShowEmpty() {
        // Arrange
        let validPassword = "ValidPass123"
        
        // Act
        viewModel.validatePassword(validPassword)
        
        // Assert
        XCTAssertEqual(viewModel.passwordHintText, "")
    }
    
    // TEST 5: Empty username should not validate
    func testValidationWithEmptyUsername_ShouldFail() async {
        // Arrange
        viewModel.userName = ""
        viewModel.password = "ValidPass123"
        
        // Act
        viewModel.validation()
        
        // Assert
        XCTAssertFalse(viewModel.isValidPassword)
    }
    
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
