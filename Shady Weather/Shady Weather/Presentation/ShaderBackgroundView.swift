//
//  ShaderBackgroundView.swift
//  Shady Weather
//
//  Created by Aleksey Yakushev on 14.11.2023.
//

import SpriteKit
import SwiftUI

//final class WeatherScene: SKScene {
//    @State var temp: Double = 0.0
//    lazy var color = {
//        SKUniform(name: "u_color", vectorFloat4: vector_float4(x: 1, y: 1, z: Float(temp), w: 1))
//    }()
//    
//    init(temp: Double) {
//        self.temp = temp
//        let color = SKUniform(name: "u_color")
//        color.vectorFloat4Value = vector_float4(x: 1, y: 1, z: Float(temp), w: 1)) //Float(temp)*0.5
//        super.init()
//    }
//    
//    override init(size: CGSize) {
//        super.init(size: size)
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}

struct ShaderBackgroundView: View {
    @ObservedObject var weatherVM: WeatherViewModel
    
    var scene: SKScene {
        let scene = SKScene()
        scene.scaleMode = .resizeFill
        let screenSize = UIScreen.main.bounds.size
        let node = SKShapeNode(rect: CGRect(origin: .zero, size: CGSize(width: screenSize.height, height: screenSize.height)))
        let shader = SKShader(fileNamed: "testShader.fsh")
        shader.addUniform(weatherVM.color)
        node.fillShader = shader
        scene.addChild(node)
        return scene
    }
    
    var body: some View {
        SpriteView(scene: self.scene)
            .ignoresSafeArea()
    }
}

