//
//  ViewController3.swift
//  Hexoplex
//
//  Created by Owner on 10/19/15.
//  Copyright (c) 2015 Yeshwanth Devabhaktuni. All rights reserved.
//

import UIKit
import Alamofire

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

        //let user = HexoskinAPIRequest(username: "athlete@hexoskin.com", password: "hexoskin")
        let user = HexoskinAPIRequest(username: "cdduker@gmail.com", password: "r33ltime")

        // This function diaplays the user info recieved from the API request
        // getUserInfo(). dispatch_async makes sure this operation is done in
        //the background to make sure it doesnt block the rendering of the page
        func displayUserInfo(info: NSDictionary){

            dispatch_async(dispatch_get_main_queue(), {
                var infoText:String  = ""
                if (info["error"] != nil){
                    infoText = String(info["error"]!)
                }
                else {
                    infoText =
                        "email " + String(info["email"]!)
                        + "\n first_name " + String(info["first_name"]!)
                        + "\n last_name " + String(info["last_name"]!)
                        + "\n id " + String(info["id"]!)
                        + "\n profile " + String(info["profile"]!)
                        + "\n username " + String(info["username"]!)
                }

                self.debugText.text = infoText
            })
        }
        user.getUserInfo(displayUserInfo)
        // Call moved to gauge screen //user.getRealtimeData()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func sendMessage(sender: UIButton) {
        sendRequest()
    }


    func sendRequest(){
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */

}
