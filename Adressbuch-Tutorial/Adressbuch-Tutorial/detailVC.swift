//
//  detailVC.swift
//  TableViewController-Tutorial
//
//  Created by Benjamin Herzog on 29.06.14.
//  Copyright (c) 2014 Benjamin Herzog. All rights reserved.
//

import UIKit

protocol DetailVCDelegate {
    func didAddPerson()
}

class detailVC: UIViewController {

    var daten: Person?
    var delegate: DetailVCDelegate?
    
    let context = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext
    
    @IBOutlet var nameTF : UITextField!
    @IBOutlet var vornameTF : UITextField!
    @IBOutlet var strasseTF : UITextField!
    @IBOutlet var plzTF : UITextField!
    @IBOutlet var stadtTF : UITextField!
    @IBOutlet var telnrTF : UITextField!
    
    override func viewDidLoad() {
        if let name = daten?.nachname {
            title = name
        }
        else {
            title = "Neue Person"
            nameTF.becomeFirstResponder()
        }
        
        nameTF.text = daten?.nachname
        vornameTF.text = daten?.vorname
        strasseTF.text = daten?.strasse
        plzTF.text = daten?.plz
        stadtTF.text = daten?.stadt
        telnrTF.text = daten?.telnr
        
        if daten == nil {
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Speichern", style: .Done, target: self, action: "speichern")
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Abbrechen", style: .Plain, target: self, action: "cancel")
        }
        else {
            
        }
    }
    
    func cancel() {
        presentingViewController.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func speichern() {
        
        var newPerson = NSEntityDescription.insertNewObjectForEntityForName("Person", inManagedObjectContext: context) as Person
        newPerson.nachname = nameTF.text
        newPerson.vorname = vornameTF.text
        newPerson.strasse = strasseTF.text
        newPerson.plz = plzTF.text
        newPerson.stadt = stadtTF.text
        newPerson.telnr = telnrTF.text
        
        context.save(nil)
        
        delegate?.didAddPerson()
        presentingViewController.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
























