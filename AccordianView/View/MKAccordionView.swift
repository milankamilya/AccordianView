//
//  MKAccordionView.swift
//  AccrodianView
//
//  Created by Milan Kamilya on 26/06/15.
//  Copyright (c) 2015 Milan Kamilya. All rights reserved.
//

import UIKit
import Foundation

// MARK: - MKAccordionViewDelegate
@objc protocol MKAccordionViewDelegate : NSObjectProtocol {
    
    optional func accordionView(accordionView: MKAccordionView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    optional func accordionView(accordionView: MKAccordionView, heightForHeaderInSection section: Int) -> CGFloat
    optional func accordionView(accordionView: MKAccordionView, heightForFooterInSection section: Int) -> CGFloat
    
    optional func accordionView(accordionView: MKAccordionView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool
    optional func accordionView(accordionView: MKAccordionView, didHighlightRowAtIndexPath indexPath: NSIndexPath)
    optional func accordionView(accordionView: MKAccordionView, didUnhighlightRowAtIndexPath indexPath: NSIndexPath)
    
    // Called before the user changes the selection. Return a new indexPath, or nil, to change the proposed selection.
    optional func accordionView(accordionView: MKAccordionView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath?
    optional func accordionView(accordionView: MKAccordionView, willDeselectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath?
    // Called after the user changes the selection.
    optional func accordionView(accordionView: MKAccordionView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    optional func accordionView(accordionView: MKAccordionView, didDeselectRowAtIndexPath indexPath: NSIndexPath)
    
    
    optional func accordionView(accordionView: MKAccordionView, viewForHeaderInSection section: Int, isSectionOpen sectionOpen: Bool) -> UIView?
    optional func accordionView(accordionView: MKAccordionView, viewForFooterInSection section: Int, isSectionOpen sectionOpen: Bool) -> UIView?
}

// MARK: - MKAccordionViewDatasource
@objc protocol MKAccordionViewDatasource : NSObjectProtocol {
    
    func accordionView(accordionView: MKAccordionView, numberOfRowsInSection section: Int) -> Int
    
    func accordionView(accordionView: MKAccordionView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    
    optional func numberOfSectionsInAccordionView(accordionView: MKAccordionView) -> Int // Default is 1 if not implemented
    
    optional func accordionView(accordionView: MKAccordionView, titleForHeaderInSection section: Int) -> String? // fixed font style. use custom view (UILabel) if you want something different
    optional func accordionView(accordionView: MKAccordionView, titleForFooterInSection section: Int) -> String?
    
}

// MARK: - MKAccordionView Main Definition
class MKAccordionView: UIView {
    
    var dataSource: MKAccordionViewDatasource?
    var delegate: MKAccordionViewDelegate?
    var tableView : UITableView?
    
    private var arrayOfBool : NSMutableArray?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        tableView = UITableView(frame: frame)
        tableView?.delegate = self;
        tableView?.dataSource = self;
        self.addSubview(tableView!);
        
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func sectionHeaderTapped(recognizer: UITapGestureRecognizer) {
        print("Tapping working")
        print(recognizer.view?.tag)
        
        let indexPath : NSIndexPath = NSIndexPath(forRow: 0, inSection:(recognizer.view?.tag as Int!)!)
        if (indexPath.row == 0) {
            
            var collapsed : Bool! = arrayOfBool?.objectAtIndex(indexPath.section).boolValue
            collapsed       = !collapsed;
            
            arrayOfBool?.replaceObjectAtIndex(indexPath.section, withObject: NSNumber(bool: collapsed))
            
            //reload specific section animated
            let range = NSMakeRange(indexPath.section, 1)
            let sectionToReload = NSIndexSet(indexesInRange: range)
            tableView?.reloadSections(sectionToReload, withRowAnimation:UITableViewRowAnimation.Fade)
        }
        
    }
}


// MARK: - Implemention of UITableViewDelegate methods
extension MKAccordionView : UITableViewDelegate {
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        var height : CGFloat! = 0.0
        
        let collapsed: Bool! = arrayOfBool?.objectAtIndex(indexPath.section).boolValue

        if collapsed! {
            if (delegate?.respondsToSelector(Selector("accordionView:heightForRowAtIndexPath:")))! {
                height = delegate?.accordionView!(self, heightForRowAtIndexPath: indexPath)
            }
        }
        
        return height
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        var height : CGFloat! = 0.0
        if (delegate?.respondsToSelector(Selector("accordionView:heightForHeaderInSection:")))! {
           height = delegate?.accordionView!(self, heightForHeaderInSection: section)
        }
        return height

    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        var height : CGFloat! = 0.0
        if (delegate?.respondsToSelector(Selector("accordionView:heightForFooterInSection:")))! {
            height = delegate?.accordionView!(self, heightForFooterInSection: section)
        }
        return height
    }
    
    func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        
        var selection : Bool! = true
        if (delegate?.respondsToSelector(Selector("accordionView:shouldHighlightRowAtIndexPath:")))!{
            selection = delegate?.accordionView!(self, shouldHighlightRowAtIndexPath: indexPath)
        }
        
        return selection
    }
    func tableView(tableView: UITableView, didHighlightRowAtIndexPath indexPath: NSIndexPath) {
        if (delegate?.respondsToSelector(Selector("accordionView:didHighlightRowAtIndexPath:")))!{
            delegate?.accordionView!(self, didHighlightRowAtIndexPath: indexPath)
        }
    }
    func tableView(tableView: UITableView, didUnhighlightRowAtIndexPath indexPath: NSIndexPath) {
        if (delegate?.respondsToSelector(Selector("accordionView:didUnhighlightRowAtIndexPath:")))!{
            delegate?.accordionView!(self, didUnhighlightRowAtIndexPath: indexPath)
        }
    }
    
    // Called before the user changes the selection. Return a new indexPath, or nil, to change the proposed selection.
    func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        var indexPathSelection: NSIndexPath? = indexPath
        if (delegate?.respondsToSelector(Selector("accordionView:willSelectRowAtIndexPath:")))!{
            indexPathSelection = delegate?.accordionView!(self, willSelectRowAtIndexPath: indexPath)
        }
        return indexPathSelection;
    }
    func tableView(tableView: UITableView, willDeselectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        var indexPathSelection: NSIndexPath? = indexPath
        if (delegate?.respondsToSelector(Selector("accordionView:willDeselectRowAtIndexPath:")))!{
            indexPathSelection = delegate?.accordionView!(self, willDeselectRowAtIndexPath: indexPath)
        }
        return indexPathSelection;
    }
    // Called after the user changes the selection.
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if (delegate?.respondsToSelector(Selector("accordionView:didSelectRowAtIndexPath:")))!{
            delegate?.accordionView!(self, didSelectRowAtIndexPath: indexPath)
        }
        print("accordionView:didSelectRowAtIndexPath: Section::\(indexPath.section) Row::\(indexPath.row)")
    }
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        if (delegate?.respondsToSelector(Selector("accordionView:didDeselectRowAtIndexPath:")))!{
            delegate?.accordionView!(self, didDeselectRowAtIndexPath: indexPath)
        }
        print("accordionView:didDeselectRowAtIndexPath: Section::\(indexPath.section) Row::\(indexPath.row)")

    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        var view : UIView! = nil
        if (delegate?.respondsToSelector(Selector("accordionView:viewForHeaderInSection:isSectionOpen:")))! {
            
            let collapsed: Bool! = arrayOfBool?.objectAtIndex(section).boolValue
            
            view = delegate?.accordionView!(self, viewForHeaderInSection: section, isSectionOpen: collapsed)
            view.tag = section;
            
            // tab recognizer
            let headerTapped = UITapGestureRecognizer (target: self, action:"sectionHeaderTapped:")
            view .addGestureRecognizer(headerTapped)
        }
        
        return view
    }
    
}

// MARK: - Implemention of UITableViewDataSource methods
extension MKAccordionView : UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var no : Int! = 0
        
        let collapsed: Bool! = arrayOfBool?.objectAtIndex(section).boolValue

        if collapsed! {
        
            if (dataSource?.respondsToSelector(Selector("accordionView:numberOfRowsInSection:")))! {
                no = dataSource?.accordionView(self, numberOfRowsInSection: section)
            }
        }
        
        return no
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell : UITableViewCell? = nil
        if (dataSource?.respondsToSelector(Selector("accordionView:cellForRowAtIndexPath:")))! {
            cell = (dataSource?.accordionView(self, cellForRowAtIndexPath: indexPath))!
        }
        
        return cell!
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        var numberOfSections : Int! = 1
        if (dataSource?.respondsToSelector(Selector("numberOfSectionsInAccordionView:")))! {
            numberOfSections = dataSource?.numberOfSectionsInAccordionView!(self)
            
            if arrayOfBool == nil {
                arrayOfBool = NSMutableArray()
                let sections : Int! = numberOfSections - 1
                for _ in 0...sections {
                    arrayOfBool?.addObject(NSNumber(bool: false))
                }
            }
            
        }
        return numberOfSections;
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        var title : String! = nil
        
        if (dataSource?.respondsToSelector(Selector("accordionView:titleForHeaderInSection:")))! {
            title = dataSource?.accordionView!(self, titleForHeaderInSection: section)
        }
        
        return title
    }
    
    func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        var title : String! = nil
        
        if (dataSource?.respondsToSelector(Selector("accordionView:titleForFooterInSection:")))! {
            title = dataSource?.accordionView!(self, titleForFooterInSection: section)
        }
        
        return title
    }
    
}


