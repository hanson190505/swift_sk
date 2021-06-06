//
//  image.swift
//  todo
//
//  Created by 张莎 on 2021/6/2.
//

import SwiftUI
import Kingfisher
import AVFoundation

struct tapPlayAudioButton {
    let frameWidth,frameheight,offsetX,offsetY:CGFloat
    var isShow:Bool = false
    let url:URL
}

let s1 = tapPlayAudioButton(frameWidth: 0.4, frameheight: 0.05, offsetX: 0.1, offsetY: 0.1, url: URL(string:"https://s3.amazonaws.com/kargopolov/kukushka.mp3")!)
let s2 = tapPlayAudioButton(frameWidth: 0.3, frameheight: 0.08, offsetX: 0.1, offsetY: 0.2, url: URL(string:"https://s3.amazonaws.com/kargopolov/kukushka.mp3")!)

struct image: View {
    @State private var username = ""
    @State private var password = ""
    @State var str = "anne"
    let colors: [Color] = [.gray, .red, .orange, .yellow,
                              .green, .blue, .purple, .pink]
       @State  var fgColor: Color = .gray
    
    var p = playAudio()
    var body: some View {
        ZStack(alignment:.top){
            
            KFImage(URL(string: "https://images.pexels.com/photos/6565123/pexels-photo-6565123.jpeg?cs=srgb&dl=pexels-brett-sayles-6565123.jpg&fm=jpg")).resizable().cornerRadius(3.0)
            imageTapRead(CGW: 0.4, CGH: 0.1, offX: 0.1, offY: 0.1, s: "hanson",urlStr:"https://s3.amazonaws.com/kargopolov/kukushka.mp3", p: p)
            tapPlayAudio(urlStr: "", tapPlayer: s1)
            tapPlayAudio(urlStr: "", tapPlayer: s2)
        }
    }
}

struct imageTapRead:View {
    var h = UIScreen.main.bounds.height
    var w = UIScreen.main.bounds.width
    @State var CGW:CGFloat = 0
    @State var CGH:CGFloat = 0
    @State var offX:CGFloat = 0
    @State var offY:CGFloat = 0
    @State var s:String
    @State var urlStr:String
    @State var playStatus:String = ""
    @State var seekTime:CMTime?
    var p:playAudio
    var body: some View {
        Text(s)
        Button(action: {
//            if playStatus.isEmpty{
//                p.urlStr = urlStr
//                p.play()
//                playStatus = "playing"
//            }else if playStatus == "playing"{
//                p.pause()
//                seekTime = p.currentTime()
//                playStatus = "pause"
//            }else if playStatus == "pause"{
//                p.resume(time: seekTime!)
//            }
            print(456)
        }, label: {
            Text("").frame(width: w*CGW, height: h*CGH)
        }).border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: 2).offset(x: w*offX, y: h*offY)
    }
}

class playAudio {
    var player:AVPlayer?
    var playerItem:AVPlayerItem?
    var urlStr:String?
    
    func play() {
        let url = URL(string: urlStr ?? "")
        if url == nil {
            print("url错误")
        }else{
            let playerItem:AVPlayerItem = AVPlayerItem(url: url!)
            player = AVPlayer(playerItem: playerItem)
            player!.play()
        }
    }
    func pause() {
        player = AVPlayer(playerItem: playerItem)
        player!.pause()
    }
    
    func currentTime() -> CMTime {
        player = AVPlayer(playerItem: playerItem)
        return player!.currentTime()
    }
    
    func resume(time:CMTime) {
        player = AVPlayer(playerItem: playerItem)
        player!.seek(to: time)
    }
}

struct image_Previews: PreviewProvider {
    static var previews: some View {
        image()
            .padding(3)
    }
}



class ViewController: UIViewController  {
    
    var player:AVPlayer?
    var playerItem:AVPlayerItem?
    var playButton:UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let url = URL(string: "https://s3.amazonaws.com/kargopolov/kukushka.mp3")
        let playerItem:AVPlayerItem = AVPlayerItem(url: url!)
        player = AVPlayer(playerItem: playerItem)
        
        let playerLayer=AVPlayerLayer(player: player!)
        playerLayer.frame=CGRect(x:0, y:0, width:10, height:50)
        self.view.layer.addSublayer(playerLayer)
        
        playButton = UIButton(type: UIButton.ButtonType.system) as UIButton
        let xPostion:CGFloat = 50
        let yPostion:CGFloat = 100
        let buttonWidth:CGFloat = 150
        let buttonHeight:CGFloat = 45
        
        playButton!.frame = CGRect(x: xPostion, y: yPostion, width: buttonWidth, height: buttonHeight)
        playButton!.backgroundColor = UIColor.lightGray
        playButton!.setTitle("Play", for: UIControl.State.normal)
        playButton!.tintColor = UIColor.black
        playButton!.addTarget(self, action: #selector(self.playButtonTapped(_:)), for: .touchUpInside)
        
        self.view.addSubview(playButton!)
    }
    
    @objc func playButtonTapped(_ sender:UIButton)
    {
        if player?.rate == 0
        {
            player!.play()
            //playButton!.setImage(UIImage(named: "player_control_pause_50px.png"), forState: UIControlState.Normal)
            playButton!.setTitle("Pause", for: UIControl.State.normal)
        } else {
            player!.pause()
            //playButton!.setImage(UIImage(named: "player_control_play_50px.png"), forState: UIControlState.Normal)
            playButton!.setTitle("Play", for: UIControl.State.normal)
        }
    }
    
}
