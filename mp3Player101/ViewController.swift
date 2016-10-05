//
//  ViewController.swift
//  mp3Player101
//
//  Created by iOS Student on 10/3/16.
//  Copyright © 2016 iOS Student. All rights reserved.
//

import UIKit
import AVFoundation
class ViewController: UIViewController, AVAudioPlayerDelegate {

    @IBOutlet weak var btn_Play: UIButton!
    
    @IBOutlet weak var lbl_TimeTotal: UILabel!
    @IBOutlet weak var lbl_TimeLeft: UILabel!
    var audio = AVAudioPlayer()
    var Playing = true
    @IBOutlet weak var sld_Volume: UISlider!
    @IBOutlet weak var sld_Duration: UISlider!
    
    @IBOutlet weak var switch_RepeatOrNot: UISwitch!
    var repeat101: Bool!
    override func viewDidLoad() {
        super.viewDidLoad()
        audio = try! AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: Bundle.main.path(forResource: "music",ofType: ".mp3")!) as URL)
        audio.prepareToPlay()
        addThumbImgForSlider()
        repeat101 = true
        
        audio.currentTime = 0
    
        audio.delegate = self
        audio.numberOfLoops =  -1

        let timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimeLeft), userInfo: nil, repeats: true)
        
        
        let timer2 = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimeTotal), userInfo: nil, repeats: false)

        
        self.sld_Duration.value = Float(audio.currentTime/audio.duration)
        
    }
    func updateTimeLeft()
    {
        self.lbl_TimeLeft.text = String(format: "%2.2f",audio.currentTime/60)
        self.sld_Duration.value = Float(audio.currentTime/audio.duration)
        
           }

    func updateTimeTotal()
    {
        self.lbl_TimeTotal.text = String(format: "%2.2f",audio.duration/60 )
    }


    func addThumbImgForSlider()
    {
        sld_Volume.setThumbImage(UIImage(named: "thumb.png"), for: .normal)
        sld_Volume.setThumbImage(UIImage(named: "thumbHightLight.png"), for: .highlighted)
    }
  
    @IBAction func sld_Volume(_ sender: UISlider) {
        audio.volume = sender.value
    }

    @IBAction func sld_WhenToPlay(_ sender: UISlider) {
     audio.currentTime = TimeInterval(sender.value) * audio.duration
        print(sender.value)
    }

    
    
    @IBAction func switch_RepeatOrNot(_ sender: AnyObject) {
        
        if (repeat101 == true){
            audio.numberOfLoops =  0
           repeat101 = false
        }
        else
        {
            audio.numberOfLoops =  -1
            repeat101 = true
        }
        
    }
    
  

    @IBAction func action_Play(_ sender: AnyObject) {
        if (Playing == true)
        {
        audio.play()
            btn_Play.setImage(UIImage(named: "pause.png"), for: UIControlState())
            Playing = true
        }
        else{
            audio.pause()
            btn_Play.setImage(UIImage(named: "play.png"), for: UIControlState())
            Playing = false
        }
        Playing = !Playing
    }
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if (repeat101 == false)
        {
            btn_Play.setImage(UIImage(named: "play.png"), for: UIControlState())
            Playing = true
        }
        }
    
}



