//
//  Viking.swift
//  VikingsAndZombies
//
//  Created by Gagandeep Sawhney on 7/4/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

import Foundation
//creates enum for viking facing side
enum Side {
    case Left, Right
}

class Viking: CCSprite {
    //inits a var to hold the enum value of which side its on
    var side: Side = .Right
    
    func didLoadFromCCB () {
        //self.physicsBody.sensor = true
    }
    
    func left () {
        //sets the viking to face left
        self.scaleX = -0.8
        animationManager.runAnimationsForSequenceNamed("WalkAnimation")
        //corects for the position of the viking when scalling it
        if side != .Left {
            self.position.x = self.position.x + self.contentSizeInPoints.width
            side = .Left
        }
    }
    
    func right () {
        //sets the viking to face right
        self.scaleX = 0.8
        animationManager.runAnimationsForSequenceNamed("WalkAnimation")
        //corects for the position of the viking when scalling it
        if side != .Right {
            self.position.x = self.position.x - self.contentSizeInPoints.width
            side = .Right
        }

    }
    func slash () {
        animationManager.runAnimationsForSequenceNamed("Slash(noJump)Animation")
    }
    func standing () {
        //runs the standing animation when Viking is not moving
        animationManager.runAnimationsForSequenceNamed("StandAnimation")

    }
}
