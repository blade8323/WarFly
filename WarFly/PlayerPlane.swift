//
//  PlayerPlane.swift
//  WarFly
//
//  Created by Владислав Соколов on 01.05.2022.
//

import SpriteKit
import CoreMotion

class PlayerPlane: SKSpriteNode {
    
    let motionmanager = CMMotionManager()
    var xAcceleration: CGFloat = 0
    let screenSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    var leftTextureArrayAnimation = [SKTexture]()
    var rightTextureArrayAnimation = [SKTexture]()
    var forwardTextureArrayAnimation = [SKTexture]()
    var moveDirection: TurnDirection = .none
    var stillTurning = false
    let animationSpriteStrides = [(13, 1, -1), (13, 26, 1), (13, 13, 1)]
    
    static func populate(at point: CGPoint) -> PlayerPlane {
        let playerPlaneTexture = Assets.shared.playerPlaneAtlas.textureNamed("airplane_3ver2_13")//SKTexture(imageNamed: "airplane_3ver2_13")
        let playerPlane = PlayerPlane(texture: playerPlaneTexture)
        playerPlane.setScale(0.5)
        playerPlane.position = point
        playerPlane.zPosition = 40
        
        //        Physics body with CGPath
        //        let offsetX = playerPlane.frame.size.width * playerPlane.anchorPoint.x
        //        let offsetY = playerPlane.frame.size.height * playerPlane.anchorPoint.y
        //
        //        let path = CGMutablePath()
        //        path.move(to: CGPoint(x: 9 - offsetX, y: 76 - offsetY))
        //        path.addLine(to: CGPoint(x: 64 - offsetX, y: 85 - offsetY))
        //        path.addLine(to: CGPoint(x: 71 - offsetX, y: 98 - offsetY))
        //        path.addLine(to: CGPoint(x: 78 - offsetX, y: 99 - offsetY))
        //        path.addLine(to: CGPoint(x: 86 - offsetX, y: 86 - offsetY))
        //        path.addLine(to: CGPoint(x: 140 - offsetX, y: 77 - offsetY))
        //        path.addLine(to: CGPoint(x: 143 - offsetX, y: 68 - offsetY))
        //        path.addLine(to: CGPoint(x: 84 - offsetX, y: 56 - offsetY))
        //        path.addLine(to: CGPoint(x: 80 - offsetX, y: 24 - offsetY))
        //        path.addLine(to: CGPoint(x: 92 - offsetX, y: 20 - offsetY))
        //        path.addLine(to: CGPoint(x: 95 - offsetX, y: 11 - offsetY))
        //        path.addLine(to: CGPoint(x: 79 - offsetX, y: 6 - offsetY))
        //        path.addLine(to: CGPoint(x: 57 - offsetX, y: 8 - offsetY))
        //        path.addLine(to: CGPoint(x: 56 - offsetX, y: 19 - offsetY))
        //        path.addLine(to: CGPoint(x: 72 - offsetX, y: 23 - offsetY))
        //        path.addLine(to: CGPoint(x: 67 - offsetX, y: 57 - offsetY))
        //        path.addLine(to: CGPoint(x: 8 - offsetX, y: 64 - offsetY))
        //        path.addLine(to: CGPoint(x: 9 - offsetX, y: 76 - offsetY))
        //        path.closeSubpath()
        //        playerPlane.physicsBody = SKPhysicsBody(polygonFrom: path)
        
        playerPlane.physicsBody = SKPhysicsBody(texture: playerPlaneTexture, alphaThreshold: 0.5, size: playerPlane.size)
        playerPlane.physicsBody?.isDynamic = false //не реагировать никак на столкновения
        playerPlane.physicsBody?.categoryBitMask = BitMaskCategory.player.rawValue
        playerPlane.physicsBody?.collisionBitMask = BitMaskCategory.enemy.rawValue | BitMaskCategory.powerUp.rawValue //с кем сталкиваемся
        playerPlane.physicsBody?.contactTestBitMask = BitMaskCategory.enemy.rawValue | BitMaskCategory.powerUp.rawValue //регистрация столкновений
        
        return playerPlane
    }
    
    func performFly() {
        preloadTextureArrays()
        //        planeAnimationFillArray()
        motionmanager.accelerometerUpdateInterval = 0.2
        motionmanager.startAccelerometerUpdates(to: OperationQueue.current!) { [unowned self] (data, error) in
            if let data = data {
                let acceleration = data.acceleration
                self.xAcceleration = CGFloat(acceleration.x) * 0.7 + self.xAcceleration * 0.3
                //print(self.xAcceleration)
            }
        }
        
        let planeWaitAction = SKAction.wait(forDuration: 1.0)
        let planeDirectionCheckAction = SKAction.run { [unowned self] in
            self.movementDirectionCheck()
        }
        let planeSequence = SKAction.sequence([planeWaitAction, planeDirectionCheckAction])
        let planeSequenceForever = SKAction.repeatForever(planeSequence)
        self.run(planeSequenceForever)
    }
    
    func checkPosition() {
        self.position.x += xAcceleration * 50
        if self.position.x <  -70 {
            self.position.x = screenSize.width + 70
        } else if self.position.x > screenSize.width + 70 {
            self.position.x = -70
        }
    }
    
    fileprivate func preloadTextureArrays() {
        for i in 0...2 {
            self.preloadArray(_stride: animationSpriteStrides[i]) { [unowned self] array in
                switch i {
                case 0: self.leftTextureArrayAnimation = array
                case 1: self.rightTextureArrayAnimation = array
                case 2: self.forwardTextureArrayAnimation = array
                default: break
                }
            }
        }
    }
    
    fileprivate func preloadArray(_stride: (Int, Int, Int), callback: @escaping (_ array: [SKTexture]) -> ()) {
        var array = [SKTexture]()
        for i in stride(from: _stride.0, through: _stride.1, by: _stride.2) {
            let number = String(format: "%02d", i)
            let texture = SKTexture(imageNamed: "airplane_3ver2_\(number)")
            array.append(texture)
        }
        SKTexture.preload(array) {
            callback(array)
        }
        
    }
    
    //    fileprivate func planeAnimationFillArray() {
    //
    //        SKTextureAtlas.preloadTextureAtlases([SKTextureAtlas(named: "PlayerPlane")]) {
    //            self.leftTextureArrayAnimation = {
    //                var array = [SKTexture]()
    //                for i in stride(from: 13, through: 1, by: -1) {
    //                    let number = String(format: "%02d", i)
    //                    let texture = SKTexture(imageNamed: "airplane_3ver2_\(number)")
    //                    array.append(texture)
    //                }
    //
    //                SKTexture.preload(array) {
    //                    print("preload is done")
    //                }
    //                return array
    //            }()
    //
    //            self.rightTextureArrayAnimation = {
    //                var array = [SKTexture]()
    //                for i in stride(from: 13, through: 26, by: 1) {
    //                    let number = String(format: "%02d", i)
    //                    let texture = SKTexture(imageNamed: "airplane_3ver2_\(number)")
    //                    array.append(texture)
    //                }
    //
    //                SKTexture.preload(array) {
    //                    print("preload is done")
    //                }
    //                return array
    //            }()
    //
    //            self.forwardTextureArrayAnimation = {
    //                var array = [SKTexture]()
    //                let texture = SKTexture(imageNamed: "airplane_3ver2_13")
    //                array.append(texture)
    //
    //                SKTexture.preload(array) {
    //                    print("preload is done")
    //                }
    //                return array
    //            }()
    //
    //
    //        }
    //    }
    
    fileprivate func movementDirectionCheck() {
        if xAcceleration > 0.001,  moveDirection != .right, stillTurning == false {
            stillTurning = true
            moveDirection = .right
            //animation
            turnPlane(direction: .right)
        } else if xAcceleration < -0.001,  moveDirection != .left, stillTurning == false {
            stillTurning = true
            moveDirection = .left
            turnPlane(direction: .left)
        } else if stillTurning == false{
            turnPlane(direction: .none)
        }
    }
    
    fileprivate func turnPlane(direction: TurnDirection) {
        var array = [SKTexture]()
        if direction == .right {
            array = rightTextureArrayAnimation
        } else if direction == .left {
            array = leftTextureArrayAnimation
        } else {
            array = forwardTextureArrayAnimation
        }
        
        let forwardAction = SKAction.animate(with: array, timePerFrame: 0.05, resize: true, restore: false)
        let backwardAction = SKAction.animate(with: array.reversed(), timePerFrame: 0.05, resize: true, restore: false)
        let sequenceAction = SKAction.sequence([forwardAction, backwardAction])
        self.run(sequenceAction) { [unowned self] in
            self.stillTurning = false
        }
    }
}


enum TurnDirection {
    case left
    case right
    case none
}
