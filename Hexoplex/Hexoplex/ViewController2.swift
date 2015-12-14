//
//  ViewController2.swift
//  Hexoplex
//
//  Created by Owner on 10/19/15.
//  Copyright (c) 2015 Yeshwanth Devabhaktuni. All rights reserved.
//

import UIKit

class ViewController2: UIViewController, UITableViewDelegate, UITableViewDataSource{
    @IBOutlet weak var navbar: UINavigationBar!
    @IBOutlet weak var exercisesList: UITableView!
    
    @IBAction func StatsIsClicked(sender: UIBarButtonItem) {
    self.performSegueWithIdentifier("ExercisesToStats", sender: sender)
    }

    @IBAction func SettingsIsClicked(sender: UIBarButtonItem) {
    self.performSegueWithIdentifier("ExercisesToSettings", sender: sender)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        exercisesList.delegate = self
        exercisesList.dataSource = self
        
        navbar.barTintColor = UIColor(red: 46/255, green: 207/255, blue: 102/255, alpha: 1)
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var thereIsCellTapped = false
    var selectedRowIndex = -1
    
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        self.exercisesList.cellForRowAtIndexPath(indexPath)?.backgroundColor = UIColor.grayColor()
        let cell = exercisesList.cellForRowAtIndexPath(indexPath)! as UITableViewCell
        // avoid paint the cell is the index is outside the bounds
        if (self.selectedRowIndex != -1 ){
            self.exercisesList.cellForRowAtIndexPath(NSIndexPath(forRow: self.selectedRowIndex, inSection: 0))?.backgroundColor = UIColor.whiteColor()
        }
        
        if (selectedRowIndex != indexPath.row ){
            self.thereIsCellTapped = true
            self.selectedRowIndex = indexPath.row
            
            if(selectedRowIndex==0){
                //this cell
                cell.textLabel!.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0)
                cell.textLabel!.text = "Belly Breathing\n\n 1. Place one hand just above your belt line, and the other on your chest, right over the breastbone.  Your hands will tell you what part of your body, and what muscles, you are using to breathe.\n 2. Open your mouth and gently sigh, as if someone had just told you something really annoying.\n 3. Close your mouth and pause for a few seconds.\n 4. Keep your mouth closed and inhale slowly through your nose by pushing your stomach out.\n 5. Pause until you feel the need to exhale.\n 6. Open your mouth. Exhale through your mouth by pulling your belly in.\n 7. Pause.\n 8. Continue with Steps 4-7.\n "
                cell.textLabel!.numberOfLines = 0
                cell.detailTextLabel!.text=""
                cell.clipsToBounds = true
                
                //second cell
                let cell2 = exercisesList.cellForRowAtIndexPath(NSIndexPath(forRow: 1, inSection: 0));
                cell2!.textLabel!.text="Bumble Bee Breathing"
                cell2!.detailTextLabel!.text="Duration: 5 minutes"
                
                //third cell
                let cell3 = exercisesList.cellForRowAtIndexPath(NSIndexPath(forRow: 2, inSection: 0));
                cell3!.textLabel!.text="Quick Breathing"
                cell3!.detailTextLabel!.text="Duration: 1 minutes"
            }
            else if(selectedRowIndex==1){
                cell.textLabel!.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0)
                cell.textLabel!.text = "Bumble Bee Breathing\n\n 1. Relax your shoulders. \n 2. Close your throat slightly so you can hear your breath when you breathe in. \n 3. Cover your ears with your thumbs and your eyes with your fingers.\n 4. Keep your lips closed but lightly and your teeth slightly apart with your jaw relaxed and breathe out slowly making a long, low humming sound.\n 5. Make your exhalation long and smooth.\n 6. Repeat steps 1-5 five to ten times.\n 7. Sit with long slow breaths for a couple of minutes and enjoy the peace. \n"
                cell.textLabel!.numberOfLines = 0
                cell.detailTextLabel!.text=""
                cell.clipsToBounds = true
                
                //first cell
                let cell2 = exercisesList.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0));
                cell2!.textLabel!.text="Belly Breathing"
                cell2!.detailTextLabel!.text="Duration: 3 minutes"
                
                //third cell
                let cell3 = exercisesList.cellForRowAtIndexPath(NSIndexPath(forRow: 2, inSection: 0));
                cell3!.textLabel!.text="Quick Breathing"
                cell3!.detailTextLabel!.text="Duration: 1 minutes"
            }
            else if(selectedRowIndex==2){
                cell.textLabel!.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0)
                cell.textLabel!.text = "Quick Breathing \n\n 1. You can sit or stand, but be sure to soften up a little before you begin. Make sure your hands are relaxed, and your knees are soft.\n 2. Drop your shoulders and let your jaw relax.\n 3. Now breath in slowly through your nose and count to four, keep your shoulders down and allow your stomach to expand as you breathe in.\n 4. Hold the breath for a moment.\n 5. PNow release your breath slowly and smoothly as you count to seven.\n 6. Continue with Steps 4-7. \n"
                cell.textLabel!.numberOfLines = 0
                cell.detailTextLabel!.text=""
                cell.clipsToBounds = true
                
                //first cell
                let cell2 = exercisesList.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0));
                cell2!.textLabel!.text="Belly Breathing"
                cell2!.detailTextLabel!.text="Duration: 3 minutes"
                
                //second cell
                let cell3 = exercisesList.cellForRowAtIndexPath(NSIndexPath(forRow: 1, inSection: 0));
                cell3!.textLabel!.text="Bumble Bee Breathing"
                cell3!.detailTextLabel!.text="Duration: 5 minutes"
            }
        }
        else {
            // there is no cell selected anymore
            if(selectedRowIndex==0){
                cell.textLabel!.text="Belly Breathing"
                cell.detailTextLabel!.text="Duration: 3 minutes"
            }
            if(selectedRowIndex==1){
                cell.textLabel!.text="Bumble Bee Breathing"
                cell.detailTextLabel!.text="Duration: 5 minutes"
            }
            if(selectedRowIndex==2){
                cell.textLabel!.text="Quick Breathing"
                cell.detailTextLabel!.text="Duration: 1 minutes"
            }
            self.thereIsCellTapped = false
            self.selectedRowIndex = -1
        }
        
        
        self.exercisesList.beginUpdates()
        self.exercisesList.endUpdates()
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if indexPath.row == selectedRowIndex && thereIsCellTapped {
            if(selectedRowIndex == 0){
                return 400
            }
            else if(selectedRowIndex == 1){
                return 340
            }
            else if(selectedRowIndex == 2){
                return 300
            }
        }
        
        return 44
    }
    
    func tableView(tableView:UITableView, numberOfRowsInSection section:Int) -> Int
    {
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell:UITableViewCell=UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "mycell")
        cell.textLabel!.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0)
        if(indexPath.row == 0){
            cell.textLabel!.text="Belly Breathing"
            cell.detailTextLabel!.text="Duration: 3 minutes"
        }
            
        else if(indexPath.row == 1){
            cell.textLabel!.text="Bumble Bee Breathing"
            cell.detailTextLabel!.text="Duration: 5 minutes"
        }
            
        else if(indexPath.row == 2){
            cell.textLabel!.text="Quick Breathing"
            cell.detailTextLabel!.text="Duration: 1 minute"
        }
        
        if(self.selectedRowIndex == 0){
            
        }
        
        return cell
    }

}
