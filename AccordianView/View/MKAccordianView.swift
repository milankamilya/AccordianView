//
//  MKAccordianView.swift
//  AccrodianView
//
//  Created by Milan Kamilya on 26/06/15.
//  Copyright (c) 2015 Milan Kamilya. All rights reserved.
//

import UIKit
import Foundation

// Target :: use protocol, documentation, proper handling of actions

// Define AccordianViewDelegate and AccordianViewDatasource
// Implement only neccessary methods and each time fetch data from user of the accodian view.
//


// MARK: - MKAccordianViewDelegate
@objc protocol MKAccordianViewDelegate : NSObjectProtocol {
    
    optional func accordianView(accordianView: MKAccordianView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    optional func accordianView(accordianView: MKAccordianView, heightForHeaderInSection section: Int) -> CGFloat
    optional func accordianView(accordianView: MKAccordianView, heightForFooterInSection section: Int) -> CGFloat
    
    optional func accordianView(accordianView: MKAccordianView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool
    optional func accordianView(accordianView: MKAccordianView, didHighlightRowAtIndexPath indexPath: NSIndexPath)
    optional func accordianView(accordianView: MKAccordianView, didUnhighlightRowAtIndexPath indexPath: NSIndexPath)
    
    // Called before the user changes the selection. Return a new indexPath, or nil, to change the proposed selection.
    optional func accordianView(accordianView: MKAccordianView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath?
    optional func accordianView(accordianView: MKAccordianView, willDeselectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath?
    // Called after the user changes the selection.
    optional func accordianView(accordianView: MKAccordianView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    optional func accordianView(accordianView: MKAccordianView, didDeselectRowAtIndexPath indexPath: NSIndexPath)
    
    
    optional func accordianView(accordianView: MKAccordianView, viewForHeaderInSection section: Int, isSectionOpen sectionOpen: Bool) -> UIView?
    optional func accordianView(accordianView: MKAccordianView, viewForFooterInSection section: Int, isSectionOpen sectionOpen: Bool) -> UIView?
}

// MARK: - MKAccordianViewDatasource
@objc protocol MKAccordianViewDatasource : NSObjectProtocol {
    
    func accordianView(accordianView: MKAccordianView, numberOfRowsInSection section: Int) -> Int
    
    func accordianView(accordianView: MKAccordianView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    
    optional func numberOfSectionsInAccordianView(accordianView: MKAccordianView) -> Int // Default is 1 if not implemented
    
    optional func accordianView(accordianView: MKAccordianView, titleForHeaderInSection section: Int) -> String? // fixed font style. use custom view (UILabel) if you want something different
    optional func accordianView(accordianView: MKAccordianView, titleForFooterInSection section: Int) -> String?
    
}

// MARK: - MKAccordianView Main Definition
class MKAccordianView: UIView {
    
    var dataSource: MKAccordianViewDatasource?
    var delegate: MKAccordianViewDelegate?
    var tableView : UITableView?
    
    private var arrayOfBool : NSMutableArray?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        tableView = UITableView(frame: frame)
        tableView?.delegate = self;
        tableView?.dataSource = self;
        self.addSubview(tableView!);
        
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func sectionHeaderTapped(recognizer: UITapGestureRecognizer) {
        println("Tapping working")
        println(recognizer.view?.tag)
        
        var indexPath : NSIndexPath = NSIndexPath(forRow: 0, inSection:(recognizer.view?.tag as Int!)!)
        if (indexPath.row == 0) {
            
            var collapsed : Bool! = arrayOfBool?.objectAtIndex(indexPath.section).boolValue
            collapsed       = !collapsed;
            
            arrayOfBool?.replaceObjectAtIndex(indexPath.section, withObject: NSNumber(bool: collapsed))
            
            //reload specific section animated
            var range = NSMakeRange(indexPath.section, 1)
            var sectionToReload = NSIndexSet(indexesInRange: range)
            tableView?.reloadSections(sectionToReload, withRowAnimation:UITableViewRowAnimation.Fade)
        }
        
    }
}


// MARK: - Implemention of UITableViewDelegate methods
extension MKAccordianView : UITableViewDelegate {
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        var height : CGFloat! = 0.0
        
        var collapsed: Bool! = arrayOfBool?.objectAtIndex(indexPath.section).boolValue

        if collapsed! {
            if (delegate?.respondsToSelector(Selector("accordianView:heightForRowAtIndexPath:")))! {
                height = delegate?.accordianView!(self, heightForRowAtIndexPath: indexPath)
            }
        }
        
        return height
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        var height : CGFloat! = 0.0
        if (delegate?.respondsToSelector(Selector("accordianView:heightForHeaderInSection:")))! {
           height = delegate?.accordianView!(self, heightForHeaderInSection: section)
        }
        return height

    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        var height : CGFloat! = 0.0
        if (delegate?.respondsToSelector(Selector("accordianView:heightForFooterInSection:")))! {
            height = delegate?.accordianView!(self, heightForFooterInSection: section)
        }
        return height
    }
    
    func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        
        var selection : Bool! = false
        if (delegate?.respondsToSelector(Selector("accordianView:shouldHighlightRowAtIndexPath:")))!{
            selection = delegate?.accordianView!(self, shouldHighlightRowAtIndexPath: indexPath)
        }
        
        return true;
    }
    func tableView(tableView: UITableView, didHighlightRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    func tableView(tableView: UITableView, didUnhighlightRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    // Called before the user changes the selection. Return a new indexPath, or nil, to change the proposed selection.
    func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        return indexPath;
    }
    func tableView(tableView: UITableView, willDeselectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        return indexPath;
    }
    // Called after the user changes the selection.
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        var view : UIView! = nil
        if (delegate?.respondsToSelector(Selector("accordianView:viewForHeaderInSection:isSectionOpen:")))! {
            
            var collapsed: Bool! = arrayOfBool?.objectAtIndex(section).boolValue
            
            view = delegate?.accordianView!(self, viewForHeaderInSection: section, isSectionOpen: collapsed)
            view.tag = section;
            
            // tab recognizer
            let headerTapped = UITapGestureRecognizer (target: self, action:"sectionHeaderTapped:")
            view .addGestureRecognizer(headerTapped)
        }
        
        return view
    }
    
}

// MARK: - Implemention of UITableViewDataSource methods
extension MKAccordianView : UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var no : Int! = 0
        
        var collapsed: Bool! = arrayOfBool?.objectAtIndex(section).boolValue

        if collapsed! {
        
            if (dataSource?.respondsToSelector(Selector("accordianView:numberOfRowsInSection:")))! {
                no = dataSource?.accordianView(self, numberOfRowsInSection: section)
            }
        }
        
        return no
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell : UITableViewCell? = nil
        if (dataSource?.respondsToSelector(Selector("accordianView:cellForRowAtIndexPath:")))! {
            cell = (dataSource?.accordianView(self, cellForRowAtIndexPath: indexPath))!
        }
        
        return cell!
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        var numberOfSections : Int! = 1
        if (dataSource?.respondsToSelector(Selector("numberOfSectionsInAccordianView:")))! {
            numberOfSections = dataSource?.numberOfSectionsInAccordianView!(self)
            
            if arrayOfBool == nil {
                arrayOfBool = NSMutableArray()
                var sections : Int! = numberOfSections - 1
                for _ in 0...sections {
                    arrayOfBool?.addObject(NSNumber(bool: false))
                }
            }
            
        }
        return numberOfSections;
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        var title : String! = nil
        
        if (dataSource?.respondsToSelector(Selector("accordianView:titleForHeaderInSection:")))! {
            title = dataSource?.accordianView!(self, titleForHeaderInSection: section)
        }
        
        return title
    }
    
    func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        var title : String! = nil
        
        if (dataSource?.respondsToSelector(Selector("accordianView:titleForFooterInSection:")))! {
            title = dataSource?.accordianView!(self, titleForFooterInSection: section)
        }
        
        return title
    }
    
}


