//
//  ViewController2.swift
//  Hexoplex
//
//  Created by Owner on 10/19/15.
//  Copyright (c) 2015 Yeshwanth Devabhaktuni. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {
    @IBOutlet weak var navbar: UINavigationBar!
    
    @IBAction func StatsIsClicked(sender: UIBarButtonItem) {
    self.performSegueWithIdentifier("ExercisesToStats", sender: sender)
    }

    @IBAction func SettingsIsClicked(sender: UIBarButtonItem) {
    self.performSegueWithIdentifier("ExercisesToSettings", sender: sender)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navbar.barTintColor = UIColor(red: 46/255, green: 207/255, blue: 102/255, alpha: 1)
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
