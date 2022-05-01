//
//  GameBackgroundSpritable.swift
//  WarFly
//
//  Created by Владислав Соколов on 01.05.2022.
//

import SpriteKit

protocol GamebackgroundSpritable {
    static func populateSprite(at point: CGPoint) -> Self
}
