//
//  ShaderBackgroundView.swift
//  Shady Weather
//
//  Created by Aleksey Yakushev on 14.11.2023.
//

import SpriteKit
import SwiftUI

struct ShaderBackgroundView: View {
    var temp: Double
    
    var scene: SKScene {
        let scene = SKScene()
        scene.scaleMode = .resizeFill
        let screenSize = UIScreen.main.bounds.size
        let node = SKShapeNode(rect: CGRect(origin: .zero, size: CGSize(width: screenSize.height, height: screenSize.height)))
        
        let shader = SKShader(fileNamed: "testShader.fsh")
        let color = SKUniform(name: "u_color", vectorFloat4: vector_float4(x: 1, y: Float(temp)*0.5, z: 1.0, w: 1))
        shader.addUniform(color)
        node.fillShader = shader
        scene.addChild(node)
        return scene
    }
    
    var body: some View {
        SpriteView(scene: self.scene)
            .ignoresSafeArea()
    }
}

