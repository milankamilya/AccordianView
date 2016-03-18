//
//  ViewController.swift
//  AccordionView
//
//  Created by Milan Kamilya on 29/06/15.
//  Copyright (c) 2015 Milan Kamilya. All rights reserved.
//

import UIKit

public enum TypeOfAccordianView {
    case Classic
    case Formal
}

// MARK: - ViewController Main Definition
class ViewController: UIViewController {

    var typeOfAccordianView: TypeOfAccordianView? = .Formal
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let accordionView : MKAccordionView = MKAccordionView(frame: CGRectMake(10, 22, CGRectGetWidth(view.bounds) - 20, CGRectGetHeight(view.bounds) - 54));
        accordionView.delegate = self;
        accordionView.dataSource = self;
        accordionView.isCollapsedAllWhenOneIsOpen = true
        view.addSubview(accordionView);
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

 
}

// MARK: - Implemention of MKAccordionViewDelegate method
extension ViewController : MKAccordionViewDelegate {
    
    func accordionView(accordionView: MKAccordionView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        switch typeOfAccordianView! {
            case .Classic :
                 return 50
            case .Formal :
                 return 40
        }
    }
    
    func accordionView(accordionView: MKAccordionView, heightForHeaderInSection section: Int) -> CGFloat {
        switch typeOfAccordianView! {
        case .Classic :
            return 50
        case .Formal :
            return 40
        }
    }
    
    func accordionView(accordionView: MKAccordionView, heightForFooterInSection section: Int) -> CGFloat {
        switch typeOfAccordianView! {
        case .Classic :
            return 0
        case .Formal :
            return 12
        }
    }
    
    func accordionView(accordionView: MKAccordionView, viewForHeaderInSection section: Int, isSectionOpen sectionOpen: Bool) -> UIView? {
     
        return getHeaderViewForAccordianType(typeOfAccordianView!, accordionView: accordionView, section: section,  isSectionOpen: sectionOpen);
        
    }
    
    func accordionView(accordionView: MKAccordionView, viewForFooterInSection section: Int, isSectionOpen sectionOpen: Bool) -> UIView? {
        
        switch typeOfAccordianView! {
        case .Classic :
            
            let view : UIView! = UIView(frame: CGRectMake(0, 0, CGRectGetWidth(accordionView.bounds), 0))
            view.backgroundColor = UIColor.clearColor()
            return view
            
        case .Formal :
            let view : UIView! = UIView(frame: CGRectMake(0, 0, CGRectGetWidth(accordionView.bounds), 12))
            view.backgroundColor = UIColor.whiteColor()
            return view
        }
        
    }
    
    func getHeaderViewForAccordianType(type : TypeOfAccordianView, accordionView: MKAccordionView, section: Int, isSectionOpen sectionOpen: Bool) -> UIView {
        switch type {
        case .Classic :
            let view : UIView! = UIView(frame: CGRectMake(0, 0, CGRectGetWidth(accordionView.bounds), 50))
            
            // Background Image
            let bgImageView : UIImageView = UIImageView(frame: view.bounds)
            bgImageView.image = UIImage(named: ( sectionOpen ? "grayBarSelected" : "grayBar"))!
            view.addSubview(bgImageView)
            
            // Arrow Image
            let arrowImageView : UIImageView = UIImageView(frame: CGRectMake(15, 15, 20, 20))
            arrowImageView.image = UIImage(named: ( sectionOpen ? "close" : "open"))!
            view.addSubview(arrowImageView)
            
            
            // Title Label
            let titleLabel : UILabel = UILabel(frame: CGRectMake(50, 0, CGRectGetWidth(view.bounds) - 120, CGRectGetHeight(view.bounds)))
            titleLabel.text = "Process no: \(section)"
            titleLabel.textColor = UIColor.whiteColor()
            view.addSubview(titleLabel)
            
            return view
            
        case .Formal :
            
            let view : UIView! = UIView(frame: CGRectMake(0, 0, CGRectGetWidth(accordionView.bounds), 40))
            view.backgroundColor = UIColor(red: 220.0/255.0, green: 221.0/255.0, blue: 223.0/255.0, alpha: 1.0)
            
            // Image before Home
            let bgImageView : UIImageView = UIImageView(frame: CGRectMake(5, 16, 11, 8))
            bgImageView.image = UIImage(named: ( sectionOpen ? "favorites-pointer" : "favorites-pointer"))!
            view.addSubview(bgImageView)
            
            // Arrow Image
            let arrowImageView : UIImageView = UIImageView(frame: CGRectMake( CGRectGetWidth(view.bounds) - 12 - 10 , 15, 12, 6))
            arrowImageView.image = UIImage(named: ( sectionOpen ? "arrow-down" : "arrow-up"))!
            view.addSubview(arrowImageView)
            
            
            // Title Label
            let titleLabel : UILabel = UILabel(frame: CGRectMake(23, 0, CGRectGetWidth(view.bounds) - 120, CGRectGetHeight(view.bounds)))
            titleLabel.text = "Process no: \(section)"
            titleLabel.textColor = UIColor.blackColor()
            titleLabel.font = UIFont.systemFontOfSize(15, weight: UIFontWeightRegular)
            view.addSubview(titleLabel)
            
            return view
        }
    }
    
}

// MARK: - Implemention of MKAccordionViewDatasource method
extension ViewController : MKAccordionViewDatasource {
    
    func numberOfSectionsInAccordionView(accordionView: MKAccordionView) -> Int {
        return 5 //TODO: count of section array
    }
    
    func accordionView(accordionView: MKAccordionView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func accordionView(accordionView: MKAccordionView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        return getCellForAccordionType(typeOfAccordianView!, accordionView: accordionView, cellForRowAtIndexPath: indexPath)
    }
    
    func accordionView(accordionView: MKAccordionView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        print("accordionView(accordionView: MKAccordionView, didSelectRowAtIndexPath")
        
    }
    
    
    func getCellForAccordionType( accordionType: TypeOfAccordianView, accordionView: MKAccordionView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        switch accordionType {
            
            case .Classic :
                let cell : UITableViewCell? = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: nil)
                //cell?.imageView = UIImageView(image: UIImage(named: "lightGrayBarWithBluestripe"))
                
                // Background view
                let bgView : UIView? = UIView(frame: CGRectMake(0, 0, CGRectGetWidth(accordionView.bounds), 50))
                let bgImageView : UIImageView! = UIImageView(image: UIImage(named: "lightGrayBarWithBluestripe"))
                bgImageView.frame = (bgView?.bounds)!
                bgImageView.contentMode = UIViewContentMode.ScaleToFill
                bgView?.addSubview(bgImageView)
                cell?.backgroundView = bgView
                
                // You can assign cell.selectedBackgroundView also for selected mode
                
                cell?.textLabel?.text = "          subProcess no: \(indexPath.row)"
                return cell!
            
            case .Formal :
                let cell : UITableViewCell? = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: nil)
                
                
                // You can assign cell.selectedBackgroundView also for selected mode
                
                cell?.textLabel?.text = "subProcess no: \(indexPath.row)"
                cell?.textLabel?.font = UIFont.systemFontOfSize(14, weight: UIFontWeightThin)
                return cell!
        }
        
    }
}
