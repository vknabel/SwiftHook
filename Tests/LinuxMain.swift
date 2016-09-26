import XCTest
@testable import SwiftHook
import SwiftHookTests

var tests = [XCTestCaseEntry]()
tests += SwiftHookTests.allTests()
XCTMain(tests)
