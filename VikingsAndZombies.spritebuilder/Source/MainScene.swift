import Foundation

class MainScene: CCNode {
    var tiles: [CCSprite] = []
    var gamePhysicsNode : CCNode!
    weak var viking: Viking!
    var vikingSpeed: Int! = 0
    func didLoadFromCCB(){
        for i in 0...10{
            var tile = CCBReader.load("Tile") as! Tile
            tile.position.x = tile.position.x + CGFloat(i) * CGFloat(100)
            gamePhysicsNode.addChild(tile)
            userInteractionEnabled = true
        }
    }
    override func touchBegan(touch: CCTouch!, withEvent event: CCTouchEvent!) {
        if touch.locationInWorld().x < CCDirector.sharedDirector().viewSize().width / 2 {
            viking.left()
            vikingSpeed = -100
        } else {
            viking.right()
            vikingSpeed = 100
        }
    }
    override func touchEnded(touch: CCTouch!, withEvent event: CCTouchEvent!) {
        vikingSpeed = 0
        viking.standing()
    }
    override func update(delta: CCTime) {
        viking.positionInPoints.x = viking.position.x + CGFloat(vikingSpeed) * CGFloat(delta)
    }
    
}
