# BillyTempo Casual Games Framework Usage Guide

## Overview
The BillyTempo Casual Games Framework is designed to simplify the creation of casual games using SpriteKit and GameplayKit. 
The games don't have timers or levels or points
This guide will walk you through the key components of the framework and how to configure your game.

## Key Components

### Scene Configuration
- **SceneConfiguration**: Main configuration for your game scene
  - `size`: `CGSize` - Scene dimensions (defaults to screen size if not specified)
  - `backgroundColor`: `SKColor` - Scene background color
  - `gravity`: `CGFloat` - Scene gravity value (0 for no gravity)
  - `objects`: `[GameObjectConfiguration]` - Array of game objects
  - `debug`: `DebugSettings` - Debug visualization options
  - `view`: `ViewSettings` - Scene view settings

### Debug Settings
- `showsFPS`: `Bool` - Display FPS counter
- `showsNodeCount`: `Bool` - Display node count
- `showsPhysics`: `Bool` - Show physics bodies

### Game Objects
All game objects implement the `GameObjectConfiguration` protocol:
- `position`: `CGPoint` - Object position in scene (automatically calculated from relative coordinates)
- `components`: `[ComponentConfiguration]` - Object components
- `type`: `String` - Object type identifier (used for collision detection)

#### Available Game Objects:

1. **BallConfiguration**
   ```swift
   BallConfiguration(
       radius: CGFloat = 10,
       color: SKColor = .white,
       id: Int = 1,
       relativeX: CGFloat,  // 0.0 to 1.0
       relativeY: CGFloat,  // 0.0 to 1.0
       velocity: CGVector = CGVector(dx: 300, dy: 300),
       components: [ComponentConfiguration] = []
   )
   ```

2. **PaddleConfiguration**
   ```swift
   PaddleConfiguration(
       width: CGFloat = 20,
       height: CGFloat = 100,
       color: SKColor = .white,
       relativeX: CGFloat,  // 0.0 to 1.0
       relativeY: CGFloat,  // 0.0 to 1.0
       components: [ComponentConfiguration] = []
   )
   ```

3. **WallConfiguration**
   ```swift
   WallConfiguration(
       relativeWidth: CGFloat = 1.0,  // 0.0 to 1.0
       relativeHeight: CGFloat = 0.03,  // 0.0 to 1.0
       color: SKColor = .clear,
       relativeX: CGFloat,  // 0.0 to 1.0
       relativeY: CGFloat,  // 0.0 to 1.0
       components: [ComponentConfiguration] = []
   )
   ```

### Components
Components add behavior to game objects. Components can be combined to create complex behaviors.

1. **BounceComponent**
   ```swift
   BounceComponentConfiguration(
       bounciness: CGFloat = 1.0  // 1.0 means perfect bounce
   )
   ```
   Used for objects that should bounce off surfaces. Commonly combined with CollisionComponent.

2. **CollisionComponent**
   ```swift
   CollisionComponentConfiguration(
       collidesWith: UInt32,  // Bitmask of collision categories
       notifyOnContactBegin: Bool = true,
       notifyOnContactEnd: Bool = false
   )
   ```
   Handles physics collisions between objects. Common category values:
   - `.ball`: 0x1 << 0
   - `.paddle`: 0x1 << 1
   - `.wall`: 0x1 << 2

3. **MovementComponent**
   ```swift
   MovementComponentConfiguration(
       maxSpeed: CGFloat = 500.0,
       rotationSpeed: CGFloat = .pi  // Radians per second
   )
   ```
   Controls object movement. Often used with CollisionComponent for physics-based movement.

## Creating and Starting a Game

1. **Create a Configuration Enum**
   ```swift
   import SpriteKit
   import GameplayKit
   import BillyTempoCasualGamesFramework
   
   public enum GameConfiguration {
       // Game settings
       public static let orientation: UIInterfaceOrientationMask = .landscape
       public static let hideStatusBar: Bool = true
       
       // Scene configuration
       public static func createSceneConfiguration() -> SceneConfiguration {
           let objects: [any GameObjectConfiguration] = [
               // Add your game objects here
           ]
           
           return SceneConfiguration(
               backgroundColor: .black,
               gravity: 0,
               objects: objects,
               debug: DebugSettings(
                   showsFPS: true,
                   showsNodeCount: true,
                   showsPhysics: true
               ),
               view: ViewSettings(
                   ignoresSiblingOrder: true
               )
           )
       }
   }
   ```

2. **Create and Present the Scene**
   ```swift
   class GameViewController: UIViewController {
       override func viewDidLoad() {
           super.viewDidLoad()
           
           do {
               // Create scene with configuration
               let config = GameConfiguration.createSceneConfiguration()
               let scene = GameScene(size: config.size)
               scene.configure(with: config)
               
               // Configure view
               if let view = self.view as? SKView {
                   view.presentScene(scene)
               }
           } catch {
               print("Failed to create scene: \(error)")
           }
       }
   }
   ```

3. **Position Objects Using Relative Coordinates**
   - Use relative coordinates (0.0 to 1.0) for positioning
   - The framework automatically converts to screen coordinates
   - Example: `relativeX: 0.5, relativeY: 0.5` positions at screen center

4. **Add Components**
   ```swift
   // Example: Ball with physics and movement
   BallConfiguration(
       relativeX: 0.5,
       relativeY: 0.5,
       components: [
           MovementComponentConfiguration(maxSpeed: 300),
           CollisionComponentConfiguration(
               collidesWith: 0x1 << 1 | 0x1 << 2  // Collides with paddles and walls
           ),
           BounceComponentConfiguration(bounciness: 1.0)
       ]
   )
   ```

## Best Practices

1. **Object Positioning**
   - Use relative coordinates for consistent positioning across devices
   - Keep game objects within the 0.0 to 1.0 range
   - Test on different screen sizes

2. **Component Usage**
   - Add only necessary components to objects
   - Configure component parameters based on gameplay requirements
   - Common combinations:
     - Movement + Collision for physics-based objects
     - Bounce + Collision for bouncing objects
     - Collision only for static barriers

3. **Debug Settings**
   - Enable debug visualization during development
   - Disable for production releases
   - Use physics visualization to verify collision shapes

4. **Scene Configuration**
   - Set appropriate gravity for your game type (0 for top-down games)
   - Configure view settings based on rendering needs
   - Consider memory usage when setting node counts

For a complete example, refer to the Pong game implementation in the Examples directory.
