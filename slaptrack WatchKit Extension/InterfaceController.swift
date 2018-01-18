//
//  InterfaceController.swift
//  slaptrack WatchKit Extension
//
//  Created by Alexander Schülke on 17.01.18.
//  Copyright © 2018 Alexander Schülke. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    @IBOutlet var bpmButton: WKInterfaceButton!
    @IBAction func record() {
        
        if !recording {
            let timeInterval = Double(60) / currentBpm
            print(timeInterval)
            timer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(self.processTimer), userInfo: nil, repeats: true)
            recording = true
        }
        else {
            timer.invalidate()
            recording = false
        }
    }
    
    var recording: Bool = false
    
    // current bpm can be influenced by digital crown
    var currentBpm: Double = 120
    
    // a limit for choosable bpm so vibration can not get permanent
    let _BPM_CAP: Double = 130
    let _BPM_CAP_LOW: Double = 40
    
    // for display
    let _BPM: String = "B P M"
    let _spinHelper: Double = 9
    
    private var timer = Timer()
    
    //private var player: WKAudioFilePlayer!
    //private var asset: WKAudioFileAsset!
    
    // Set this controller as delegate for crown
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        crownSequencer.delegate = self
        // Configure interface objects here.
    }
    
    // Let crown influence controller
    // Do initial bpm display
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        crownSequencer.focus()
        bpmButton.setTitle("1 2 0  B P M")
        
    }
    
    // To display the current bpm inside the button, the bpm must
    // get converted to a string. Also for design purposes the string should
    // have blank space between each character
    //
    // @param input The number that needs to be formatted
    func formatInt(_ input: Int) -> String{
        let initial = String(input)
        var result = ""
        let blank: Character = " "
        for char in initial {
            result.append(char)
            result.append(blank)
        }
        return result
    }

}

// Implement the protocol methods for the crown
extension InterfaceController: WKCrownDelegate {
    
    
    // Gets called when crown is being spinned.
    // Calculate the new bpm and display it on the button.
    func crownDidRotate(_ crownSequencer: WKCrownSequencer?, rotationalDelta: Double) {
        
        // Add wheel's delta to bpm and accelerate growth
        currentBpm += rotationalDelta * _spinHelper
        // Consider vibration limit
        if currentBpm > _BPM_CAP {
            currentBpm = _BPM_CAP
        }
        else if currentBpm < _BPM_CAP_LOW {
            currentBpm = _BPM_CAP_LOW
        }
        bpmButton.setTitle(formatInt(Int(currentBpm)) + " " +  _BPM)
    }
    
    @objc func processTimer() {
        WKInterfaceDevice.current().play(.failure)
    }
    
    
}
