//
//  MyBoard.swift
//  TouchTest
//
//  Created by rick conroy on 2014-07-17.
//  Copyright (c) 2014 rick conroy. All rights reserved.
//

import Foundation

class MyBoard {
	// the array holds all the spots, the locations where user has touched
	var array = Array<MySpot?>()
	
	// we limit how many spots are in the array, however
	let maxSpots: Int = 12
	
	// when we play through the spots (outside of the user's control), we track which spot we are ready to play
	var currentSpotToPlay: Int = 0
	
	init() {
	}
	
	// add spot to an array of spots; give it an initial radius
	func addNewSpot(x: Int, y:Int) -> MySpot {
		// create and place a new spot in the game board
		let initialRadius: Int = 5
		var toneType = ToneType.random()
		
		let spot = MySpot(xPos: x, yPos: y, radius: initialRadius, toneType: toneType)
		array.append(spot)
		
		return spot
	}
	
	// a spot has completed its animation - NOT being used!
	func spotAnimationFinished(incoming:MySpot) {
		for (index, spot) in enumerate(array) {
			// spot is an optional type, so it needs to be unwrapped (!)
			if spot! == incoming {
				// NSLog("found this spot: \(spot)")
			}
		}
	}
	
	// return the next spot in the sequence
	//    if the sequence is finished, reset sequence, return nil
	func getNextSpotToPlay() -> MySpot? {
		// if there are no (or no more) spots to play, limit the length of the array, and restart the sequence
		if currentSpotToPlay >= array.count {
			currentSpotToPlay = 0
			limitSizeOfArray()
			return nil
		}
		
		// otherwise return the next spot, and increment
		return array[currentSpotToPlay++]
	}
	
	// use only the last "maxSpots" in the array
	func limitSizeOfArray() {
		while array.count > maxSpots {
			array.removeAtIndex(0)
		}
	}
	
	// the user is clearing the sequence
	func clearSequence() {
		array = []
	}
}
