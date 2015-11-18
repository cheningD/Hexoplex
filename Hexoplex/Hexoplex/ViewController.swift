//
//  ViewController.swift
//  Hexoplex
//
//  Created by Yeshwanth Devabhaktuni on 10/5/15.
//  Copyright (c) 2015 Yeshwanth Devabhaktuni. All rights reserved.
//

import UIKit
import GaugeKit

class ViewController: UIViewController, UIPopoverPresentationControllerDelegate {
    
    
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var paddinglabel: UILabel!
    
    @IBOutlet var heartTile: UIView!
    @IBOutlet var lungTile: UIView!
    
    
    //Text below heart and lung gauges
    @IBOutlet weak var heartText: UILabel!
    @IBOutlet weak var lungText: UILabel!
    
    
    
    //Heart and breathing rate gaugess
    
    @IBOutlet var heart_gauge: Gauge!
    @IBOutlet weak var heartMonitor: UIImageView!
    @IBAction func heartSlider(sender: UISlider) {
        heart_gauge.rate = CGFloat(sender.value)
        let heartString = Int(sender.value)
        self.heartText.text = "\(heartString) BPM"
        
        if(sender.value > 150 && sender.value < 165)
        {
            heartTile.backgroundColor = UIColor.yellowColor()
        }
        else if(sender.value > 165)
        {
            heartTile.backgroundColor = UIColor.redColor()
        }
        else
        {
            heartTile.backgroundColor = UIColor.greenColor()
        }
    }
    
    @IBOutlet var lung_gauge: Gauge!
    @IBOutlet weak var BeathMonitor: UIImageView!
    @IBAction func LungSlider(sender: UISlider) {
        lung_gauge.rate = CGFloat(sender.value)
        let lungString = Int(sender.value)
        self.lungText.text = "\(lungString) BPM"
        
        if(sender.value > 40 && sender.value < 45)
        {
            lungTile.backgroundColor = UIColor.yellowColor()
        }
        else if(sender.value > 45)
        {
            lungTile.backgroundColor = UIColor.redColor()
        }
        else
        {
            lungTile.backgroundColor = UIColor.greenColor()
        }
        
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
        
        heartTile.layer.cornerRadius = 30.0
        heartTile.layer.opacity = 25.0
        
        lungTile.layer.cornerRadius = 30.0
        lungTile.layer.opacity = 25.0
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func swipeRight(sender: AnyObject) {
        self.performSegueWithIdentifier("StatsToSettings", sender: self)
    }
    
    @IBAction func swipeLeft(sender: AnyObject) {
        self.performSegueWithIdentifier("StatsToExercises", sender: self)
    }
    
    @IBAction func heartTileClicked(sender: AnyObject) {
        
        self.performSegueWithIdentifier("heartHistory", sender: self)
    }
    
    @IBAction func lungTileClicked(sender: AnyObject) {
        
        self.performSegueWithIdentifier("lungHistory", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "heartHistory"
        {
            if let controller = segue.destinationViewController as? UIViewController
            {
                controller.popoverPresentationController!.delegate = self
                controller.preferredContentSize = CGSize(width: 400, height: 300)
            }
        }
        
        if segue.identifier == "lungHistory"
        {
            if let controller = segue.destinationViewController as? UIViewController
            {
                controller.popoverPresentationController!.delegate = self
                controller.preferredContentSize = CGSize(width: 400, height: 300)
            }
        }
    }


    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return .None
    }
    
    
}

