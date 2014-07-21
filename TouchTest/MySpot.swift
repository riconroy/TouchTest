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
	var useCounter: Int
	var useable: Bool
	var colour: SKColor?
	
	init(xPos: Int, yPos: Int, radius: Int) {
		self.xPos = xPos
		self.yPos = yPos
		self.radius = radius
		self.useCounter = 0
		self.useable = false
		self.colour = SKColor.brownColor()
	}
	
	// count how many times this spot has been used, and return true if it's over three
	func increaseUsageStats() -> Bool {
		useCounter++
		// NSLog("usage: \(useCounter)")
		
		if useCounter > 3 {
			return true
		} else {
			useable = true
			return false
		}
	}
	
	var description: String {
		return "x:y \(xPos):\(yPos), radius: \(radius)"
	}
}

// attempting to integrate the "equatable" protocol
func == (lhs: MySpot, rhs: MySpot) -> Bool {
	return (lhs.xPos == rhs.xPos) && (lhs.yPos == rhs.yPos)
}
