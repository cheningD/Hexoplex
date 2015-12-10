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

    // Updates HEART gaugue in background
    func displayRealtimeHeartRate(rate: Int){

        dispatch_async(dispatch_get_main_queue(), {
            print("Heart Gaugue Update")
            self.heart_gauge.rate = CGFloat(rate)
            let heartString = Int(rate)
            self.heartText.text = "\(heartString) BPM"

            if ( rate > 150 && rate < 165)
            {
                self.heartTile.backgroundColor = UIColor.yellowColor()
            }
            else if (rate > 165)
            {
                self.heartTile.backgroundColor = UIColor.redColor()
            }
            else
            {
                self.heartTile.backgroundColor = UIColor.greenColor()
            }
        })
    }


    /*@IBAction func heartSlider(sender: UISlider) {
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
    }*/


    @IBOutlet var lung_gauge: Gauge!
    @IBOutlet weak var BeathMonitor: UIImageView!
    /*@IBAction func LungSlider(sender: UISlider) {
        lung_gauge.rate = CGFloat(sender.value)
        let lungString = Int(sender.value)
        self.lungText.text = "\(lungString) BPM"

        if(sender.value > 40 && sender.value < 45)
        {
            lungTile.backgroundColor = UIColor(red:1.00, green:0.60, blue:0.20, alpha:1.0)
        }
        else if(sender.value > 45)
        {
            lungTile.backgroundColor = UIColor(red:1.00, green:0.20, blue:0.20, alpha:1.0)
        }
        else
        {
            lungTile.backgroundColor = UIColor(red:0.30, green:1.00, blue:0.30, alpha:1.0)
        }

    }*/
    // Updates LUNG gaugue in background
    func displayRealtimeLungRate(rate: Int){

        dispatch_async(dispatch_get_main_queue(), {
            print("Lung Gaugue Update")
            self.lung_gauge.rate = CGFloat(rate)
            let lungString = Int(rate)
            self.lungText.text = "\(lungString) BPM"

            if ( rate > 40 && rate < 45)
            {
                self.lungTile.backgroundColor = UIColor.yellowColor()
            }
            else if (rate > 45)
            {
                self.lungTile.backgroundColor = UIColor.redColor()
            }
            else
            {
                self.lungTile.backgroundColor = UIColor.greenColor()
            }
        })
    }



    //Navigation buttons at bottom of screen

    @IBAction func exerciseClicked(sender: AnyObject) {
        self.performSegueWithIdentifier("StatsToExercises", sender: self)
    }

    @IBAction func settingsClicked(sender: AnyObject) {
        self.performSegueWithIdentifier("StatsToSettings", sender: self)
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

        // Make request for vitals
        let myUser = HexoskinAPIRequest(username: "cdduker@gmail.com", password: "r33ltime")
        myUser.getRealtimeData(displayRealtimeHeartRate, lungCompletion: displayRealtimeLungRate)
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
            if let controller2 = segue.destinationViewController as? UIViewController
            {
                controller2.popoverPresentationController!.delegate = self
                controller2.preferredContentSize = CGSize(width: 400, height: 300)
            }

        }

        if segue.identifier == "lungHistory"
        {
            if let controller = segue.destinationViewController as UIViewController?
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
