//
//  spaceXChallengeTests.swift
//  spaceXChallengeTests
//
//  Created by Roger Morales Jiménez on 06/09/23.
//

import XCTest
import Combine
@testable import spaceXChallenge

final class spaceXChallengeTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAppNetworkProviderGetLaunchs() {
        let exp = expectation(description: "[TEST] : Parse Launch success")
        var launchs = Set<AnyCancellable>()
        
        let networkClient = TestUtils.mockNetworkClient(file: "mockLaunchData.json")
        let appNetworkClient = AppNetworkClient()
        appNetworkClient.networkClient = networkClient
        
        appNetworkClient.getMissionsList().sink { _ in} receiveValue: { values in
            let isCorrectParsing = !values.isEmpty
            
            XCTAssert(isCorrectParsing)
            
            exp.fulfill()
        }.store(in: &launchs)
        

        wait(for: [exp], timeout: 0.5)
    }

}
