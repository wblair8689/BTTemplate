import UIKit
import SpriteKit
import GameplayKit
import BillyTempoCasualGamesFramework

final class PongViewController: GameViewController<PongGame> {
    override func viewDidLoad() {
        super.viewDidLoad()
        print("PongViewController: viewDidLoad")
    }
}

enum PongGame: GameSceneConfigurable {
    static func createSceneConfiguration() throws -> SceneConfiguration {
        let screenSize = UIScreen.main.bounds.size
        
        // Create paddle configurations
        let leftPaddleConfig = PaddleConfiguration(
            size: CGSize(width: 20, height: 100),
            color: .white,
            position: CGPoint(x: 50, y: screenSize.height/2)
        )
        
        let rightPaddleConfig = PaddleConfiguration(
            size: CGSize(width: 20, height: 100),
            color: .white,
            position: CGPoint(x: screenSize.width - 50, y: screenSize.height/2)
        )
        
        // Create ball configuration
        let ballConfig = BallConfiguration(
            radius: 10,
            color: .white,
            id: 1,
            position: CGPoint(x: screenSize.width/2, y: screenSize.height/2),
            velocity: CGVector(dx: 300, dy: 300),
            components: [MovementComponentConfiguration()]
        )
        
        // Create wall configurations
        let topWallConfig = WallConfiguration(
            size: CGSize(width: screenSize.width, height: 20),
            color: .clear,
            position: CGPoint(x: screenSize.width/2, y: screenSize.height - 10)
        )
        
        let bottomWallConfig = WallConfiguration(
            size: CGSize(width: screenSize.width, height: 20),
            color: .clear,
            position: CGPoint(x: screenSize.width/2, y: 10)
        )
        
        return SceneConfiguration(
            size: screenSize,
            backgroundColor: .black,
            gravity: 0,
            objects: [leftPaddleConfig, rightPaddleConfig, ballConfig, topWallConfig, bottomWallConfig],
            debug: DebugSettings(showsFPS: true, showsNodeCount: true, showsPhysics: true),
            view: ViewSettings(ignoresSiblingOrder: true)
        )
    }
    
    static var orientation: UIInterfaceOrientationMask {
        return .landscape
    }
}
