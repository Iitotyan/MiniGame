//
//  ContentView.swift
//  MiniGame
//
//  Created by Ryoma on 2022/06/15.
//
import SwiftUI
import SpriteKit



struct ContentView: View {
    var body: some View {
        SpriteView(scene: TitleScene())
            .edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
    
    

}
