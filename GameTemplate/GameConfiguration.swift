import SpriteKit
import GameplayKit
#if canImport(BillyTempoCasualGamesFramework)
import BillyTempoCasualGamesFramework
#endif
#if canImport(UIKit)
import UIKit
#endif
import CoreGraphics

public enum GameConfiguration {
    enum GameError: Error {
        case sceneCreationFailed
        case entityCreationFailed
    }
    
    // Game settings
    public static let orientation: UIInterfaceOrientationMask = .landscape
    public static let hideStatusBar: Bool = true
    
    // Game object configurations
    private static func createGolfBallConfig() -> BallConfiguration {
        return BallConfiguration(
            radius: 8,
            color: .white,
            id: 1,
            relativeX: 0.1,  // Starting position
            relativeY: 0.5,
            velocity: .zero,  // Ball starts stationary
            components: [
                MovementComponentConfiguration(maxSpeed: 400),
                BounceComponentConfiguration(bounciness: 0.8),
                CollisionComponentConfiguration(
                    collidesWith: 0x1 << 2,  // Collide with walls
                    notifyOnContactBegin: true,
                    notifyOnContactEnd: false
                )
            ]
        )
    }
    
    private static func createCourseWalls() -> [WallConfiguration] {
        return [
            // Course boundary walls
            WallConfiguration(  // Top wall
                relativeWidth: 1.0,
                relativeHeight: 0.03,
                color: .gray,
                relativeX: 0.5,
                relativeY: 0.97,
                components: [
                    CollisionComponentConfiguration(
                        collidesWith: 0x1 << 0,  // Collide with ball
                        notifyOnContactBegin: true,
                        notifyOnContactEnd: false
                    )
                ]
            ),
            WallConfiguration(  // Bottom wall
                relativeWidth: 1.0,
                relativeHeight: 0.03,
                color: .gray,
                relativeX: 0.5,
                relativeY: 0.03,
                components: [
                    CollisionComponentConfiguration(
                        collidesWith: 0x1 << 0,  // Collide with ball
                        notifyOnContactBegin: true,
                        notifyOnContactEnd: false
                    )
                ]
            ),
            WallConfiguration(  // Left wall
                relativeWidth: 0.03,
                relativeHeight: 1.0,
                color: .gray,
                relativeX: 0.03,
                relativeY: 0.5,
                components: [
                    CollisionComponentConfiguration(
                        collidesWith: 0x1 << 0,  // Collide with ball
                        notifyOnContactBegin: true,
                        notifyOnContactEnd: false
                    )
                ]
            ),
            WallConfiguration(  // Right wall
                relativeWidth: 0.03,
                relativeHeight: 1.0,
                color: .gray,
                relativeX: 0.97,
                relativeY: 0.5,
                components: [
                    CollisionComponentConfiguration(
                        collidesWith: 0x1 << 0,  // Collide with ball
                        notifyOnContactBegin: true,
                        notifyOnContactEnd: false
                    )
                ]
            ),
            // Obstacles
            WallConfiguration(  // Center obstacle
                relativeWidth: 0.3,
                relativeHeight: 0.03,
                color: .red,
                relativeX: 0.5,
                relativeY: 0.5,
                components: [
                    CollisionComponentConfiguration(
                        collidesWith: 0x1 << 0,  // Collide with ball
                        notifyOnContactBegin: true,
                        notifyOnContactEnd: false
                    )
                ]
            ),
            // The hole (target)
            WallConfiguration(
                relativeWidth: 0.05,
                relativeHeight: 0.05,
                color: .green,
                relativeX: 0.9,
                relativeY: 0.7,
                components: [
                    CollisionComponentConfiguration(
                        collidesWith: 0x1 << 0,  // Collide with ball
                        notifyOnContactBegin: true,
                        notifyOnContactEnd: false
                    )
                ]
            )
        ]
    }
    
    // Scene configuration
    public static func createSceneConfiguration() -> SceneConfiguration {
        let objects: [any GameObjectConfiguration] = [
            createGolfBallConfig()
        ] + createCourseWalls()
        
        return SceneConfiguration(
            backgroundColor: .black,
            gravity: -2.0,  // Light gravity to make it interesting
            objects: objects,
            debug: DebugSettings(showsFPS: true, showsNodeCount: true, showsPhysics: true),
            view: ViewSettings(ignoresSiblingOrder: true)
        )
    }
    
    // Legacy scene creation method - consider deprecating
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
        let config = createSceneConfiguration()
        scene.configure(with: config)
        
        print("Scene created with size: \(sceneSize)")
        print("Number of nodes in scene: \(scene.children.count)")
        
        return scene
    }
}
