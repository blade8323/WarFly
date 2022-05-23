//
//  GreenPowerUp.swift
//  WarFly
//
//  Created by Владислав Соколов on 11.05.2022.
//

import SpriteKit

class GreenPowerUp: PowerUp {
    
    init() {
        let textureAtlas = Assets.shared.greenPowerUpAtlas//SKTextureAtlas(named: "GreenPowerUp")
        super.init(textureAtlas: textureAtlas)
        self.name == "greenPowerUp"
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
