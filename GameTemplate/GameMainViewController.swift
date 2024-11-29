import UIKit
import SpriteKit
import GameplayKit
import BillyTempoCasualGamesFramework

final class GameMainViewController: GameViewController<GameMain> {
    override func viewDidLoad() {
        super.viewDidLoad()
        print("GameMainViewController: viewDidLoad")
    }
}

enum GameMain: GameSceneConfigurable {
    static func createSceneConfiguration() throws -> SceneConfiguration {
        return GameConfiguration.createSceneConfiguration()
    }
    
    static var orientation: UIInterfaceOrientationMask {
        return GameConfiguration.orientation
    }
}
