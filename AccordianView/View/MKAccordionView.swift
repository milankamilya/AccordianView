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
    
  @objc optional func accordionView(_ accordionView: MKAccordionView, heightForRowAt indexPath: IndexPath) -> CGFloat
  @objc optional func accordionView(_ accordionView: MKAccordionView, heightForHeaderIn section: Int) -> CGFloat
  @objc optional func accordionView(_ accordionView: MKAccordionView, heightForFooterIn section: Int) -> CGFloat
    
  @objc optional func accordionView(_ accordionView: MKAccordionView, shouldHighlightRowAt indexPath: IndexPath) -> Bool
  @objc optional func accordionView(_ accordionView: MKAccordionView, didHighlightRowAt indexPath: IndexPath)
  @objc optional func accordionView(_ accordionView: MKAccordionView, didUnhighlightRowAt indexPath: IndexPath)
    
    // Called before the user changes the selection. Return a new indexPath, or nil, to change the proposed selection.
  @objc optional func accordionView(_ accordionView: MKAccordionView, willSelectRowAt indexPath: IndexPath) -> IndexPath?
  @objc optional func accordionView(_ accordionView: MKAccordionView, willDeselectRowAt indexPath: IndexPath) -> IndexPath?
    // Called after the user changes the selection.
  @objc optional func accordionView(_ accordionView: MKAccordionView, didSelectRowAt indexPath: IndexPath)
  @objc optional func accordionView(_ accordionView: MKAccordionView, didDeselectRowAt indexPath: IndexPath)
    
    
  @objc optional func accordionView(_ accordionView: MKAccordionView, viewForHeaderIn section: Int, isSectionOpen sectionOpen: Bool) -> UIView?
  @objc optional func accordionView(_ accordionView: MKAccordionView, viewForFooterIn section: Int, isSectionOpen sectionOpen: Bool) -> UIView?
}

// MARK: - MKAccordionViewDatasource
@objc protocol MKAccordionViewDatasource : NSObjectProtocol {
    
    func accordionView(_ accordionView: MKAccordionView, numberOfRowsIn section: Int) -> Int
    
    func accordionView(_ accordionView: MKAccordionView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    
  @objc optional func numberOfSectionsInAccordionView(_ accordionView: MKAccordionView) -> Int // Default is 1 if not implemented
    
  @objc optional func accordionView(_ accordionView: MKAccordionView, titleForHeaderIn section: Int) -> String? // fixed font style. use custom view (UILabel) if you want something different
  @objc optional func accordionView(_ accordionView: MKAccordionView, titleForFooterIn section: Int) -> String?
    
}

// MARK: - MKAccordionView Main Definition
class MKAccordionView: UIView {
    
    weak var dataSource: MKAccordionViewDatasource?
    weak var delegate: MKAccordionViewDelegate?
    var tableView : UITableView?
    
    /// If you want to collapse other open sections when a single section get clicked, set true to isCollapsedAllWhenOneIsOpen.
    var isCollapsedAllWhenOneIsOpen : Bool? = false
    
    
    
    fileprivate var arrayOfBool : NSMutableArray?
    private var previousOpenedSection : Int? = -1
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        tableView = UITableView(frame: self.bounds)
        tableView?.delegate = self;
        tableView?.dataSource = self;
        tableView?.alwaysBounceVertical = true
        tableView?.backgroundColor = UIColor.clear
        
        
        self.addSubview(tableView!);
        
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func sectionHeaderTapped(_ recognizer: UITapGestureRecognizer) {
        print("Tapping working")
        print(recognizer.view?.tag ?? "")
      guard let tag = recognizer.view?.tag else { return }
        
      let indexPath = IndexPath(row: 0, section: tag)
        if (indexPath.row == 0) {
            
          var collapsed : Bool! = (arrayOfBool?.object(at: indexPath.section) as AnyObject).boolValue
          collapsed = !collapsed;
            
            if isCollapsedAllWhenOneIsOpen! {
                
                if let previousOpenedSection = previousOpenedSection,
                  previousOpenedSection != -1 {
                    //reload previous opened section animated
                  arrayOfBool?.replaceObject(at: previousOpenedSection, with: NSNumber(value: false))

                  let range = NSMakeRange(previousOpenedSection, 1)
                  let sectionToReload = NSIndexSet(indexesIn: range)
                  tableView?.reloadSections(sectionToReload as IndexSet, with:.fade)
                    
                }
            }
            
            arrayOfBool?.replaceObject(at: indexPath.section, with: NSNumber(value: collapsed))

            
            //reload specific section animated
            let range = NSMakeRange(indexPath.section, 1)
            let sectionToReload = NSIndexSet(indexesIn: range)
            tableView?.reloadSections(sectionToReload as IndexSet, with:.fade)
            
            
            if collapsed! {
              previousOpenedSection = tag
            } else {
              previousOpenedSection = -1
            }
        }
        
    }
}


// MARK: - Implemention of UITableViewDelegate methods
extension MKAccordionView : UITableViewDelegate {
    
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height : CGFloat! = 0.0
        
      let collapsed: Bool! = (arrayOfBool?.object(at: indexPath.section) as AnyObject).boolValue

      if collapsed! {
        height = delegate?.accordionView?(self, heightForRowAt: indexPath)
      }
    
      return height
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        var height : CGFloat! = 0.0
        height = delegate?.accordionView?(self, heightForHeaderIn: section)
        return height
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        var height : CGFloat! = 0.0
        height = delegate?.accordionView?(self, heightForFooterIn: section)
        return height
    }
    
  func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
    
    guard let selection = delegate?.accordionView?(self, shouldHighlightRowAt: indexPath) else { return false }
    return selection
    }
  func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        delegate?.accordionView?(self, didHighlightRowAt: indexPath)
    }
  func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        delegate?.accordionView?(self, didUnhighlightRowAt: indexPath)
    }
    
    // Called before the user changes the selection. Return a new indexPath, or nil, to change the proposed selection.
  func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        var indexPathSelection: IndexPath? = indexPath
        indexPathSelection = delegate?.accordionView!(self, willSelectRowAt: indexPath)
        return indexPathSelection;
    }
  func tableView(_ tableView: UITableView, willDeselectRowAt indexPath: IndexPath) -> IndexPath? {
        var indexPathSelection: IndexPath? = indexPath
        indexPathSelection = delegate?.accordionView?(self, willDeselectRowAt: indexPath)
        return indexPathSelection;
    }
    // Called after the user changes the selection.
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.accordionView?(self, didSelectRowAt: indexPath)
        print("accordionView:didSelectRowAtIndexPath: Section::\(indexPath.section) Row::\(indexPath.row)")
    }
  func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        delegate?.accordionView?(self, didDeselectRowAt: indexPath)
        print("accordionView:didDeselectRowAtIndexPath: Section::\(indexPath.section) Row::\(indexPath.row)")
    }
    
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        var view : UIView! = nil
      
    let collapsed: Bool! = (arrayOfBool?.object(at: section) as AnyObject).boolValue
      
        view = delegate?.accordionView?(self, viewForHeaderIn: section, isSectionOpen: collapsed)
        view.tag = section;
      
        // tab recognizer
    let headerTapped = UITapGestureRecognizer(target: self, action: #selector(self.sectionHeaderTapped(_:)))
        view.addGestureRecognizer(headerTapped)
      
        return view
    }
    
  func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
      var view : UIView! = nil
  
      let collapsed: Bool! = false
      view = delegate?.accordionView?(self, viewForFooterIn: section, isSectionOpen: collapsed)
    
      return view
    }
}

// MARK: - Implemention of UITableViewDataSource methods
extension MKAccordionView : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var no : Int! = 0
        
        let collapsed: Bool! = (arrayOfBool?.object(at: section) as AnyObject).boolValue

        if collapsed! {
          no = dataSource?.accordionView(self, numberOfRowsIn: section)
        }
        
        return no
    }
    
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = dataSource?.accordionView(self, cellForRowAt: indexPath)
      assert( cell != nil, "Please set dataSource of MKAccordionView ")
      return cell!
    }
    
  func numberOfSections(in tableView: UITableView) -> Int {
        
        var numberOfSections : Int! = 1
        numberOfSections = dataSource?.numberOfSectionsInAccordionView?(self)
      
        if arrayOfBool == nil {
            arrayOfBool = NSMutableArray()
            let sections : Int! = numberOfSections - 1
            for _ in 0...sections {
              arrayOfBool?.add(NSNumber(value: false))
            }
        }
            
        return numberOfSections;
    }
    
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
      var title : String! = nil
      title = dataSource?.accordionView?(self, titleForHeaderIn: section)
    
      return title
    }
    
  func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
      var title : String! = nil
      title = dataSource?.accordionView?(self, titleForFooterIn: section)
      return title
    }
    
}


