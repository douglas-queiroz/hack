//
//  ViewController.swift
//  Hack
//
//  Created by Douglas Queiroz on 6/20/16.
//  Copyright © 2016 Douglas Queiroz. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer

class ViewController: UIViewController, AVAudioPlayerDelegate {
    
    var audioPlayer: AVAudioPlayer!

    @IBOutlet weak var btnPlay: UIButton!
    @IBOutlet weak var btnStop: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            do {
                try AVAudioSession.sharedInstance().setActive(true)
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        // 
        let commandCenter = MPRemoteCommandCenter.sharedCommandCenter()
        commandCenter.playCommand.enabled = true
        commandCenter.playCommand.addTarget(self, action: #selector(play))
        commandCenter.pauseCommand.addTarget(self, action: #selector(pause))
    }
    
    func playAudio()
    {
        let soundURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("4estacoes", ofType: "mp3")!)
        do
        {
            audioPlayer = try AVAudioPlayer(contentsOfURL: soundURL)
            if (audioPlayer!.prepareToPlay())
            {
                audioPlayer!.play()
            }
        }
        catch
        { }
    }
    
    @IBAction func btnPlayAction(sender: AnyObject) {
        self.play()
    }
    
    @IBAction func btnStopAction(sender: AnyObject) {
        self.stop()
    }
    
    func pause() {
        audioPlayer.pause()
    }
    
    func play() {
        self.playAudio()
        btnPlay.enabled = false
        btnStop.enabled = true
    }
    
    func stop() {
        audioPlayer!.stop()
        btnPlay.enabled = true
        btnStop.enabled = false
    }
}

