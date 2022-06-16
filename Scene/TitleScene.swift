//
//  TitleScene.swift
//  MiniGame
//
//  Created by Ryoma on 2022/06/16.
//
import SpriteKit

class TitleScene: SKScene {
var btncount = 1
    
override func didMove(to view: SKView) {
let label = SKLabelNode(fontNamed:"AvenirNext-Heavy")
    label.text = "ミニゲーム"
    label.horizontalAlignmentMode = .center
    label.fontColor = .white
    label.fontSize = 100
    label.position = CGPoint(x:xv/2,y:yv/40*28)
    self.addChild(label)
    for _ in 1...4 {
    createbutton()
    }
}
    

func createbutton(){
let btnframe = SKShapeNode(rect:CGRect(x: 0, y:0,width:xv/40*14,height:xv/40*3),cornerRadius: 20)
    btnframe.name = "\(btncount)"
    btnframe.position = CGPoint(x:xv/2-xv/40*7,y:yv/2-((yv/40*4)*CGFloat(btncount)))
    self.addChild(btnframe)
let btnlabel = SKLabelNode(fontNamed:"AvenirNext-Heavy")
    btnlabel.text = "ゲーム\(btncount)"
    btnlabel.horizontalAlignmentMode = .center
    btnlabel.position = CGPoint(x: xv/40*7,y:xv/40*0.5)
    btnlabel.fontSize = xv/40*2.0
    btnlabel.name = "\(btncount)"
    btnframe.addChild(btnlabel)
    btncount += 1
    }
    
override func update(_ currentTime: TimeInterval) {
          
             }
    
    // タッチしたときの処理
override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
for touch: AnyObject in touches {
let location = touch.location(in: self)
let touchedNode = self.atPoint(location)
if touchedNode.name != nil {
    switch self.atPoint(location).name {
case "1": nextscene(GameScene1(size:self.size))
case "2": nextscene(GameScene2(size:self.size))
case "3": nextscene(GameScene3(size:self.size))
case "4": nextscene(GameScene4(size:self.size))
    default: return
            }
        }
    }
}

//シーンの切り替え
func nextscene(_ scene: SKScene){
let transition = SKTransition.fade(with: SKColor.black, duration:0.25)
    self.view?.presentScene(scene, transition: transition)
}


override func sceneDidLoad() {
self.scaleMode = .resizeFill
        }
}

