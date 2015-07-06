//
//  Viking.swift
//  VikingsAndZombies
//
//  Created by Gagandeep Sawhney on 7/4/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

import Foundation
enum Side {
    case Left, Right
}
class Viking: CCSprite {
    var side: Side = .Right
    
    func left() {
        self.scaleX = -1
        animationManager.runAnimationsForSequenceNamed("WalkAnimation")
        if side != .Left {
            self.position.x = self.position.x + self.contentSizeInPoints.width
            side = .Left
        }
    }
    func right(){
        self.scaleX = 1
        animationManager.runAnimationsForSequenceNamed("WalkAnimation")
        if side != .Right {
            self.position.x = self.position.x - self.contentSizeInPoints.width
            side = .Right
        }

    }
    func standing() {
        animationManager.runAnimationsForSequenceNamed("StandAnimation")

    }
}
