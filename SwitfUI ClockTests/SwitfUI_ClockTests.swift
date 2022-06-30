//
//  SwitfUI_ClockTests.swift
//  SwitfUI ClockTests
//
//  Created by Richard Lam on 30/6/2022.
//

import XCTest
@testable import SwitfUI_Clock

class SwitfUI_ClockTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testXCordinatesAreCorrect() throws {
        let theSize =  CGSize(width: 10.0, height: 10.0)
        let theHandLength = 5.0
        
        var theClockValue = 15.0
        var result = calculateEndPointX(clockValue: theClockValue, size: theSize, handLength: theHandLength)
        XCTAssertEqual(result, 10.0, accuracy: 0.01)
        result = calculateEndPointY(clockValue: theClockValue, size: theSize, handLength: theHandLength)
        XCTAssertEqual(result, 5.0, accuracy: 0.01)

        theClockValue = 30.0
        result = calculateEndPointX(clockValue: theClockValue, size: theSize, handLength: theHandLength)
        XCTAssertEqual(result, 5.0, accuracy: 0.01)
        result = calculateEndPointY(clockValue: theClockValue, size: theSize, handLength: theHandLength)
        XCTAssertEqual(result, 10.0, accuracy: 0.01)

        theClockValue = 45.0
        result = calculateEndPointX(clockValue: theClockValue, size: theSize, handLength: theHandLength)
        XCTAssertEqual(result, 0.0, accuracy: 0.01)
        result = calculateEndPointY(clockValue: theClockValue, size: theSize, handLength: theHandLength)
        XCTAssertEqual(result, 5.0, accuracy: 0.01)

        theClockValue = 0.0
        result = calculateEndPointX(clockValue: theClockValue, size: theSize, handLength: theHandLength)
        XCTAssertEqual(result, 5.0, accuracy: 0.01)
        result = calculateEndPointY(clockValue: theClockValue, size: theSize, handLength: theHandLength)
        XCTAssertEqual(result, 0.0, accuracy: 0.01)

    }


    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
