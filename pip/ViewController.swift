//
//  ViewController.swift
//  pip
//
//  Created by Vipin on 06/10/21.
//http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4

import UIKit
import AVKit
var pip : AVPictureInPictureController!
var videoPlayerVC: ViewController?
class ViewController: UIViewController {
    @IBOutlet weak var playerView: UIView! // custom player
    
    var startVC : StartVC?
    var player : AVPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if pip == nil{
            setupCustomPlayer()
        }else{
            if player != nil{
                player?.play()
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if pip.isPictureInPictureActive == false{
            player?.pause()
            player = nil
            pip = nil
        }
    }
    
    //MARK:default player PIP avplayer controller
    private func startPlayVideo(){
        if let url = URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4") {
            let player = AVPlayer(url: url)
            let playerController = AVPlayerViewController()
            playerController.player = player
            self.present(playerController, animated: true) {
              player.play()
            }
        }else{
            print("Invalid Url..")
        }
    }

    @IBAction func startVideo(_ sender: Any) {
        //startPlayVideo()
        pip.startPictureInPicture()
        //setupCustomPlayer()
    }
    
    @IBAction func backBtn_Action(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func playBtn_Action(_ sender: Any) {
        if player != nil{
            player?.play()
        }
    }
    
    
    private func setupCustomPlayer(){
        if let url = URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4") {
            
             player = AVPlayer(url: url)
                
            let playerLayer = AVPlayerLayer(player: player)
                
            playerLayer.frame = self.playerView.bounds
            playerLayer.videoGravity = .resizeAspectFill
            playerView.layer.addSublayer(playerLayer)
            
            pip = AVPictureInPictureController(playerLayer: playerLayer)
            //pip.delegate = startVC
            pip.delegate = UIApplication.shared.delegate as! AppDelegate
            self.player?.play()
            videoPlayerVC = self
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}

