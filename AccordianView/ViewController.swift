//
//  ViewController.swift
//  AccordionView
//
//  Created by Milan Kamilya on 29/06/15.
//  Copyright (c) 2015 Milan Kamilya. All rights reserved.
//

import UIKit


// MARK: - ViewController Main Definition
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let accordionView : MKAccordionView = MKAccordionView(frame: CGRectMake(0, 22, CGRectGetWidth(view.bounds), CGRectGetHeight(view.bounds)));
        accordionView.delegate = self;
        accordionView.dataSource = self;
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
        return 50
    }
    
    func accordionView(accordionView: MKAccordionView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func accordionView(accordionView: MKAccordionView, viewForHeaderInSection section: Int, isSectionOpen sectionOpen: Bool) -> UIView? {
     
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
    }
    
    func accordionView(accordionView: MKAccordionView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        print("accordionView(accordionView: MKAccordionView, didSelectRowAtIndexPath")
        
    }
    
}
