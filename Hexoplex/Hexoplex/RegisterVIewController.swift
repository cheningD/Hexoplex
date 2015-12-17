//
//  RegisterVIewController.swift
//  Hexoplex
//
//  Created by 王 新沿 on 12/16/15.
//  Copyright © 2015 Yeshwanth Devabhaktuni. All rights reserved.
//

import UIKit

class RegisterVIewController: UIViewController {
    
    func showErrorView(error: NSError) {
        if let errorMessage = error.userInfo["error"] as? String {
            let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            presentViewController(alert, animated: true, completion: nil)
        }
    }

   
    @IBOutlet var UserTextField: UITextField!
    
    @IBOutlet var Econtact: UITextField!
    @IBOutlet var Pconfir: UITextField!
    @IBOutlet var PasswordTextField: UITextField!
    
    
    let scrollViewWallSegue = "SignupSuccesful"
    let scollLoginSegue = "GoBackToLogin"
    @IBOutlet weak var warninglabel: UILabel!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        let myColor : UIColor = UIColor.cyanColor();
        
        
        super.viewDidLoad()
        
        /*self.UserTextField.layer.borderColor = myColor.CGColor
        self.Econtact.layer.borderColor = myColor.CGColor
        self.Pconfir.layer.borderColor = myColor.CGColor
        self.PasswordTextField.layer.borderColor = myColor.CGColor*/
        
        /*self.Econtact.layer.borderWidth = 0.5
        self.UserTextField.layer.borderWidth = 0.5
        self.Pconfir.layer.borderWidth = 0.5
        self.PasswordTextField.layer.borderWidth = 0.5*/

        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func touch_Back_login(sender: AnyObject) {
        self.performSegueWithIdentifier(self.scollLoginSegue, sender: nil)
    
    }
   
    @IBAction func SignUpPressed(sender: AnyObject) {
        let user = PFUser()
        
        if PasswordTextField.text != Pconfir.text {
            //print("here")
            self.warninglabel.text = "password need to be check for equal!"
            return
        }
        
        //2
        user.username = UserTextField.text
        user.password = PasswordTextField.text
        
        //3
        user.signUpInBackgroundWithBlock { succeeded, error in
            if (succeeded) {
                
                //The registration was successful, create table row in usrinfo to store Econtact info
                let hexo_user = PFObject(className:"usrinfo")
                hexo_user["usrname"] = self.UserTextField.text
                hexo_user["Econtact"] = self.Econtact.text
                hexo_user.saveInBackgroundWithBlock {
                    (success: Bool, error: NSError?) -> Void in
                    if (success) {
                        // The object has been saved.
                    } else {
                        // There was a problem, check error.description
                    }
                }
                
                
                
                //The registration was successful, go to the wall
                
                self.performSegueWithIdentifier(self.scrollViewWallSegue, sender: nil)
            }
            if let error = error {
                //Something bad has occurred
                self.showErrorView(error)
            }

        }
    }
    // MARK: - Actions
}