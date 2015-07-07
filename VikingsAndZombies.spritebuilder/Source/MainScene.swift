import Foundation

class MainScene: CCNode {
    var tiles: [CCSprite] = [] // creates array for tiles
    var gamePhysicsNode : CCNode! //links physiscs node
    weak var viking: Viking! //links viking sprite from MainScene to code
    var vikingSpeed: Int! = 0 //inits the viking speed as an int and nothing
    func didLoadFromCCB(){
        //addes tiles to array and scene
        for i in 0...10{
            var tile = CCBReader.load("Tile") as! Tile
            tile.position.x = tile.position.x + CGFloat(i) * CGFloat(100)
            gamePhysicsNode.addChild(tile)
            userInteractionEnabled = true //enables user interaction
        }
    }
    override func touchBegan(touch: CCTouch!, withEvent event: CCTouchEvent!) {
        //finds which side of the screen the user touched and animates the viking accordly
        if touch.locationInWorld().x < CCDirector.sharedDirector().viewSize().width / 2 {
            viking.left()
            vikingSpeed = -100
        } else {
            viking.right()
            vikingSpeed = 100
        }
    }
    override func touchEnded(touch: CCTouch!, withEvent event: CCTouchEvent!) {
        //stops viking movement and makes speed 0
        vikingSpeed = 0
        viking.standing()
    }
    override func update(delta: CCTime) {
        //updates viking position
        viking.positionInPoints.x = viking.position.x + CGFloat(vikingSpeed) * CGFloat(delta)
    }
    
}
