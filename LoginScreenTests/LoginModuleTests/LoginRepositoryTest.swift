//
//  LoginRepositoryTest.swift
//  LoginScreenTests
//
//  Created by Swayambhu BANERJEE on 11/03/26.
//

import XCTest
@testable import LoginScreen

final class LoginRepositoryTests: XCTestCase {
    var repository: LoginRepository!
    var mockNetworkProvider: MockNetworkServiceProvider!
    var mockDatabaseProvider: MockDataBaseProvider!
    
    override func setUp() {
        super.setUp()
        mockNetworkProvider = MockNetworkServiceProvider()
        mockDatabaseProvider = MockDataBaseProvider()
        repository = LoginRepository(networkProvider: mockNetworkProvider, dataBaseProvider: mockDatabaseProvider)
    }
    
    // TEST 1: Network call returns user
    func testLoginValidation_ShouldCallNetworkProvider() async {
        // Arrange
        let expectedUser = UserModel(userName: "testuser", token: "token123")
        mockNetworkProvider.result = .success(expectedUser)
        
        // Act
        let result = await repository.loginValidation(userName: "testuser", password: "password123")
        
        // Assert
        XCTAssertTrue(mockNetworkProvider.sendValidation)
    }
    
    // TEST 2: Save user should call database
    func testSaveUser_ShouldCallDatabase() {
        // Arrange
        let user = LoginModel(username: "test", password: "pass", uuid: UUID())
        
        // Act
        repository.saveUser(user: user)
        
        // Assert
        XCTAssertTrue(mockDatabaseProvider.saveuserCalled)
    }


    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
