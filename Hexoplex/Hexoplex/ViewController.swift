//
//  ViewController.swift
//  Hexoplex
//
//  Created by Yeshwanth Devabhaktuni on 10/5/15.
//  Copyright (c) 2015 Yeshwanth Devabhaktuni. All rights reserved.
//

import UIKit
import GaugeKit

class ViewController: UIViewController {
    
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var paddinglabel: UILabel!
    
    //Heart and breathing rate dials
    @IBOutlet weak var heartMonitor: UIImageView!
    @IBOutlet weak var BeathMonitor: UIImageView!
    
    @IBOutlet var lung_gauge: Gauge!
    @IBOutlet var heart_gauge: Gauge!
    //Navigation buttons at bottom of screen
    @IBOutlet weak var exerciseButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    
    @IBAction func sliderChnaged(sender: UISlider) {
        
        heart_gauge.rate = CGFloat(sender.value * 3)
        lung_gauge.rate = CGFloat(sender.value * 3)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navBar.barTintColor = UIColor.greenColor()
        paddinglabel.backgroundColor = UIColor.greenColor()
        var x = 0
        x = 0
        if(x != 0){
            navBar.backgroundColor = UIColor.redColor()
        }
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

