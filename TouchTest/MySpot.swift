//
//  MySpot.swift
//  TouchTest
//
//  Created by rick conroy on 2014-07-17.
//  Copyright (c) 2014 rick conroy. All rights reserved.
//

import SpriteKit

class MySpot: Printable {
	var xPos: Int
	var yPos: Int
	var radius: Int
	let toneType: ToneType
	var useCounter: Int
	var useable: Bool
	
	init(xPos: Int, yPos: Int, radius: Int, toneType:ToneType) {
		self.xPos = xPos
		self.yPos = yPos
		self.radius = radius
		self.toneType = toneType
		self.useCounter = 0
		self.useable = false
	}
	
	var description: String {
		return "x:y \(xPos):\(yPos), radius: \(radius)"
	}
}

// attempting to integrate the "equatable" protocol
func == (lhs: MySpot, rhs: MySpot) -> Bool {
	return (lhs.xPos == rhs.xPos) && (lhs.yPos == rhs.yPos)
}

enum ToneType: Int, Printable {
	case Unknown = 0, B1, C2, D2, E2, F2, G2, A2, B2, C3, D3
	
	// returns file names for corresponding sprite images
	var toneName: String {
	let toneNames = ["B1", "C2", "D2", "E2", "F2", "G2", "A2", "B2", "C3", "D3"]
		// toRaw() converts the enum’s current value to an integer
		return toneNames[toRaw() - 1]
	}
	
	static func random() -> ToneType {
		// arc4random_uniform() returns a "UInt32", convert to Int (Swift is strict!)
		// "fromRaw" converts from Int to proper "ToneType" value
		return ToneType.fromRaw(Int(arc4random_uniform(10)) + 1)!
	}
	
	var description: String {
		return toneName
	}
}
