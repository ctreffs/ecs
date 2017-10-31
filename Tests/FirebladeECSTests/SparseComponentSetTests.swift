//
//  SparseComponentSetTests.swift
//  FirebladeECSTests
//
//  Created by Christian Treffs on 31.10.17.
//

import XCTest
@testable import FirebladeECS

class SparseComponentSetTests: XCTestCase {

	func testSet() {
		let s = SparseComponentSet()

		let num: Int = 100

		for i in 0..<num {
			s.add(Position(x: i, y: i), with: EntityIndex(i))
		}

		XCTAssert(s.count == num)

		for i in 0..<num {
			let idx = num-i-1
			let p: Position = s.get(at: idx) as! Position
			XCTAssertEqual(idx, p.x)
		}

		for i in 0..<num {
			s.remove(EntityIndex(i))
		}

		XCTAssert(s.count == 0)
	}
}
