//
//  BluePowerUp.swift
//  WarFly
//
//  Created by Владислав Соколов on 11.05.2022.
//

import SpriteKit

class BluePowerUp: PowerUp {
    
    init() {
        let textureAtlas = SKTextureAtlas(named: "BluePowerUp")
        super.init(textureAtlas: textureAtlas)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
