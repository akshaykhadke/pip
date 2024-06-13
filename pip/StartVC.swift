//
//  StartVC.swift
//  pip
//
//  Created by UTKARSH on 30/05/24.
//

import UIKit
import AVKit

class StartVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        //pip.delegate = self
    }
    
    
    @IBAction func nextBtn_Action(_ sender: Any) {
        videoPlayerVC = nil
        opnePlayer()
        
    }
    
    func opnePlayer()  {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextVC = storyBoard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        nextVC.startVC = self
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
   
    
}

extension AppDelegate : AVPictureInPictureControllerDelegate{
    
    func pictureInPictureControllerDidStopPictureInPicture(_ pictureInPictureController: AVPictureInPictureController) {
        //close()
        print("close")
    }
    
    func pictureInPictureController(_ pictureInPictureController: AVPictureInPictureController,
                                      restoreUserInterfaceForPictureInPictureStopWithCompletionHandler completionHandler: @escaping (Bool) -> Void) {
            let isPipPlaying = (pictureInPictureController.playerLayer.player?.timeControlStatus == .playing)
            if isPipPlaying {
                //play()
            } else {
                //paused()
            }
        
        print("re open")
        //opnePlayer()
        if let vc = (UIApplication.navigationTopViewController() as? ViewController){
            
        }else{
            //self.navigationController?.pushViewController(videoPlayerVC!, animated: true)
            UIApplication.navigationTopViewController()?.navigationController?.pushViewController(videoPlayerVC!, animated: true)
            completionHandler(true)
        }
    }

}

extension UIApplication {
    class func navigationTopViewController() -> UIViewController? {
        let nav = UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController as? UINavigationController
        return  nav?.topViewController
    }
}
