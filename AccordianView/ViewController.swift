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

    var typeOfAccordianView = TypeOfAccordianView.Formal
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let accordionView = MKAccordionView(frame: CGRect(x: 10, y: 22, width: view.bounds.width - 20, height: view.bounds.height - 54))
          
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
    
  func accordionView(_ accordionView: MKAccordionView, heightForRowAtIndexPath indexPath: IndexPath) -> CGFloat {
        
        switch typeOfAccordianView {
            case .Classic :
                 return 50
            case .Formal :
                 return 40
        }
    }
    
    func accordionView(_ accordionView: MKAccordionView, heightForHeaderInSection section: Int) -> CGFloat {
        switch typeOfAccordianView {
        case .Classic :
            return 50
        case .Formal :
            return 40
        }
    }
    
    func accordionView(_ accordionView: MKAccordionView, heightForFooterInSection section: Int) -> CGFloat {
        switch typeOfAccordianView {
        case .Classic :
            return 0
        case .Formal :
            return 12
        }
    }
    
    func accordionView(_ accordionView: MKAccordionView, viewForHeaderInSection section: Int, isSectionOpen sectionOpen: Bool) -> UIView? {
     
        return getHeaderViewForAccordianType(typeOfAccordianView, accordionView: accordionView, section: section,  isSectionOpen: sectionOpen);
        
    }
    
    func accordionView(_ accordionView: MKAccordionView, viewForFooterInSection section: Int, isSectionOpen sectionOpen: Bool) -> UIView? {
        
        switch typeOfAccordianView {
        case .Classic :
            
          let view  = UIView(frame: CGRect(x: 0, y:0, width: accordionView.bounds.width, height: 0))
          view.backgroundColor = UIColor.clear
          return view
            
        case .Formal :
          let view : UIView! = UIView(frame: CGRect(x: 0, y:0, width: accordionView.bounds.width, height:12))
          view.backgroundColor = UIColor.white
          return view
        }
        
    }
    
    func getHeaderViewForAccordianType(_ type : TypeOfAccordianView, accordionView: MKAccordionView, section: Int, isSectionOpen sectionOpen: Bool) -> UIView {
        switch type {
        case .Classic :
          let view : UIView! = UIView(frame: CGRect(x: 0, y:0, width: accordionView.bounds.width, height: 50))
            
            // Background Image
            let bgImageView : UIImageView = UIImageView(frame: view.bounds)
            bgImageView.image = UIImage(named: ( sectionOpen ? "grayBarSelected" : "grayBar"))!
            view.addSubview(bgImageView)
            
            // Arrow Image
          let arrowImageView : UIImageView = UIImageView(frame: CGRect(x: 15, y:15, width:20, height:20))
            arrowImageView.image = UIImage(named: ( sectionOpen ? "close" : "open"))!
            view.addSubview(arrowImageView)
            
            
            // Title Label
          let titleLabel : UILabel = UILabel(frame: CGRect(x:50, y:0, width: view.bounds.width - 120, height: view.bounds.height ))
            titleLabel.text = "Process no: \(section)"
            titleLabel.textColor = UIColor.white
            view.addSubview(titleLabel)
            
            return view
            
        case .Formal :
            
          let view : UIView! = UIView(frame: CGRect(x:0, y:0, width: accordionView.bounds.width , height: 40))
            view.backgroundColor = UIColor(red: 220.0/255.0, green: 221.0/255.0, blue: 223.0/255.0, alpha: 1.0)
            
            // Image before Home
          let bgImageView : UIImageView = UIImageView(frame: CGRect(x: 5, y:16, width:11, height:8))
            bgImageView.image = UIImage(named: ( sectionOpen ? "favorites-pointer" : "favorites-pointer"))!
            view.addSubview(bgImageView)
            
            // Arrow Image
          let arrowImageView : UIImageView = UIImageView(frame: CGRect( x: view.bounds.width - 12 - 10 , y: 15, width: 12, height: 6))
            arrowImageView.image = UIImage(named: ( sectionOpen ? "arrow-down" : "arrow-up"))!
            view.addSubview(arrowImageView)
            
            
            // Title Label
          let titleLabel : UILabel = UILabel(frame: CGRect(x: 23, y: 0, width: view.bounds.width - 120, height: view.bounds.height))
          titleLabel.text = "Process no: \(section)"
          titleLabel.textColor = UIColor.black
          titleLabel.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.regular)
            view.addSubview(titleLabel)
            
          return view
        }
    }
    
}

// MARK: - Implemention of MKAccordionViewDatasource method
extension ViewController : MKAccordionViewDatasource {
    
    func numberOfSectionsInAccordionView(_ accordionView: MKAccordionView) -> Int {
        return 5 //TODO: count of section array
    }
    
    func accordionView(_ accordionView: MKAccordionView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func accordionView(_ accordionView: MKAccordionView , cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell {
        
        return getCellForAccordionType(typeOfAccordianView, accordionView: accordionView, cellForRowAtIndexPath: indexPath)
    }
    
    func accordionView(_ accordionView: MKAccordionView, didSelectRowAtIndexPath indexPath: IndexPath) {
        
        print("accordionView(_ accordionView: MKAccordionView, didSelectRowAtIndexPath")
        
    }
    
    
    func getCellForAccordionType(_ accordionType: TypeOfAccordianView, accordionView: MKAccordionView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell {
        
        switch accordionType {
            
            case .Classic :
              let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
              //cell?.imageView = UIImageView(image: UIImage(named: "lightGrayBarWithBluestripe"))
              
              // Background view
              let bgView : UIView? = UIView(frame: CGRect(x:0, y:0, width: accordionView.bounds.width, height: 50))
              let bgImageView : UIImageView! = UIImageView(image: UIImage(named: "lightGrayBarWithBluestripe"))
              bgImageView.frame = (bgView?.bounds)!
              bgImageView.contentMode = .scaleToFill
              bgView?.addSubview(bgImageView)
              cell.backgroundView = bgView
              
              // You can assign cell.selectedBackgroundView also for selected mode
              
              cell.textLabel?.text = "          subProcess no: \(indexPath.row)"
              return cell
          
            case .Formal :
              let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
                
                
                // You can assign cell.selectedBackgroundView also for selected mode
                
              cell.textLabel?.text = "subProcess no: \(indexPath.row)"
              cell.textLabel?.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.thin)
              return cell
        }
        
    }
}
