//
//  LoginUseCaseTest.swift
//  LoginScreenTests
//
//  Created by Swayambhu BANERJEE on 11/03/26.
//

import XCTest
@testable import LoginScreen

final class LoginUseCaseTests: XCTestCase {
    var loginUseCase: LoginUseCase!
    var mockRepository: MockLoginRepository!
    
    override func setUp() {
        super.setUp()
        mockRepository = MockLoginRepository()
        loginUseCase = LoginUseCase(loginRepository: mockRepository)
    }
    
    // TEST 1: Valid login should return user
    func testLoginValidation_WithValidCredentials_ShouldReturnUser() async {
        // Arrange
        let expectedUser = UserModel(userName: "testuser", token: "token123")
        mockRepository.loginResult = .success(expectedUser)
        
        // Act
        let result = await loginUseCase.loginValidation(userName: "testuser", password: "password123")
        
        // Assert
        switch result {
        case .success(let user):
            await MainActor.run {
                XCTAssertEqual(user?.userName, "testuser")
            }
        case .failure:
            XCTFail("Expected success but got failure")
        }
    }
    
    // TEST 2: Invalid credentials should return error
    func testLoginValidation_WithInvalidCredentials_ShouldReturnError() async {
        // Arrange
        mockRepository.loginResult = .failure(.badrequest)
        
        // Act
        let result = await loginUseCase.loginValidation(userName: "testuser", password: "wrongpass")
        
        // Assert
        switch result {
        case .success:
            XCTFail("Expected failure but got success")
        case .failure(let error):
            XCTAssertEqual(error, .badrequest)
        }
    }
    
    // TEST 3: Password validation function
    func testValidatePassword_ValidPassword_ShouldReturnEmpty() {
        // Act
        let result = loginUseCase.validatePassword("ValidPass123")
        
        // Assert
        XCTAssertEqual(result, "")
    }
    
    // TEST 4: Save user should be called
    func testSaveUser_ShouldCallRepository() {
        // Arrange
        let user = LoginModel(username: "test", password: "pass", uuid: UUID())
        
        // Act
        loginUseCase.saveUser(user: user)
        
        // Assert
        XCTAssertTrue(mockRepository.saveUserCalled)
        XCTAssertEqual(mockRepository.savedUser?.username, "test")
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}




