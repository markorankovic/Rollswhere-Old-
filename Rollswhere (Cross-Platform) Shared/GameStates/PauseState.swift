//
//  PauseState.swift
//  Rollswhere (W GameplayKit)
//
//  Created by Marko on 01/06/2018.
//  Copyright © 2018 Marko. All rights reserved.
//

import GameplayKit

class PauseState: GameState {
    
    var previousState2: GKState?
    
    func resumeScene() {
        game.scene?.physicsWorld.speed = 1
    }

    func pauseScene() {
        game.scene?.physicsWorld.speed = 0
    }
    
    func openPauseMenu() {
        guard let scene = game.scene else {
            return
        }
        guard let camera = scene.camera else {
            return
        }
        guard let backgroundSize = scene.childNode(withName: "background")?.frame.size else {
            return
        }
        game.scene?.childNode(withName: "pauseMenu")?.alpha = 1
        game.scene?.childNode(withName: "pauseMenu")?.position = camera.position
        if game.scene?.childNode(withName: "backgroundBlur") == nil {
            let backgroundBlur = SKSpriteNode(color: .black, size: backgroundSize)
            backgroundBlur.alpha = 0.5
            backgroundBlur.zPosition = 21
            backgroundBlur.name = "backgroundBlur"
            game.scene?.addChild(backgroundBlur)
        }
    } 
    
    func closePauseMenu() {
        game.scene?.childNode(withName: "pauseMenu")?.alpha = 0
        game.scene?.childNode(withName: "backgroundBlur")?.removeFromParent()
    }
    
    override func didEnter(from previousState: GKState?) {
        previousState2 = previousState
        pauseScene()
        openPauseMenu()
        print("Entered pause")
    }
    
    #if os(OSX)
    
    override func escPressed() {
        if let previousState2 = previousState2 {
            closePauseMenu()
            resumeScene()
            stateMachine?.enter(type(of: previousState2))
        }
    }
    
    override func tapGestureHandler(gestureRecognizer: NSClickGestureRecognizer) {
        guard let scene = game.scene else {
            return
        }
        guard let view = scene.view else {
            return
        }
        if let pauseMenu = scene.childNode(withName: "pauseMenu") {
            if pauseMenu == scene.nodes(at: scene.convertPoint(fromView: gestureRecognizer.location(in: view))).first {
                game.returnToMainMenu(view: view)
            }
        }
    }
    
    #endif
    
}

