//
//  ViewController3.swift
//  Hexoplex
//
//  Created by Owner on 10/19/15.
//  Copyright (c) 2015 Yeshwanth Devabhaktuni. All rights reserved.
//

import UIKit

class ViewController3: UIViewController {
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var debugText: UITextView!

    @IBAction func StatsIsClicked(sender: UIBarButtonItem) {
    self.performSegueWithIdentifier("SettingsToStats", sender: sender)
    }

    @IBAction func ExercisesIsClicked(sender: UIBarButtonItem) {
        self.performSegueWithIdentifier("SettingsToExercises", sender: sender)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navBar.barTintColor = UIColor(red: 46/255, green: 207/255, blue: 102/255, alpha: 1)
        debugText.text = "DEBUG SETTINGS TEXT"
        

        let user = HexoskinAPIRequest(username: "athlete@hexoskin.com", password: "hexoskin")
        func getUserInfo(info: NSDictionary){

            dispatch_async(dispatch_get_main_queue(), {
                let infoText =
                        "email " + String(info["email"]!)
                        + "\n first_name " + String(info["first_name"]!)
                        + "\n last_name " + String(info["last_name"]!)
                        + "\n id " + String(info["id"]!)
                        + "\n profile " + String(info["profile"]!)
                        + "\n username " + String(info["username"]!)
                self.debugText.text = infoText
            })
        }
        user.getUserInfo(getUserInfo)
        

        // Do any additional setup after loading the view.


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
