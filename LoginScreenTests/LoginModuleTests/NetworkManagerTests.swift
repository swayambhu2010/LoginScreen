//
//  NetworkManagerTests.swift
//  LoginScreenTests
//

import XCTest
@testable import LoginScreen

final class NetworkManagerTests: XCTestCase {

    var networkManager: NetworkManager!
    var mockSession: MockSessionManager!
    var mockDecoder: MockDecoder!

    // A helper valid endpoint used across all tests
    let validEndpoint = Endpoint(
        baseURL: "https://www.example.com",
        path: "/user",
        method: .post,
        header: ["Content-Type": "application/json"],
        body: nil
    )

    override func setUp() {
        super.setUp()
        mockSession = MockSessionManager()
        mockDecoder = MockDecoder()
        networkManager = NetworkManager(session: mockSession, decode: mockDecoder)
    }

    override func tearDown() {
        networkManager = nil
        mockSession = nil
        mockDecoder = nil
        super.tearDown()
    }

    // -------------------------------------------------------------------------
    // TEST 1: Bad URL → returns .badrequest WITHOUT calling session
    // -------------------------------------------------------------------------
    func testSend_WithInvalidURL_ShouldReturnBadRequest() async {
        // Arrange — endpoint with empty baseURL produces nil urlRequest
        let badEndpoint = Endpoint(baseURL: "", path: "", method: .get, header: nil, body: nil)

        // Act
        let result: Result<UserModel?, NetworkError> = await networkManager.send(url: badEndpoint)

        // Assert
        XCTAssertFalse(mockSession.isExecuted)   // session should NEVER be called
        switch result {
        case .failure(let error):
            XCTAssertEqual(error, .badrequest)
        case .success:
            XCTFail("Expected .badrequest but got success")
        }
    }

    // -------------------------------------------------------------------------
    // TEST 2: Session returns success + Decoder returns model → success
    // -------------------------------------------------------------------------
    func testSend_WhenSessionSucceeds_AndDecoderSucceeds_ShouldReturnModel() async {
        // Arrange
        let expectedUser = UserModel(userName: "testuser", token: "token123")
        mockSession.result = .success(Data())               // session returns raw data
        mockDecoder.result = .success(expectedUser)         // decoder parses it to UserModel

        // Act
        let result: Result<UserModel?, NetworkError> = await networkManager.send(url: validEndpoint)

        // Assert
        XCTAssertTrue(mockSession.isExecuted)    // ✅ session was called
        XCTAssertTrue(mockDecoder.isCalled)     // ✅ decoder was called
        switch result {
        case .success(let user):
            XCTAssertEqual(user?.userName, "testuser")
            XCTAssertEqual(user?.token, "token123")
        case .failure:
            XCTFail("Expected success but got failure")
        }
    }

    // -------------------------------------------------------------------------
    // TEST 3: Session returns network failure → error is forwarded
    // -------------------------------------------------------------------------
    func testSend_WhenSessionFails_ShouldReturnNetworkError() async {
        // Arrange
        mockSession.result = .failure(.serverError(statusCode: 500))

        // Act
        let result: Result<UserModel?, NetworkError> = await networkManager.send(url: validEndpoint)

        // Assert
        XCTAssertTrue(mockSession.isExecuted)    // ✅ session was called
        XCTAssertFalse(mockDecoder.isCalled)    // ✅ decoder should NOT be called
        switch result {
        case .failure(let error):
            XCTAssertEqual(error, .serverError(statusCode: 500))
        case .success:
            XCTFail("Expected failure but got success")
        }
    }

    // -------------------------------------------------------------------------
    // TEST 4: Session succeeds but Decoder fails → decodingError
    // -------------------------------------------------------------------------
    func testSend_WhenSessionSucceeds_ButDecoderFails_ShouldReturnDecodingError() async {
        // Arrange
        mockSession.result = .success(Data())
        mockDecoder.result = .failure(.decodingError)

        // Act
        let result: Result<UserModel?, NetworkError> = await networkManager.send(url: validEndpoint)

        // Assert
        XCTAssertTrue(mockSession.isExecuted)    // ✅ session was called
        XCTAssertTrue(mockDecoder.isCalled)     // ✅ decoder was called
        switch result {
        case .failure(let error):
            XCTAssertEqual(error, .decodingError)
        case .success:
            XCTFail("Expected decodingError but got success")
        }
    }

    // -------------------------------------------------------------------------
    // TEST 5: Correct HTTP method is set on the request
    // -------------------------------------------------------------------------
    func testSend_ShouldSetCorrectHTTPMethod() async {
        // Arrange
        mockSession.result = .success(Data())
        mockDecoder.result = .success(nil)

        // Act
        let _: Result<UserModel?, NetworkError> = await networkManager.send(url: validEndpoint)

        // Assert
        XCTAssertEqual(mockSession.lastRequest?.httpMethod, "POST")  // ✅ method is POST
    }

    // -------------------------------------------------------------------------
    // TEST 6: Correct headers are set on the request
    // -------------------------------------------------------------------------
    func testSend_ShouldSetCorrectHeaders() async {
        // Arrange
        mockSession.result = .success(Data())
        mockDecoder.result = .success(nil)

        // Act
        let _: Result<UserModel?, NetworkError> = await networkManager.send(url: validEndpoint)

        // Assert
        XCTAssertEqual(
            mockSession.lastRequest?.allHTTPHeaderFields?["Content-Type"],
            "application/json"
        )
    }
}
