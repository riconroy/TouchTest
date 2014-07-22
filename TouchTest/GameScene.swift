//
//  GameScene.swift
//  TouchTest
//
//  Created by rick conroy on 2014-07-15.
//  Copyright (c) 2014 rick conroy. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
	// base layer is "game", contains all the spots
	let gameLayer = SKNode()
	
	// board holds the model of all the dots
	let board: MyBoard!
	
	// an initial radius for all the spots
	let initialRadius = 4.0
	
	// two more constants: the timing between spots playing
	let timeBetweenSpotPlay: NSTimeInterval = 0.5
	let timeBetweenSequence: NSTimeInterval = 2.0
	
	// pre-load the sound resources
	let B1Sound = SKAction.playSoundFileNamed("B1.m4a", waitForCompletion: false)
	let C2Sound = SKAction.playSoundFileNamed("C2.m4a", waitForCompletion: false)
	let D2Sound = SKAction.playSoundFileNamed("D2.m4a", waitForCompletion: false)
	let E2Sound = SKAction.playSoundFileNamed("E2.m4a", waitForCompletion: false)
	let F2Sound = SKAction.playSoundFileNamed("F2.m4a", waitForCompletion: false)
	let G2Sound = SKAction.playSoundFileNamed("G2.m4a", waitForCompletion: false)
	let A2Sound = SKAction.playSoundFileNamed("A2.m4a", waitForCompletion: false)
	let B2Sound = SKAction.playSoundFileNamed("B2.m4a", waitForCompletion: false)
	let C3Sound = SKAction.playSoundFileNamed("C3.m4a", waitForCompletion: false)
	let D3Sound = SKAction.playSoundFileNamed("D3.m4a", waitForCompletion: false)
	
	init(size: CGSize) {
		super.init(size: size)
		board = MyBoard()
	}
	
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
		self.backgroundColor = SKColor(red: 159.0/255.0, green: 159.0/255.0, blue: 1.0, alpha: 0.99)
		
		// start a timer that goes every few seconds.
		startNewTimer(timeBetweenSequence)
		
		// the single layer that holds all the spots
		self.addChild(gameLayer)
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
			// with this, create the model spot, then refresh the screen
			let newSpot: MySpot = board.addNewSpot(Int(location.x), y: Int(location.y))
			
			displaySpot(newSpot)
        }
	}
	
	// for completeness. Evidently needed.
	override func touchesEnded(touches: NSSet!, withEvent event: UIEvent!) {
	}
	override func touchesCancelled(touches: NSSet!, withEvent event: UIEvent!) {
	}
	
	// MARK: Displaying Spots
	
	func displaySpot(spot: MySpot) {
		// make a path and arc to create a circle
		// let initialRadius = 4.0 // CGFloat(spot.radius)
		let myPath: CGMutablePathRef = CGPathCreateMutable()
		CGPathAddArc(myPath, nil, 0, 0, initialRadius, 0, M_PI * 2, true)
		
		// create the circle, and show it
		//    (note that in iOS 8 there are way more convenient ways to do this)
		let myCircle = SKShapeNode()
		myCircle.path = myPath
		myCircle.position = CGPoint(x: spot.xPos, y: spot.yPos)
		myCircle.lineWidth = 1.5
		myCircle.antialiased = false
		myCircle.fillColor = SKColor.clearColor()
		myCircle.strokeColor = SKColor.whiteColor()
		myCircle.physicsBody = SKPhysicsBody(edgeLoopFromPath: myPath)
		
		self.addChild(myCircle)
		
		let toneType: ToneType = spot.toneType
		animateSpot(myCircle, toneType: toneType, completion: {
			// tell the board the animation has finished - NOT ACTUALLY USING THIS AT THE MOMENT
			self.board.spotAnimationFinished(spot)
			// remove the child from the parent (how necessary is this?)
			myCircle.removeFromParent()
		})
	}
	
	// method to animate the spot - expand and fade out
	func animateSpot(circle:SKShapeNode, toneType:ToneType, completion: () -> ()) {
		let duration: NSTimeInterval = 1.9
		let scaleToValue = 12.0
		let fade = SKAction.fadeOutWithDuration(duration)
		fade.timingMode = .EaseOut
		
		// some ideas from @Grimxn:
		typealias ActionBlock = ((SKNode!, CGFloat) -> Void)
		let ab: ActionBlock = { (node, value) in
			if let drop = node as? SKShapeNode {
				let myPath: CGMutablePathRef = CGPathCreateMutable()
				CGPathAddArc(myPath, nil, 0, 0, self.initialRadius * (1.0 + (value * scaleToValue / duration)), 0, M_PI * 2, true)
				drop.path = myPath
			}
		}
		// see: http://stackoverflow.com/questions/24868450/expanding-circle-with-fixed-outline-width
		
		let newScale = SKAction.customActionWithDuration(duration, actionBlock: ab)
		newScale.timingMode = .EaseOut
		playCorrectSound(toneType)
		circle.runAction(fade)
		circle.runAction(newScale, completion: completion)
	}
	
	func playCorrectSound(toneType: ToneType) {
		switch toneType.toneName {
		case "B1":
			runAction(B1Sound)
		case "C2":
			runAction(C2Sound)
		case "D2":
			runAction(D2Sound)
		case "E2":
			runAction(E2Sound)
		case "F2":
			runAction(F2Sound)
		case "G2":
			runAction(G2Sound)
		case "A2":
			runAction(A2Sound)
		case "B2":
			runAction(B2Sound)
		case "C3":
			runAction(C2Sound)
		case "D3":
			runAction(D3Sound)
		default:
			NSLog("There was an error translating the tone type")
		}
	}
	
	// MARK: Timing Routines
	
	func myTimerFired() {
		// check to see what the next spot to play is
		if let nextSpotToPlay = board.getNextSpotToPlay() {
			self.displaySpot(nextSpotToPlay)
			startNewTimer(timeBetweenSpotPlay)
		} else {
			startNewTimer(timeBetweenSequence)
		}
	}
	
	// timer for a few seconds of wait time
	// when timer fires, if there's a spot "ready to go", display it
	func startNewTimer(theDelay: NSTimeInterval) {
		//     Note "selector" is not part of the Swift language, but Obj C. But what do we replace it with?
		let mySelector : Selector = "myTimerFired"
		// let waitTime: NSTimeInterval = NSTimeInterval(arc4random_uniform(3) + 3)
		var timer = NSTimer.scheduledTimerWithTimeInterval(theDelay,
			target: self,
			selector: mySelector,
			userInfo: nil,
			repeats: false)
		let mainLoop = NSRunLoop.mainRunLoop()
		mainLoop.addTimer(timer, forMode: NSDefaultRunLoopMode)
	}
	
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
