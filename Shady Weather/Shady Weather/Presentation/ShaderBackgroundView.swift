//
//  ShaderBackgroundView.swift
//  Shady Weather
//
//  Created by Aleksey Yakushev on 14.11.2023.
//

import SpriteKit
import SwiftUI

struct ShaderBackgroundView: View {
    var scene: SKScene {
        let scene = SKScene(size: CGSize(width: 500, height: 500))
        scene.scaleMode = .fill
        let node = SKShapeNode(rect: scene.frame)
        
        let shader = SKShader(fileNamed: "testShader.fsh")
//        let shader = SKShader(fileNamed: "abstract_background.fsh")
        let color = SKUniform(name: "u_color", vectorFloat4: vector_float4(x: 1, y: 0, z: 0.5, w: 1))
        shader.addUniform(color)

        node.fillShader = shader
        
        scene.addChild(node)
        
        return scene
    }
    
    var body: some View {
        SpriteView(scene: self.scene)
            .frame(width: 500, height: 500)
            .ignoresSafeArea()
    }
}

