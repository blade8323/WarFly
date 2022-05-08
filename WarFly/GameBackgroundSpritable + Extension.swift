//
//  GameBackgroundSpritable.swift
//  WarFly
//
//  Created by Владислав Соколов on 01.05.2022.
//

import SpriteKit
import GameplayKit

protocol GamebackgroundSpritable {
    static func populate(at point: CGPoint?) -> Self
    static func randomPoint() -> CGPoint
}

extension GamebackgroundSpritable {
    static func randomPoint() -> CGPoint {
        let screen = UIScreen.main.bounds
        let distribution = GKRandomDistribution(lowestValue: Int(screen.size.height) + 400, highestValue: Int(screen.size.height) + 500)
        //координата по y выше экрана от 100 до 200 поинтов
        let y = CGFloat(distribution.nextInt())
        //координата по х от 0 до ширины экрана
        let x = CGFloat(GKRandomSource.sharedRandom().nextInt(upperBound: Int(screen.size.width)))
        
        return CGPoint(x: x, y: y)
    }
}
