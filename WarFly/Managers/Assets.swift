//
//  Assets.swift
//  WarFly
//
//  Created by Владислав Соколов on 12.05.2022.
//

import SpriteKit

class Assets {
    static let shared = Assets()
    var isLoaded = false
    let enemy_1Atlas = SKTextureAtlas(named: "Enemy_1")
    let enemy_2Atlas = SKTextureAtlas(named: "Enemy_2")
    let greenPowerUpAtlas = SKTextureAtlas(named: "GreenPowerUp")
    let bluePowerUpAtlas = SKTextureAtlas(named: "BluePowerUp")
    let yellowAmmoAtlas = SKTextureAtlas(named: "YellowAmmo")
    let playerPlaneAtlas = SKTextureAtlas(named: "PlayerPlane")
    
    func preloadAssets() {
        enemy_1Atlas.preload { print("enemy_1Atlas preloaded") }
        enemy_2Atlas.preload { print("enemy_2Atlas preloaded") }
        greenPowerUpAtlas.preload { print("greenPowerUpAtlas preloaded") }
        bluePowerUpAtlas.preload { print("bluePowerUpAtlas preloaded") }
        yellowAmmoAtlas.preload { print("yellowAmmoAtlas preloaded") }
        playerPlaneAtlas.preload { print("playerPlaneAtlas preloaded") }
        
    }
}
