//
//  LoginViewController.swift
//  Hexoplex
//
//  Created by 王 新沿 on 12/16/15.
//  Copyright © 2015 Yeshwanth Devabhaktuni. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController{
    func showErrorView(error: NSError) {
        if let errorMessage = error.userInfo["error"] as? String {
            let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            presentViewController(alert, animated: true, completion: nil)
        }
    }

    
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var userTextField: UITextField!
    @IBOutlet var loginbutton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    let scrollViewWallSegue = "LoginSuccesful"
    let GoToSignupSeague = "SignUpPage"

    
    @IBAction func signupPressed(sender: AnyObject) {
        self.performSegueWithIdentifier(self.GoToSignupSeague, sender: nil)
    }
    
    @IBAction func LoginPressed(sender: AnyObject) {
        PFUser.logInWithUsernameInBackground((userTextField.text)!, password: (passwordTextField.text)!) { user, error in
            if user != nil {
                self.performSegueWithIdentifier(self.scrollViewWallSegue, sender: nil)
            } else if let error = error {
                self.showErrorView(error)
            }
        }
    }
}
