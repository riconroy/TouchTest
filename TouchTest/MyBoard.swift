//
//  MyBoard.swift
//  TouchTest
//
//  Created by rick conroy on 2014-07-17.
//  Copyright (c) 2014 rick conroy. All rights reserved.
//

import Foundation

class MyBoard {
	var array = Array<MySpot?>()
	
	init() {
	}
	
	// add spot to an array of spots; give it an initial radius
	func addNewSpot(x: Int, y:Int) -> MySpot {
		// create and place a new spot in the game board
		let initialRadius: Int = 5
		let spot = MySpot(xPos: x, yPos: y, radius: initialRadius)
		array.append(spot)
		
		// tell the GameScene to show this spot, once
		// NSLog("my array is now \(array.count)")
		return spot
	}
	
	// a spot has completed its animation
	func spotAnimationFinished(incoming:MySpot) {
		for (index, spot) in enumerate(array) {
			// spot is an optional type, so it needs to be unwrapped (!)
			if spot! == incoming {
				// NSLog("found this spot: \(spot)")
				// ask if the spot has been used more than three times, and remove it if it has
				let usedTooMuch = spot?.increaseUsageStats()
				if usedTooMuch == true {
					array.removeAtIndex(index)
				}
			}
		}
	}
	
	// return a random spot
	func getRandomSpot() -> MySpot? {
		// build an array of valid indexes
		var validIndexes = [NSNumber]()
		for (index, spot) in enumerate(array) {
			if spot!.useable == true {
				validIndexes.append(index)
			}
		}
		
		// are there any valid spots available?
		if validIndexes.count == 0 {
			return nil
		}
		let myRandomInt: Int = Int(arc4random_uniform(UInt32(validIndexes.count)))
		var theWantedIndex: Int = validIndexes[myRandomInt] as Int
		return array[theWantedIndex]
	}
}
