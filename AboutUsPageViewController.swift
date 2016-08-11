//
//  AboutUsPageViewController.swift
//  carpoolApp_v1.0
//
//  Created by Matt Hills on 7/26/16.
//  Copyright © 2016 Matthew Hills. All rights reserved.
//

import UIKit

class AboutUsPageViewController: UIPageViewController {
        
    private(set) lazy var orderedViewControllers: [UIViewController] = {
        return [self.newPageViewController("AboutUsFirst"),
                self.newPageViewController("AboutUsSecond"),
                self.newPageViewController("AboutUsThird"),
                self.newPageViewController("AboutUsFourth"),
                self.newPageViewController("AboutUsFifth")]
    }()
    
    private func newPageViewController(page: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil) .instantiateViewControllerWithIdentifier("\(page)ViewController")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        self.view.backgroundColor = UIColor.clearColor()
        stylePageControl()
        
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController],
                               direction: .Forward,
                               animated: true,
                               completion: nil)
        }
        
        print(view.bounds.height)
        print(view.bounds.width)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let subViews: NSArray = view.subviews
        var scrollView: UIScrollView? = nil
        var pageControl: UIPageControl? = nil
        
        for view in subViews {
            if (view.isKindOfClass(UIScrollView)) {
                scrollView = view as? UIScrollView
            } else if (view.isKindOfClass(UIPageControl)) {
                pageControl = view as? UIPageControl
            }
        }
        
        if (scrollView != nil && pageControl != nil) {
            scrollView?.frame = view.bounds
            view.bringSubviewToFront(pageControl!)
        }
    }
}

extension AboutUsPageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.indexOf(viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return nil //orderedViewControllers.last
        }
        
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
        
        return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.indexOf(viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count
        
        guard orderedViewControllersCount != nextIndex else {
            return nil //orderedViewControllers.first
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        return orderedViewControllers[nextIndex]
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return orderedViewControllers.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        guard let firstViewController = viewControllers?.first,
            firstViewControllerIndex = orderedViewControllers.indexOf(firstViewController) else {
                return 0
        }
        return firstViewControllerIndex
    }
    
    private func stylePageControl() {
        let pageControl = UIPageControl.appearanceWhenContainedInInstancesOfClasses([self.dynamicType])
        
        pageControl.currentPageIndicatorTintColor = UIColor.lightGrayColor()
        pageControl.pageIndicatorTintColor = UIColor.groupTableViewBackgroundColor()
        pageControl.backgroundColor = UIColor.clearColor()
    }
}
