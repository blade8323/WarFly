//
//  BitMaskCategory.swift
//  WarFly
//
//  Created by Владислав Соколов on 15.05.2022.
//

import Foundation

struct BitMaskCategory {
    static let player : UInt32 = 0x1 << 0    //000000000000000...01 можно 1
    static let enemy : UInt32 = 0x1 << 1     //000000000000000...10 можно 2
    static let powerUp : UInt32 = 0x1 << 2   //00000000000000...100 можно 3
    static let shot : UInt32 = 0x1 << 3      //0000000000000...1000 можно 4
}
