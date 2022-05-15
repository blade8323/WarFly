//
//  BitMaskCategory.swift
//  WarFly
//
//  Created by Владислав Соколов on 15.05.2022.
//

import SpriteKit

struct BitMaskCategory: OptionSet {
    let rawValue: UInt32
    init(rawValue: UInt32) {
        self.rawValue = rawValue
    }
    
    //    static let player : UInt32 = 0x1 << 0    //000000000000000...01 можно 1
    //    static let enemy : UInt32 = 0x1 << 1     //000000000000000...10 можно 2
    //    static let powerUp : UInt32 = 0x1 << 2   //00000000000000...100 можно 3
    //    static let shot : UInt32 = 0x1 << 3      //0000000000000...1000 можно 4
    
    static let none = BitMaskCategory(rawValue: 0 << 0)
    static let player = BitMaskCategory(rawValue: 1 << 0)
    static let enemy = BitMaskCategory(rawValue: 1 << 1)
    static let powerUp = BitMaskCategory(rawValue: 1 << 2)
    static let shot = BitMaskCategory(rawValue: 1 << 3)
    static let all = BitMaskCategory(rawValue: UInt32.max)
}


extension SKPhysicsBody {
    var category: BitMaskCategory {
        get {
            return BitMaskCategory(rawValue: self.categoryBitMask)
        }
        
        set {
            self.categoryBitMask = newValue.rawValue
        }
    }
}
