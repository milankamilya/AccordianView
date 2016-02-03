# AccordianView
Reusable AccordianView in swift. It will take less than 2 min to integrate it with your app.

Click on this GIF to have a full look on how the pull project looks like

[![YouTube Link](https://raw.githubusercontent.com/milankamilya/AccordianView/master/accordionView.gif)](https://www.youtube.com/watch?v=u34Fw9biD3k)

# Installation 
You need do it manually. Download and add the following file to your project.
```
MKAccordionView.swift
```

# Usage
MKAccordionView follows [delegation patterns](https://developer.apple.com/library/ios/referencelibrary/GettingStarted/RoadMapiOS/DesignPatterns.html) like [UITableView](https://developer.apple.com/library/ios/documentation/UIKit/Reference/UITableView_Class/). So, if you have worked with UITableView, it is very easy for you to implement it. As you need to implement few delegate and datasource method of MKAccordionView.  

```swift
// MARK: - Implemention of MKAccordionViewDelegate method
extension ViewController : MKAccordionViewDelegate {
    
    func accordionView(accordionView: MKAccordionView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
    func accordionView(accordionView: MKAccordionView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func accordionView(accordionView: MKAccordionView, viewForHeaderInSection section: Int, isSectionOpen sectionOpen: Bool) -> UIView? {
     
        var view : UIView! = UIView(frame: CGRectMake(0, 0, CGRectGetWidth(accordionView.bounds), 50))

        // Customize section header view according to your need
        // "sectionOpen" will let you know section header is expended or collapsed. And you can change the 
        //  background color / image accordingly
        
        return view
        
    }
}
```

As we need to implement UITableviewDatasource in case of UITableView, here we need to do the same.

```swift
// MARK: - Implemention of MKAccordionViewDatasource method
extension ViewController : MKAccordionViewDatasource {
    
    func numberOfSectionsInAccordionView(accordionView: MKAccordionView) -> Int {
        return <# No of Sections #>
    }
    
    func accordionView(accordionView: MKAccordionView, numberOfRowsInSection section: Int) -> Int {
        return <# No of rows of a specific section #>
    }
    
    func accordionView(accordionView: MKAccordionView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell : UITableViewCell? = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: nil)
        
        // Customize cell according to your use
        
        return cell!
    }
}
```
When you are going to initialize the MKAccordionView, don’t forget to set delegate and datasource to self. Next add the object to view.
```swift
var accordionView : MKAccordionView = MKAccordionView(frame: CGRectMake(0, 22, CGRectGetWidth(view.bounds), CGRectGetHeight(view.bounds)))
accordionView.delegate = self
accordionView.dataSource = self
view.addSubview(accordionView)
```
[Find it difficult to implement?](http://innofied.com/accordion-view-ios)

# License
AccordianView is under MIT license so feel free to use it!

# Author
Created by [Milan Kamilya](https://github.com/milankamilya). Please feel free to drop an email if you have any question.
milan.kamilya@innofied.com  or  tweet me [@Milan_Kamilya](https://twitter.com/Milan_Kamilya) 
