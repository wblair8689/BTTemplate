import SpriteKit
import GameplayKit
import BillyTempoCasualGamesFramework
import UIKit
import CoreGraphics

public enum PongConfiguration {
    enum GameError: Error {
        case sceneCreationFailed
        case entityCreationFailed
    }
    
    // Game settings
    public static let orientation: UIInterfaceOrientationMask = .landscape
    public static let hideStatusBar: Bool = true
    
    public static func createScene() throws -> GameScene {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else {
            throw GameError.sceneCreationFailed
        }
        
        let screenSize = window.bounds.size
        // Always use the larger dimension as width for landscape
        let sceneSize = CGSize(width: max(screenSize.width, screenSize.height),
                             height: min(screenSize.width, screenSize.height))
        
        let scene = GameScene(size: sceneSize)
        scene.backgroundColor = SKColor.black
        
        // Create and apply scene configuration
        let config = SceneConfiguration(
            size: sceneSize,
            backgroundColor: SKColor.black,
            objects: []  // We'll add objects directly to the scene
        )
        scene.configure(with: config)

        // Instead of creating objects here, use the framework's configuration
        let ballConfig = BallConfiguration(
            radius: 10,
            color: SKColor.red,
            id: 1,
            position: CGPoint(x: sceneSize.width * 0.5, y: sceneSize.height * 0.5),
            velocity: CGVector(dx: 200, dy: 200),
            components: [BounceComponentConfiguration(bounciness: 1.0)]
        )
        scene.createGameObject(from: ballConfig)

        let leftPaddleConfig = PaddleConfiguration(
            size: CGSize(width: 20, height: 60),
            color: SKColor.cyan,
            position: CGPoint(x: sceneSize.width * 0.05, y: sceneSize.height * 0.5),
            components: []
        )
        scene.createGameObject(from: leftPaddleConfig)

        let rightPaddleConfig = PaddleConfiguration(
            size: CGSize(width: 20, height: 60),
            color: SKColor.magenta,
            position: CGPoint(x: sceneSize.width * 0.95, y: sceneSize.height * 0.5),
            components: []
        )
        scene.createGameObject(from: rightPaddleConfig)

        let topWallConfig = WallConfiguration(
            size: CGSize(width: sceneSize.width, height: sceneSize.height * 0.03),
            color: SKColor.darkGray,
            position: CGPoint(x: sceneSize.width * 0.5, y: sceneSize.height),
            components: []
        )
        scene.createGameObject(from: topWallConfig)

        let bottomWallConfig = WallConfiguration(
            size: CGSize(width: sceneSize.width, height: sceneSize.height * 0.03),
            color: SKColor.darkGray,
            position: CGPoint(x: sceneSize.width * 0.5, y: 0),
            components: []
        )
        scene.createGameObject(from: bottomWallConfig)

        print("Scene created with size: \(sceneSize)")
        print("Number of nodes in scene: \(scene.children.count)")
        
        return scene
    }
}
