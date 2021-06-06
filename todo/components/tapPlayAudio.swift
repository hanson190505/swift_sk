//
//  tapPlayAudio.swift
//  todo
//
//  Created by 张莎 on 2021/6/6.
//

import SwiftUI
import AVFoundation

struct tapPlayAudio: View {
    var h = UIScreen.main.bounds.height
    var w = UIScreen.main.bounds.width
    @State var urlStr:String
    @State var tapPlayer:tapPlayAudioButton
    var body: some View {
        Button(action: {
            print(123)
        }, label: {
            Text("").frame(width: w * tapPlayer.frameWidth, height: h * tapPlayer.frameheight)
        }).border(Color.orange,width: 2)
            .offset(x: w * tapPlayer.offsetX, y: h * tapPlayer.offsetY)
    }
    
    func tapPlay() {
        let url = URL(string: urlStr)
        let playerItem:AVPlayerItem = AVPlayerItem(url: url!)
        let player = AVPlayer(playerItem: playerItem)
        player.play()
    }
}




