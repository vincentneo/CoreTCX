//
//  ViewController.swift
//  CoreTCX
//
//  Created by vincentneo on 08/24/2019.
//  Copyright (c) 2019 vincentneo. All rights reserved.
//

import UIKit
import CoreTCX

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let tcxfolder = TCXSubfolders<TCXHistoryFolder>()
        let historybike = TCXHistoryFolder(name: "F1")
        tcxfolder.biking = historybike
        historybike.notes = "This should work."
        historybike.weeks.append(TCXWeek())
        historybike.activityRefs.append(TCXActivityReference(activityRefId: Date()))
        let tx = TCXMultiSportSession()
        tx.firstSport = TCXActivity(sportType: .biking)
        
        
        print(tcxfolder.tcxFormatted())
        print([TCXWorkout(), TCXWorkout()].tcxFormatted())
        print(tx.tcxFormatted())
        //print(TCXWorkout().tcxFormatted())


        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

