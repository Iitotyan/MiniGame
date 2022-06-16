//
//  GameScene3.swift
//  MiniGame
//
//  Created by Ryoma on 2022/06/16.
//
import SpriteKit

class GameScene3: SKScene {
override func didMove(to view: SKView) {
let label = SKLabelNode(fontNamed:"AvenirNext-Heavy")
    label.text = "GameScene3"
    label.horizontalAlignmentMode = .center
    label.fontColor = .white
    label.fontSize = 100
    label.position = CGPoint(x:xv/2,y:yv/2)
    self.addChild(label)
    }
    
    
    
override func update(_ currentTime: TimeInterval) {
          
             }
    
override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    nextscene(TitleScene(size: self.size))
    }
    
    
    //シーンの切り替え
func nextscene(_ scene: SKScene){
    let transition = SKTransition.fade(with: SKColor.black, duration:0.25)
        self.view?.presentScene(scene, transition: transition)
    }
}

