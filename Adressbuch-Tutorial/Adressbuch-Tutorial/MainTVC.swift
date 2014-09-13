//
//  MainTVC.swift
//  TableViewController-Tutorial
//
//  Created by Benjamin Herzog on 29.06.14.
//  Copyright (c) 2014 Benjamin Herzog. All rights reserved.
//

import UIKit

class MainTVC: UITableViewController, DetailVCDelegate {

    var daten = []
    
    let context = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext
    
    
    @IBAction func addNewData(sender : UIBarButtonItem) {
        performSegueWithIdentifier("add", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshData()
    }
    
    func refreshData() {
        var fetchRequest = NSFetchRequest(entityName: "Person")
        daten = context.executeFetchRequest(fetchRequest, error: nil)!
        tableView.reloadData()
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return daten.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as UITableViewCell
        cell.textLabel?.text = "\(daten[indexPath.row].nachname), \(daten[indexPath.row].vorname)"
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 85
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == .Delete {
            var fetchRequest = NSFetchRequest(entityName: "Person")
            let personToDelete = daten[indexPath.row] as Person
            fetchRequest.predicate = NSPredicate(format: "nachname = %@ && vorname = %@", personToDelete.nachname, personToDelete.vorname)
            let tempArray = context.executeFetchRequest(fetchRequest, error: nil)!
            for tempPerson : AnyObject in tempArray {
                context.deleteObject(tempPerson as Person)
            }
            context.save(nil)
            fetchRequest = NSFetchRequest(entityName: "Person")
            daten = context.executeFetchRequest(fetchRequest, error: nil)!
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
    
    override func tableView(tableView: UITableView, titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath) -> String {
        return "Löschen"
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "detail" {
            let row = tableView.indexPathForCell(sender as UITableViewCell)!.row
            (segue.destinationViewController as detailVC).daten = daten[row] as? Person
            (segue.destinationViewController as detailVC).delegate = self
        }
        else if segue.identifier == "add" {
            ((segue.destinationViewController as UINavigationController).viewControllers[0] as detailVC).delegate = self
        }
    }
    
    func didAddPerson() {
        refreshData()
    }

}





















