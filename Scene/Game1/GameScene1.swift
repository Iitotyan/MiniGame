//
//  GameScene.swift
//  MiniGame
//
//  Created by Ryoma on 2022/06/15.
//
import SpriteKit

class GameScene1: SKScene, SKPhysicsContactDelegate {
    //カテゴリビットマスク
let wallCategory:UInt32        =  0x1 << 0   //壁
let playerCarCategory:UInt32   =  0x1 << 1   //プレイヤーカー
let otherCarCategory:UInt32    =  0x1 << 2   //その他の車
var distance: CGFloat = 0.0
var carStartPt = CGPoint.zero
var gameOver = false
var acceleON = false
var accelete: CGFloat = 0.0
var particleSpark: SKEmitterNode?
    //何枚の画像をつなげるか
let numberOfRoad = 3
    // プレイヤーの初期位置
let playerOffsetY = yv/2+yv/28+yv/12
var gamestart = false
override func didMove(to view: SKView) {
    /*
var cam: SKCameraNode?
    cam = SKCameraNode()
    cam!.position = CGPoint(x: xv/2, y: yv/2)
    cam!.name = "Camera"
    cam!.setScale(2)
    self.camera = cam
    self.addChild(cam!)
     */
    gamestart = false
    self.physicsWorld.gravity = CGVector(dx:0.0,dy:-30.0)
    self.physicsWorld.contactDelegate = self
    addlabel("距離","0",xv/7,yv/50*45,xv/18)
    addlabel("","DistLabel",xv/7*2,yv/50*45,xv/18)
    addlabel("スピード","0",xv/7*4,yv/50*45,xv/18)
    addlabel("","Speed",xv/7*6,yv/50*45,xv/18)
    addlabel("","label",xv/2,yv/2.3,xv/40*13)
    //道路
let roadNode: SKNode = SKNode()
    roadNode.name = "Road"
    self.addChild(roadNode)
let XRange = SKRange(lowerLimit:-xv*(CGFloat(numberOfRoad)-0.5),upperLimit:xv*4)
let xconst = SKConstraint.positionX(XRange)
    roadNode.constraints = [xconst]
        // road
for i in 0 ..< numberOfRoad {
let road = SKSpriteNode(imageNamed: "lord.png")
    road.size = CGSize(width:xv,height:yv/7)
    road.name = "RoadView"
    road.position = CGPoint(x:xv/2+(xv*CGFloat(i)),y:yv/2)
    road.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width:xv,height:road.size.height/4))
    road.physicsBody!.isDynamic = false
    road.physicsBody!.affectedByGravity = false
    roadNode.addChild(road)
if i == 0 {
let node: SKSpriteNode = SKSpriteNode(texture: nil,color: .yellow,size:CGSize(width: 100,height:road.size.height))
    node.name = "RoadView"
    node.position = CGPoint(x: xv*1.22,y:yv/2)
    node.zPosition = 2
    roadNode.addChild(node)
    }
}
        //プレイヤーカー
let playerCar = SKSpriteNode(imageNamed: "car_01.png")
    playerCar.name = "PlayerCar"
    playerCar.zPosition = 3
    playerCar.size = CGSize(width:xv/8,height:yv/6)
    roadNode.addChild(playerCar)
    playerCar.position = CGPoint(x:-xv/3,y:yv/2+yv/56+yv/12)
    carStartPt = CGPoint(x:xv/4,y:yv/2+yv/28)
let move = SKAction.moveTo(x:xv/4, duration: 3)
    playerCar.run(move, completion: { [self]() -> Void in
        self.countdown()
    playerCar.physicsBody = SKPhysicsBody(rectangleOf: playerCar.size)
    playerCar.physicsBody?.categoryBitMask = self.playerCarCategory
    playerCar.physicsBody?.collisionBitMask = wallCategory|otherCarCategory
    playerCar.physicsBody?.contactTestBitMask = wallCategory|otherCarCategory
    })
let sea = SKShapeNode(rectOf:CGSize(width:xv+50,height:yv/2.3+20))
    sea.position = CGPoint(x:xv/2,y:yv/4.6)
    sea.fillColor = .blue
    sea.strokeColor = .white
    sea.alpha = 0.8
    sea.zPosition = 6.0
    sea.lineWidth = 6.0
    sea.name = "Sea"
    self.addChild(sea)
    }

   
override func didSimulatePhysics() {
if gamestart {
let road: SKNode = self.childNode(withName: "Road")!
let playerCar: SKSpriteNode = ((road.childNode(withName: "PlayerCar") as? SKSpriteNode)!)
if playerCar.position.x > xv*4+xv/2 {
   showGameOver()
    }
  
//プレイヤーカーの回転角からベクトルを求める
let x: CGFloat = sin(playerCar.zRotation-(90))
    if acceleON { //加速
        accelete += 80
    if accelete > 1400 {
        accelete = 1400
            }
        } else {
        accelete -= 6
        if accelete < 0 {
            if !acceleON {
                particleSpark?.removeFromParent()
            }
            accelete = 0
        let gl = road.position.x+road.position.x
            if gl < xv*3-xv/2 {
                gameclear()
            }
            print(road.position.x,xv*3-xv/2)
           
            }
        }
    //ベクトルを加える
    playerCar.physicsBody!.velocity = CGVector(dx:-accelete * x,dy:-50)
    //プレイヤーカーの位置に合わせてオートスクロール
let pt = self.convert(playerCar.position,from: road)
    if !gameOver {
        road.position = CGPoint(x:road.position.x-pt.x+carStartPt.x,y:0)
    }
   if playerCar.position.y < yv/1.8 {
        showGameOver()
    }
        //走行距離
self.distance = (playerCar.position.x-carStartPt.x)/100
let dist = ((self.childNode(withName: "DistLabel") as? SKLabelNode)!)
    dist.text = String(format: "%.0f m", self.distance)
        // スピード表示
let speedLabel: SKLabelNode = ((self.childNode(withName: "Speed") as? SKLabelNode)!)
    speedLabel.text = String(format: "%.0f km/h", accelete)
   }
}
//アクセルの状態
func acceleteupdate(){
if acceleON {  //加速
    accelete += 30
if accelete > 1400 {
    accelete = 1400
            }
    }
}
//タッチ開始
override func touchesBegan(_ touches: Set<UITouch>,  with event: UIEvent?) {
    if gameOver {
        gameOver = false
        next(GameScene1(size:self.size))
        } else {
        acceleON = false
    }
}
//衝突
func didBegin(_ contact: SKPhysicsContact) {
let bodyNameB: String = contact.bodyB.node!.name!
if bodyNameB.isEqual("PlayerCar") {
let road: SKNode = self.childNode(withName: "Road")!
let pt = self.convert(contact.contactPoint, to: road)
if accelete > 0 {
if !acceleON { self.makeSparkParticle(pt) }
        }
    }
}
//スパークパーティクル作成
func makeSparkParticle(_ point: CGPoint) {
if particleSpark == nil {
let road: SKNode = self.childNode(withName: "Road")!
        do {
let fileURL = Bundle.main.url(forResource: "Spark", withExtension: "sks")!
let fileData = try Data(contentsOf: fileURL)
    particleSpark = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(fileData) as? SKEmitterNode
            } catch {
                print("didn't work")
            }
    particleSpark!.numParticlesToEmit = 100
    particleSpark!.zPosition = 10
        road.addChild(particleSpark!)
        } else {
    particleSpark!.resetSimulation()
        }
    particleSpark!.position = point
}
//ゲームオーバー
func showGameOver() {
    if gameOver == false {
let road: SKNode = self.childNode(withName: "Road")!
let reacingCar: SKSpriteNode = ((road.childNode(withName: "PlayerCar") as? SKSpriteNode)!)
   // self.physicsWorld.speed = 0
    reacingCar.physicsBody!.velocity = CGVector(dx:0,dy:-5750)
        //物理シミュレーション停止
    gameOver = true
    //ゲームオーバー
addlabel("GAME OVER","",xv/2,yv/1.6,xv/14)
    }
}
    

func gameclear(){
    addlabel("ゲームクリア!","",xv/2,yv/1.6,xv/14)
let wait = SKAction.wait(forDuration: 1)
    self.run(wait,completion: {() -> Void in
        self.next(TitleScene(size:self.size))
    })
}
//カウントダウン
func countdown(){
let wait = SKAction.wait(forDuration: 1)
let label = ((self.childNode(withName: "label") as? SKLabelNode)!)
    self.run(wait){
             label.text = "3"
        self.run(wait){
                 label.text = "2"
            self.run(wait){
                     label.text = "1"
                self.run(wait){
                    label.text = ""
                    self.gamestart = true
                    self.acceleON = true
                }
            }
        }
    }
}
//ラベル
func addlabel(_ text:String,_ name:String,_ x:CGFloat,_ y:CGFloat,_ size:CGFloat){
let label = SKLabelNode(fontNamed: "Baskerville-Bold")
    label.name = name
    label.text = text
    label.fontSize = size
    label.fontColor = .white
    label.zPosition = 2
    label.position.x = x
    label.position.y = y
        self.addChild(label)
}
    
func next(_ scene: SKScene){
let transition = SKTransition.fade(with: SKColor.black, duration:0.25)
    self.view?.presentScene(scene, transition: transition)
}
}
