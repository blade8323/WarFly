//
//  YellowShot.swift
//  WarFly
//
//  Created by Владислав Соколов on 11.05.2022.
//

import SpriteKit

class YellowShot: Shot {
    init() {
        let textureAtlas = Assets.shared.yellowAmmoAtlas//SKTextureAtlas(named: "YellowAmmo")
        super.init(textureAtlas: textureAtlas)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
