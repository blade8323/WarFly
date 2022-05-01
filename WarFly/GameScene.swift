//
//  GameScene.swift
//  WarFly
//
//  Created by Владислав Соколов on 01.05.2022.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
        
    override func didMove(to view: SKView) {
        let centerScreen = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        let background = Backgound.populateBackground(at: centerScreen)
        background.size = self.size
        self.addChild(background)
    }
}
