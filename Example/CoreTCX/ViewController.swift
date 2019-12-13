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
        var tcxfolder = TCXSubfolders<TCXHistoryFolder>()
    

        print(tcxfolder.tcxFormatted())

        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

