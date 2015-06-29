//
//  ViewController.swift
//  AccordianView
//
//  Created by Milan Kamilya on 29/06/15.
//  Copyright (c) 2015 innofied. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var accordianView : MKAccordianView = MKAccordianView(frame: CGRectMake(0, 22, CGRectGetWidth(view.bounds), CGRectGetHeight(view.bounds)));
        accordianView.delegate = self;
        accordianView.dataSource = self;
        view.addSubview(accordianView);
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

 
}

extension ViewController : MKAccordianViewDelegate {
    
    func accordianView(accordianView: MKAccordianView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
    func accordianView(accordianView: MKAccordianView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func accordianView(accordianView: MKAccordianView, viewForHeaderInSection section: Int, isSectionOpen sectionOpen: Bool) -> UIView? {
     
        var view : UIView! = UIView(frame: CGRectMake(0, 0, CGRectGetWidth(accordianView.bounds), 50))

        var bgImageView : UIImageView = UIImageView(frame: view.bounds)
        bgImageView.image = UIImage(named: ( sectionOpen ? "grayBarSelected" : "grayBar"))!
        view.addSubview(bgImageView)
        
        return view
        
    }
}

extension ViewController : MKAccordianViewDatasource {
    
    func numberOfSectionsInAccordianView(accordianView: MKAccordianView) -> Int {
        return 5 //TODO: count of section array
    }
    
    func accordianView(accordianView: MKAccordianView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func accordianView(accordianView: MKAccordianView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: nil)
        cell.textLabel?.text = "Row \(indexPath.row)"
        return cell
    }
    
}
