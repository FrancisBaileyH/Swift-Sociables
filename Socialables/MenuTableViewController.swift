//
//  MenuTableViewController.swift
//  Socialables
//
//  Created by Francis Bailey on 2015-04-30.
//  Copyright (c) 2015 Okanagan College. All rights reserved.
//

import Foundation


//
//  MyMenuTableViewController.swift
//  SwiftSideMenu
//
//  Created by Evgeny Nazarov on 29.09.14.
//  Copyright (c) 2014 Evgeny Nazarov. All rights reserved.
//

import UIKit

class MenuTableViewController: UITableViewController {
  
    
    
    let menuItems = [ "New Game", "Rule Editor", "Settings" ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Customize apperance of table view
        tableView.contentInset = UIEdgeInsetsMake(64.0, 0, 0, 0) //
        tableView.separatorStyle = .None
        tableView.backgroundColor = UIColor.clearColor()
        tableView.scrollsToTop = false
        
        // Preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = false
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return menuItems.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("CELL") as? UITableViewCell
        
        if (cell == nil) {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "CELL")
            cell!.backgroundColor = UIColor.clearColor()
            cell!.textLabel?.textColor = UIColor.whiteColor()
            let selectedBackgroundView = UIView(frame: CGRectMake(0, 0, cell!.frame.size.width, cell!.frame.size.height))
            selectedBackgroundView.backgroundColor = UIColor.grayColor().colorWithAlphaComponent(0.2)
            cell!.selectedBackgroundView = selectedBackgroundView
        }
        
        cell!.textLabel?.text = menuItems[indexPath.row]
        
        return cell!
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50.0
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        
        //Present new view controller
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
        
        
        var destViewController : UIViewController?
        
        switch (indexPath.row) {
        case 0:
            sideMenuController()?.sideMenu?.delegate?.nonSegueEventDidFire?("New Game")
            //destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("ViewController") as? UIViewController
            break
        case 1:
            
            //sideMenuController()?.sideMenu?.
            destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("RuleCollectionViewController") as? UIViewController

         
            
            break
        case 2:
            //destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("ViewController3") as? UIViewController
            break
        default:
           // destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("ViewController4") as? UIViewController
            break
        }
        
        if let controller = destViewController {
            sideMenuController()?.sideMenu?.delegate?.segueEventDidFire?(controller)
        } else {
            sideMenuController()?.sideMenu?.hideSideMenu()
        }
    }
    
    
    /*
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    }
    */
    
}