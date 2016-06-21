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
    }
    
    func playAudio()
    {
        let soundURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("4estacoes", ofType: "mp3")!)
        do
        {
            audioPlayer = try AVAudioPlayer(contentsOfURL: soundURL)
            audioPlayer!.delegate = self
            if (audioPlayer!.prepareToPlay())
            {
                audioPlayer!.play()
            }
        }
        catch
        { }
    }
    
    @IBAction func btnPlayAction(sender: AnyObject) {
        UIApplication.sharedApplication().beginReceivingRemoteControlEvents()
        let commandCenter = MPRemoteCommandCenter.sharedCommandCenter()
        commandCenter.playCommand.enabled = true
        commandCenter.stopCommand.enabled = true
        commandCenter.playCommand.addTarget(self, action: #selector(play))
        commandCenter.stopCommand.addTarget(self, action: #selector(stop))
        
        self.play()
    }
    
    @IBAction func btnStopAction(sender: AnyObject) {
        self.stop()
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

