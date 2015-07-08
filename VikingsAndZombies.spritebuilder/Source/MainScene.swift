import Foundation

class MainScene: CCNode, CCPhysicsCollisionDelegate {
    weak var leftMoveLabel: CCLabelTTF!
    weak var rightMoveLabel: CCLabelTTF!
    weak var leftAttackLabel: CCLabelTTF!
    weak var rightAttackLabel: CCLabelTTF!
    var scrollSpeed = CGFloat(80)
    var tiles: [CCNode] = [] // creates array for tiles
    weak var gamePhysicsNode : CCPhysicsNode! //links physiscs node
    weak var viking: Viking! //links viking sprite from MainScene to code
    var vikingSpeed: Int! = 0 //inits the viking speed as an int and nothing
    var zombieArray: [Zombie] = []
    func didLoadFromCCB () {
        userInteractionEnabled = true //enables user interaction
        //gamePhysicsNode.debugDraw = true
        //gamePhysicsNode.collisionDelegate = self
        
        //addes tiles to array and scene
        for i in 0...10{
            var tile = CCBReader.load("Tile") as! Tile
            tile.position = ccp(tile.position.x + CGFloat(i) * tile.contentSize.width, 0)
            tiles.append(tile)
            gamePhysicsNode.addChild(tile)
        }
    }
    
    
    func killZombie() {
        for zombie in zombieArray {
            var zombieInRangeForSlash = abs((viking.position.x - zombie.position.x)) <= CGFloat(viking.scaleY) * viking.contentSize.width - CGFloat(10)
            if viking.animationManager.runningSequenceName == "Slash(noJump)Animation" && zombieInRangeForSlash {
                zombie.death()
            }else if abs(Int(zombie.position.y - viking.position.y == viking.position.y)) < 3  {
                
                if zombieInRangeForSlash {
                    viking.removeFromParent()
                }
            }

        }
    }
    override func touchBegan(touch: CCTouch!, withEvent event: CCTouchEvent!) {
        //finds which side of the screen the user touched and animates the viking accordly
        if touch.locationInWorld().y < tiles[1].contentSizeInPoints.height * 0.75 {
            if touch.locationInWorld().x < CCDirector.sharedDirector().viewSize().width / 2 {
                viking.left()
                vikingSpeed = -200
                leftMoveLabel.visible = false
            }
            else {
                viking.right()
                vikingSpeed = 200
                rightMoveLabel.visible = false
            }
        }
        else {
            
            if touch.locationInWorld().x < CCDirector.sharedDirector().viewSize().width / 2 {
                if viking.animationManager.runningSequenceName != "Slash(noJump)Animation" {
                    viking.left()
                    viking.slash()
                    leftAttackLabel.visible = false
                }
            }
            else {
                if viking.animationManager.runningSequenceName != "Slash(noJump)Animation" {
                    viking.right()
                    viking.slash()
                    rightAttackLabel.visible = false
                }
            }
            
        }
    }
    
    func spawnZombie() {
        var random = CCRANDOM_0_1()
        if random <= 0.01 {
            println("spawn")
            var zombie = CCBReader.load("Zombie") as! Zombie
            zombie.position = ccp(viking.position.x + self.contentSizeInPoints.width , viking.position.y)
            zombieArray.append(zombie)
            gamePhysicsNode.addChild(zombie)
        }
    }
    
    override func touchEnded(touch: CCTouch!, withEvent event: CCTouchEvent!) {
        //stops viking movement and makes speed 0
        vikingSpeed = 0
        if viking.animationManager.runningSequenceName == "WalkAnimation" {
            viking.standing()
        }
    }
    
    override func update(delta: CCTime) {
        viking.fixSize()
        killZombie()
        //updates viking position
        if !leftMoveLabel.visible && !rightMoveLabel.visible && !leftAttackLabel.visible && !rightAttackLabel.visible {
            gamePhysicsNode.position = ccp(gamePhysicsNode.position.x - scrollSpeed * CGFloat(delta), gamePhysicsNode.position.y)
            let scale = CCDirector.sharedDirector().contentScaleFactor
            gamePhysicsNode.position = ccp(round(gamePhysicsNode.position.x * scale) / scale, round(gamePhysicsNode.position.y * scale) / scale)
        }
        if viking.animationManager.runningSequenceName == "WalkAnimation"{
            viking.positionInPoints.x = viking.position.x + CGFloat(vikingSpeed) * CGFloat(delta)
            spawnZombie()
        }
        
        for tile in tiles {
            let tileWorldPosition = gamePhysicsNode.convertToWorldSpace(tile.position)
            let tileScreenPosition = convertToNodeSpace(tileWorldPosition)
            if tileScreenPosition.x <= (-tile.contentSize.width) {
                tile.position = ccp(tile.position.x + tile.contentSize.width * 10, tile.position.y)
            }
        }
    }
    
}
