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

final class ShaderTransitionController: ObservableObject {
    static let shared = ShaderTransitionController()
    
    private let duration: TimeInterval = 2.0
    
    var currentTime: TimeInterval = TimeInterval() {
        didSet {
            transitionTime.floatValue = Float(transitionEndTime - currentTime)
            if transitionTime.floatValue == 0 {
                oldColor.vectorFloat4Value = newColor.vectorFloat4Value
            }
        }
    }
    private var transitionStartTime = TimeInterval()
    private var transitionEndTime = TimeInterval()
    
    @Published var transitionTime = SKUniform(name: "u_transition", float: 0)
    @Published var newColor = SKUniform(name: "new_color", vectorFloat4: vector_float4(0, 0, 1, 0))
    @Published var oldColor = SKUniform(name: "old_color", vectorFloat4: vector_float4(0, 0, 1, 0))
    @Published var windSpeed = SKUniform(name: "u_wind", float: 1)
    
    private init() { }
    
    func startTransition(to color: vector_float4) {
//        oldColor.vectorFloat4Value = newColor.vectorFloat4Value
        newColor.vectorFloat4Value = color
        transitionStartTime = currentTime
        transitionEndTime = transitionStartTime + duration
    }
    
    func setWindSpeed(to speed: Double) {
        windSpeed.floatValue = Float(speed*0.22)
    }
}

final class WeatherShaderScene: SKScene {
    override func update(_ currentTime: TimeInterval) {
        ShaderTransitionController.shared.currentTime = currentTime
        super.update(currentTime)
    }
}

//TODO: Check if currentMediaTime

struct ShaderBackgroundView: View {
    @ObservedObject var controller = ShaderTransitionController.shared
    
    var scene: SKScene {
        let scene = WeatherShaderScene()
        scene.scaleMode = .resizeFill
        let screenSize = UIScreen.main.bounds.size
        let node = SKShapeNode(rect: CGRect(origin: .zero, size: CGSize(width: screenSize.height, height: screenSize.height)))
        let shader = SKShader(fileNamed: "testShader.fsh")
        shader.addUniform(controller.newColor)
        shader.addUniform(controller.oldColor)
        shader.addUniform(controller.transitionTime)
        shader.addUniform(controller.windSpeed)
        node.fillShader = shader
        scene.addChild(node)
        return scene
    }
    
    var body: some View {
        SpriteView(scene: self.scene)
            .ignoresSafeArea()
    }
}

