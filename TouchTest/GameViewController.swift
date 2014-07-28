//
//  GameViewController.swift
//  TouchTest
//
//  Created by rick conroy on 2014-07-15.
//  Copyright (c) 2014 rick conroy. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {
	// scene draws draws the action; handles touch events
	var scene: GameScene!
	
	@IBOutlet var clearButton: UIButton!
	
	// rotations and orientations
	override func shouldAutorotate() -> Bool {
		return true
	}
	override func supportedInterfaceOrientations() -> Int {
		return Int(UIInterfaceOrientationMask.AllButUpsideDown.toRaw())
	}

    override func viewDidLoad() {
		super.viewDidLoad()
		
		// configure the view
		let skView = view as SKView
		skView.multipleTouchEnabled = false
		
		// create and configure the scene
		scene = GameScene(size: skView.bounds.size)
		// scene.scaleMode = .AspectFill
		
		// present the scene
		skView.presentScene(scene)
	}
	
	@IBAction func clearButtonPressed(AnyObject) {
		scene.board.clearSequence()
	}
	
	// MARK: Other housekeeping

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
