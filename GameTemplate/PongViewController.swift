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
        return PongConfiguration.createSceneConfiguration()
    }
    
    static var orientation: UIInterfaceOrientationMask {
        return PongConfiguration.orientation
    }
}
