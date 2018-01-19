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
    
    @IBOutlet var recordLabel: WKInterfaceLabel!
    
    @IBAction func record() {
        
        if !recording {
            recording = true
        }
        else {
            recording = false
        }
        
        // Change label
        
    }
    
    var recording: Bool = false

    
    // Set this controller as delegate for crown
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)

        // Configure interface objects here.
    }
    
    // Let crown influence controller
    // Do initial bpm display
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
    }

}

