//
//  GeometryComponent.swift
//  Rollswhere (ReturnTo-GKEntities)
//
//  Created by Marko on 20/06/2018.
//  Copyright © 2018 Marko. All rights reserved.
//

import GameplayKit

class GeometryComponent: GKComponent {
    
    var spriteNode: SKSpriteNode?
    
    init(spriteNode: SKSpriteNode) {
        super.init()
        self.spriteNode = spriteNode  
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}