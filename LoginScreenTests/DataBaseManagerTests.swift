//
//  DataBaseManagerTests.swift
//  LoginScreenTests
//

import XCTest
import CoreData
@testable import LoginScreen

final class DataBaseManagerTests: XCTestCase {

    var dataBaseManager: DataBaseManager!

    override func setUp() {
        super.setUp()
        // ✅ Every test gets a FRESH in-memory store — no leftover data
        dataBaseManager = DataBaseManager(inMemory: true)
    }

    override func tearDown() {
        dataBaseManager = nil   // ✅ wipes the in-memory store completely
        super.tearDown()
    }

    // =========================================================================
    // MARK: - Helper
    // =========================================================================

    // Convenience to create a LoginModel — avoids repetition across tests
    func makeUser(username: String = "testuser",
                  password: String = "pass123") -> LoginModel {
        LoginModel(username: username, password: password, uuid: UUID())
    }

    // =========================================================================
    // MARK: - saveUser Tests
    // =========================================================================

    // TEST 1: Save a user → getAllUsers should return that user
    func testSaveUser_ShouldPersistUserInStore() {
        // Arrange
        let user = makeUser(username: "john", password: "pass123")

        // Act
        dataBaseManager.saveUser(userModel: user)

        // Assert
        let users = dataBaseManager.getAllUsers()
        XCTAssertEqual(users.count, 1)
        XCTAssertEqual(users.first?.username, "john")
        XCTAssertEqual(users.first?.password, "pass123")
        XCTAssertEqual(users.first?.uuid, user.uuid)
    }

    // TEST 2: Save multiple users → getAllUsers should return all of them
    func testSaveMultipleUsers_ShouldPersistAllUsers() {
        // Arrange
        let user1 = makeUser(username: "john")
        let user2 = makeUser(username: "jane")
        let user3 = makeUser(username: "bob")

        // Act
        dataBaseManager.saveUser(userModel: user1)
        dataBaseManager.saveUser(userModel: user2)
        dataBaseManager.saveUser(userModel: user3)

        // Assert
        let users = dataBaseManager.getAllUsers()
        XCTAssertEqual(users.count, 3)
    }

    // TEST 3: Save a user → UUID is correctly stored and retrieved
    func testSaveUser_ShouldPreserveUUID() {
        // Arrange
        let user = makeUser()
        let originalUUID = user.uuid

        // Act
        dataBaseManager.saveUser(userModel: user)

        // Assert
        let fetched = dataBaseManager.getAllUsers()
        XCTAssertEqual(fetched.first?.uuid, originalUUID)
    }

    // =========================================================================
    // MARK: - getAllUsers Tests
    // =========================================================================

    // TEST 4: Empty store → getAllUsers returns empty array
    func testGetAllUsers_WhenStoreIsEmpty_ShouldReturnEmptyArray() {
        // Act
        let users = dataBaseManager.getAllUsers()

        // Assert
        XCTAssertTrue(users.isEmpty)
        XCTAssertEqual(users.count, 0)
    }

    // TEST 5: After saving → getAllUsers count matches saved count
    func testGetAllUsers_ShouldReturnCorrectCount() {
        // Arrange
        dataBaseManager.saveUser(userModel: makeUser(username: "user1"))
        dataBaseManager.saveUser(userModel: makeUser(username: "user2"))

        // Act
        let users = dataBaseManager.getAllUsers()

        // Assert
        XCTAssertEqual(users.count, 2)
    }

    // =========================================================================
    // MARK: - deleteUser Tests
    // =========================================================================

    // TEST 6: Save then delete → user should be gone
    func testDeleteUser_ShouldRemoveUserFromStore() {
        // Arrange
        let user = makeUser(username: "john")
        dataBaseManager.saveUser(userModel: user)
        XCTAssertEqual(dataBaseManager.getAllUsers().count, 1)  // confirm save worked

        // Act
        dataBaseManager.deleteUser(user: user)

        // Assert
        let users = dataBaseManager.getAllUsers()
        XCTAssertEqual(users.count, 0)                          // should be empty now
        XCTAssertFalse(users.contains { $0.uuid == user.uuid }) // uuid not present
    }

    // TEST 7: Save 2 users, delete 1 → only the correct one is removed
    func testDeleteUser_ShouldOnlyRemoveTheTargetUser() {
        // Arrange
        let user1 = makeUser(username: "john")
        let user2 = makeUser(username: "jane")
        dataBaseManager.saveUser(userModel: user1)
        dataBaseManager.saveUser(userModel: user2)

        // Act
        dataBaseManager.deleteUser(user: user1)

        // Assert
        let users = dataBaseManager.getAllUsers()
        XCTAssertEqual(users.count, 1)
        XCTAssertEqual(users.first?.username, "jane")           // jane still exists
        XCTAssertFalse(users.contains { $0.uuid == user1.uuid }) // john is gone
    }

    // TEST 8: Delete a user that doesn't exist → should not crash, count unchanged
    func testDeleteUser_WhenUserDoesNotExist_ShouldNotCrash() {
        // Arrange
        let realUser = makeUser(username: "john")
        dataBaseManager.saveUser(userModel: realUser)
        let fakeUser = makeUser(username: "ghost") // never saved

        // Act — should not throw or crash
        dataBaseManager.deleteUser(user: fakeUser)

        // Assert — john is still there
        XCTAssertEqual(dataBaseManager.getAllUsers().count, 1)
    }

    // =========================================================================
    // MARK: - updateUser Tests
    // =========================================================================

    // TEST 9: Save then update → new username is persisted
    func testUpdateUser_ShouldUpdateUsernameInStore() throws {
        // Arrange
        var user = makeUser(username: "oldName")
        dataBaseManager.saveUser(userModel: user)

        // Act — change the name and update
        user.username = "newName"
        let result = try dataBaseManager.updateUser(user: user)

        // Assert
        XCTAssertTrue(result)                                       // returns true on success
        let users = dataBaseManager.getAllUsers()
        XCTAssertEqual(users.first?.username, "newName")            // new name saved
        XCTAssertEqual(users.first?.uuid, user.uuid)                // same UUID
    }

    // TEST 10: Update preserves UUID and password — only username changes
    func testUpdateUser_ShouldOnlyChangeUsername_NotOtherFields() throws {
        // Arrange
        var user = makeUser(username: "oldName", password: "mypassword")
        dataBaseManager.saveUser(userModel: user)
        let originalUUID = user.uuid

        // Act
        user.username = "newName"
        _ = try dataBaseManager.updateUser(user: user)

        // Assert
        let updated = dataBaseManager.getAllUsers().first
        XCTAssertEqual(updated?.username, "newName")        // ✅ name changed
        XCTAssertEqual(updated?.password, "mypassword")     // ✅ password untouched
        XCTAssertEqual(updated?.uuid, originalUUID)         // ✅ UUID untouched
    }

    // TEST 11: Update a user that doesn't exist → should throw fetchError
    func testUpdateUser_WhenUserDoesNotExist_ShouldThrowFetchError() {
        // Arrange — user never saved
        let user = makeUser(username: "ghost")

        // Act & Assert
        XCTAssertThrowsError(try dataBaseManager.updateUser(user: user)) { error in
            XCTAssertEqual(error as? DataBaseError, DataBaseError.fetchError)
        }
    }

    // =========================================================================
    // MARK: - fetchUser Tests
    // =========================================================================

    // TEST 12: fetchUser with correct UUID → returns the right UserData
    func testFetchUser_WithValidUUID_ShouldReturnUser() {
        // Arrange
        let user = makeUser(username: "john")
        dataBaseManager.saveUser(userModel: user)

        // Act
        let fetched = dataBaseManager.fetchUser(id: user.uuid)

        // Assert
        XCTAssertNotNil(fetched)
        XCTAssertEqual(fetched?.userName, "john")
        XCTAssertEqual(fetched?.userId, user.uuid)
    }

    // TEST 13: fetchUser with wrong UUID → returns nil
    func testFetchUser_WithInvalidUUID_ShouldReturnNil() {
        // Arrange
        let user = makeUser(username: "john")
        dataBaseManager.saveUser(userModel: user)
        let wrongUUID = UUID() // completely different UUID

        // Act
        let fetched = dataBaseManager.fetchUser(id: wrongUUID)

        // Assert
        XCTAssertNil(fetched)
    }

    // =========================================================================
    // MARK: - Full CRUD Flow Test (Integration style)
    // =========================================================================

    // TEST 14: Full Create → Read → Update → Delete flow
    func testFullCRUDFlow_ShouldWorkCorrectly() throws {
        // CREATE
        var user = makeUser(username: "john", password: "pass")
        dataBaseManager.saveUser(userModel: user)
        XCTAssertEqual(dataBaseManager.getAllUsers().count, 1, "Should have 1 user after save")

        // READ
        let allUsers = dataBaseManager.getAllUsers()
        XCTAssertEqual(allUsers.first?.username, "john", "Saved username should be john")

        // UPDATE
        user.username = "john_updated"
        _ = try dataBaseManager.updateUser(user: user)
        XCTAssertEqual(dataBaseManager.getAllUsers().first?.username, "john_updated", "Username should be updated")

        // DELETE
        dataBaseManager.deleteUser(user: user)
        XCTAssertEqual(dataBaseManager.getAllUsers().count, 0, "Should be empty after delete")
    }
}
