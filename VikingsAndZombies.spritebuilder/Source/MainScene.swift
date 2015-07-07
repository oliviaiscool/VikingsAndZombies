import Foundation

class MainScene: CCNode {
    weak var leftMoveLabel: CCLabelTTF!
    weak var rightMoveLabel: CCLabelTTF!
    weak var leftAttackLabel: CCLabelTTF!
    weak var rightAttackLabel: CCLabelTTF!
    var tiles: [CCNode] = [] // creates array for tiles
    var gamePhysicsNode : CCNode! //links physiscs node
    weak var viking: Viking! //links viking sprite from MainScene to code
    var vikingSpeed: Int! = 0 //inits the viking speed as an int and nothing
    func didLoadFromCCB(){
        //addes tiles to array and scene
        for i in 0...10{
            var tile = CCBReader.load("Tile") as! Tile
            tile.position.x = tile.position.x + CGFloat(i) * CGFloat(100)
            tiles.append(tile)
            gamePhysicsNode.addChild(tile)
            userInteractionEnabled = true //enables user interaction
        }
    }
    override func touchBegan(touch: CCTouch!, withEvent event: CCTouchEvent!) {
        //finds which side of the screen the user touched and animates the viking accordly
        if touch.locationInWorld().y < tiles[1].contentSizeInPoints.height * 0.75 {
            if touch.locationInWorld().x < CCDirector.sharedDirector().viewSize().width / 2 {
                viking.left()
                vikingSpeed = -100
                leftMoveLabel.visible = false
            }
            else {
                viking.right()
                vikingSpeed = 100
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
    override func touchEnded(touch: CCTouch!, withEvent event: CCTouchEvent!) {
        //stops viking movement and makes speed 0
        vikingSpeed = 0
        if viking.animationManager.runningSequenceName == "WalkAnimation" {
            viking.standing()
        }
    }
    override func update(delta: CCTime) {
        //updates viking position
        if viking.animationManager.runningSequenceName == "WalkAnimation"{
            viking.positionInPoints.x = viking.position.x + CGFloat(vikingSpeed) * CGFloat(delta)
        }
    }
    
}
