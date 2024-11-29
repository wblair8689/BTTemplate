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
    private static func createLeftPaddleConfig() -> PaddleConfiguration {
        return PaddleConfiguration(
            width: 20,
            height: 100,
            color: .white,
            relativeX: 0.05,
            relativeY: 0.5,
            components: []
        )
    }
    
    private static func createRightPaddleConfig() -> PaddleConfiguration {
        return PaddleConfiguration(
            width: 20,
            height: 100,
            color: .white,
            relativeX: 0.95,
            relativeY: 0.5,
            components: []
        )
    }
    
    private static func createBallConfig() -> BallConfiguration {
        return BallConfiguration(
            radius: 10,
            color: .white,
            id: 1,
            relativeX: 0.5,
            relativeY: 0.5,
            velocity: CGVector(dx: 300, dy: 300),
            components: [MovementComponentConfiguration()]
        )
    }
    
    private static func createTopWallConfig() -> WallConfiguration {
        return WallConfiguration(
            relativeWidth: 1.0,
            relativeHeight: 0.03,
            color: .clear,
            relativeX: 0.5,
            relativeY: 0.97,
            components: []
        )
    }
    
    private static func createBottomWallConfig() -> WallConfiguration {
        return WallConfiguration(
            relativeWidth: 1.0,
            relativeHeight: 0.03,
            color: .clear,
            relativeX: 0.5,
            relativeY: 0.03,
            components: []
        )
    }
    
    // Scene configuration
    public static func createSceneConfiguration() -> SceneConfiguration {
        let objects: [any GameObjectConfiguration] = [
            createLeftPaddleConfig(),
            createRightPaddleConfig(),
            createBallConfig(),
            createTopWallConfig(),
            createBottomWallConfig()
        ]
        
        return SceneConfiguration(
            backgroundColor: .black,
            gravity: 0,
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
