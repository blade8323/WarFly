//
//  Backgound.swift
//  WarFly
//
//  Created by Владислав Соколов on 01.05.2022.
//

import SpriteKit

class Backgound: SKSpriteNode {
    static func populateBackground(at point: CGPoint) -> Backgound {
        let background = Backgound(imageNamed: "background")
        background.position = point
        background.zPosition = 0
        
        return background
    }
}
