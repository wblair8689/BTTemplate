# BillyTempo Casual Games Framework Usage Guide

## Overview
The BillyTempo Casual Games Framework is designed to simplify the creation of casual games using SpriteKit and GameplayKit. This guide will walk you through the key components of the framework, how to configure game objects with physics and movement, and how to assemble these components into a configuration file similar to `PongConfiguration.swift`.

## Key Components

### GameScene
- **Description**: Base scene class that handles setup and updates.
- **Properties**:
  - `entityManager`: `EntityManager` - Manages entities within the scene.
  - `componentSystems`: `[GKComponentSystem<GKComponent>]` - Array of component systems for managing game logic.
  - `sceneConfig`: `SceneConfiguration?` - Configuration for the scene properties.

### GameObjectConfiguration
- **Description**: Protocol for defining game object properties and components.
- **Key Properties**:
  - `position`: `CGPoint` - The position of the object in the scene.
  - `components`: `[ComponentConfiguration]` - Array of component configurations for the object.
  - `type`: `String` - A string representing the object type.

### BallConfiguration
- **Description**: Configuration for creating a ball object.
- **Key Properties**:
  - `radius`: `CGFloat` - The radius of the ball.
    - **Constraints**: Minimum 5, Maximum 20, Default 10
  - `color`: `SKColor` - The color of the ball.
  - `id`: `Int` - A unique identifier for the ball.
  - `velocity`: `CGVector` - The initial velocity of the ball.
    - **Constraints**: Minimum 100, Maximum 500, Default `CGVector(dx: 200, dy: 200)`

### PaddleConfiguration
- **Description**: Configuration for creating a paddle object.
- **Key Properties**:
  - `size`: `CGSize` - The size of the paddle.
    - **Width Constraints**: Minimum 10, Maximum 30, Default 20
    - **Height Constraints**: Minimum 40, Maximum 100, Default 60
  - `color`: `SKColor` - The color of the paddle.
  - `speed`: `CGFloat` - The speed of the paddle.
    - **Constraints**: Minimum 100, Maximum 500, Default 200

### WallConfiguration
- **Description**: Configuration for creating a wall object.
- **Key Properties**:
  - `size`: `CGSize` - The size of the wall.
    - **Width Constraints**: Minimum 10, Default 20
    - **Height Constraints**: Minimum 50, Default 200
  - `color`: `SKColor` - The color of the wall.

## Creating Game Objects with Physics and Movement

### Physics Components
- **CollisionComponent**: Manages physics collisions between objects.
  - **Properties**:
    - `collidesWith`: `UInt32` - Bitmask indicating which categories this object collides with.
    - `notifyOnContactBegin`: `Bool` - Boolean indicating if contact notifications are enabled.

### Movement Components
- **MovementComponent**: Handles object movement and velocity.
  - **Properties**:
    - `maxSpeed`: `CGFloat` - Maximum speed of the object.
    - `rotationSpeed`: `CGFloat` - Speed at which the object can rotate.

## Assembling a Configuration File
To create a configuration file like `PongConfiguration.swift`, follow these steps:

1. **Import Necessary Modules**
   ```swift
   import SpriteKit
   import GameplayKit
   import BillyTempoCasualGamesFramework
   ```

2. **Define Game Settings**
   Set properties such as orientation and status bar visibility.

3. **Create Scene Configuration**
   Define the scene size and background color.

4. **Configure Game Objects**
   Use the configuration structures to define balls, paddles, and walls with their respective properties.

5. **Instantiate Game Objects**
   Use the `createGameObject(from config:)` method to add objects to the scene.

6. **Finalize Scene Setup**
   Print debug information and return the configured scene.

By following this guide, you can effectively utilize the BillyTempo Casual Games Framework to create engaging and interactive casual games.
