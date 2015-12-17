//
//  ViewController.swift
//  Hexoplex
//
//  Created by Yeshwanth Devabhaktuni on 10/5/15.
//  Copyright (c) 2015 Yeshwanth Devabhaktuni. All rights reserved.
//

import UIKit
import GaugeKit
import Alamofire

class ViewController: UIViewController, UIPopoverPresentationControllerDelegate {


    @IBOutlet var heartImage: UIButton!
    @IBOutlet var breathImage: UIButton!
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var paddinglabel: UILabel!

    @IBOutlet var heartTile: UIView!

    @IBOutlet var lungTile: UIView!
    
    var notificationSentHeart = 0
    var notificationSentConHeart = 0
    var notificationSentLung = 0
    var notificationSentConLung = 0
    
    //push notifications
    func sendRequest(notifaction:NSNotification){
        let data = [
            "To" : "+18144418654",
            "From" : "+18148263789",
            "Body" : "Yout friend is having an anxiety attack"
        ]
        
        Alamofire.request(.POST, "https://AC8bd8d9a25ad4cc983c7fc9d28b3f9176:7964a41dde9ec33d7a7c580f7f5379d4@api.twilio.com/2010-04-01/Accounts/AC8bd8d9a25ad4cc983c7fc9d28b3f9176/Messages", parameters: data)
            .responseJSON { response in
                print(response.request)
                print(response.response)
                print(response.result)
        }
    }
    
    func sendPush(){
        var localNotification = UILocalNotification()
        localNotification.alertBody = "Are You Stressed? Try some Exercises"
        localNotification.timeZone = NSTimeZone.defaultTimeZone()
        localNotification.applicationIconBadgeNumber = UIApplication.sharedApplication().applicationIconBadgeNumber + 1
        UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
    }
    
    func sendPushtoContact(){
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"sendRequest:", name: "actionOnePressed", object: nil)
        
        var localNotification = UILocalNotification()
        
        localNotification.category = "first_category"
        localNotification.alertBody = "Would you like to contact someone?"
        localNotification.timeZone = NSTimeZone.defaultTimeZone()
        localNotification.applicationIconBadgeNumber = UIApplication.sharedApplication().applicationIconBadgeNumber + 1
        UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
    }

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

            if ( rate > 100 && rate < 165)
            {
                self.heartTile.backgroundColor = UIColor.yellowColor()
                if(self.notificationSentHeart == 0)
                {
                    self.notificationSentHeart = 1;
                    self.sendPush()
                }
            }
            else if (rate > 165)
            {
                self.heartTile.backgroundColor = UIColor.redColor()
                if(self.notificationSentConHeart == 0)
                {
                    self.notificationSentConHeart = 1;
                    self.sendPushtoContact()

                }
            }
            else
            {
                self.heartTile.backgroundColor = UIColor.greenColor()
                self.notificationSentConHeart = 0
                self.notificationSentHeart = 0
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
                if(self.notificationSentLung == 0)
                {
                    self.notificationSentLung = 1;
                    self.sendPush()
                }
            }
            else if (rate > 45)
            {
                self.lungTile.backgroundColor = UIColor.redColor()
                if(self.notificationSentConLung == 0)
                {
                    self.notificationSentConLung = 1;
                    self.sendPushtoContact()
                }
            }
            else
            {
                self.lungTile.backgroundColor = UIColor.greenColor()
                self.notificationSentLung = 0
                self.notificationSentConLung = 0
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
