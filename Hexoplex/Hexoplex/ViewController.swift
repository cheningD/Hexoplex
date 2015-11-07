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
    
    //Text below heart and lung gauges
    @IBOutlet weak var heartText: UILabel!
    @IBOutlet weak var lungText: UILabel!
    
    
    
    //Heart and breathing rate gaugess
    
    @IBOutlet var heart_gauge: Gauge!
    @IBOutlet weak var heartMonitor: UIImageView!
    @IBAction func heartSlider(sender: UISlider) {
        heart_gauge.rate = CGFloat(sender.value)
        var heartString = Int(sender.value)
        self.heartText.text = "\(heartString) BPM"
    }
    
    @IBOutlet var lung_gauge: Gauge!
    @IBOutlet weak var BeathMonitor: UIImageView!
    @IBAction func LungSlider(sender: UISlider) {
        lung_gauge.rate = CGFloat(sender.value)
        var lungString = Int(sender.value)
        self.lungText.text = "\(lungString) BPM"
    }
    
    

    //Navigation buttons at bottom of screen
    @IBAction func ExerciseIsClicked(sender: UIBarButtonItem) {
        self.performSegueWithIdentifier("StatsToExercises", sender: sender)
    }
    
    @IBAction func SettingsIsClicked(sender: UIBarButtonItem) {
        self.performSegueWithIdentifier("StatsToSettings", sender: sender)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navBar.barTintColor = UIColor(red: 46/255, green: 207/255, blue: 102/255, alpha: 1)
        paddinglabel.backgroundColor = UIColor(red: 46/255, green: 207/255, blue: 102/255, alpha: 1)
        var x = 0
        x = 0
        if(x != 0){
            //navBar.backgroundColor = UIColor.redColor()
        }
        // Do any additional setup after loahttp://www.apple.com/iphone-6s/ding the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

