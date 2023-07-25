//
//  HomeViewController.swift
//  OutDoor
//
//  Created by hoang the anh on 25/07/2023.
//

import UIKit

protocol HomeContainerViewControllerDelegate: class {
    
    func resetTopBarButton(index: Int)
    
}

class HomeContainerViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource, UIScrollViewDelegate {

    private var pageViewControllers :[UIViewController] = []
    var percentComplete:CGFloat = 0
    var currentPageIndex = 0 {
        didSet {
            
            if currentPageIndex <= pageViewControllers.count - 1 {
                if currentPageIndex < oldValue {
                    resetPage(index: currentPageIndex, direction: .reverse)
                    
                }else {
                    resetPage(index: currentPageIndex, direction: .forward)
                }
               
            }else {return}
        }
    }
    var nextpageIndex = 0
    weak var delegateHome: HomeContainerViewControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        delegate = self
        dataSource = self
        let scrollView = view.subviews.first(where: { $0 is UIScrollView }) as? UIScrollView
              scrollView?.delegate = self
        setViewControllers()
       
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if currentPageIndex > pageViewControllers.count - 1 {
            currentPageIndex = pageViewControllers.count - 1
        }
        resetPage(index: currentPageIndex, direction: .forward)
    }
    
    func setViewControllers() {
        let spotlightVC = storyboard?.instantiateViewController(withIdentifier: "SpotlightViewController") as? SpotlightViewController
        let breakingNewVC = storyboard?.instantiateViewController(withIdentifier: "BreakingNewsViewController") as? BreakingNewsViewController
        let followingVC = storyboard?.instantiateViewController(withIdentifier: "FollowingViewController") as? FollowingViewController
      
        pageViewControllers.append(spotlightVC!)
        pageViewControllers.append(breakingNewVC!)
        pageViewControllers.append(followingVC!)
        
        
        
    }
    func resetPage(index:Int, direction: UIPageViewController.NavigationDirection) {
        self.setViewControllers([pageViewControllers[index]], direction: direction, animated: true)

    }
    

    
}

extension HomeContainerViewController {
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pageViewControllers.count
    }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
            let currentIndex:Int = pageViewControllers.firstIndex(of: viewController) ?? 0
            if currentIndex <= 0 {
                return nil
            }
            return pageViewControllers[currentIndex - 1]
        }
        func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
            let currentIndex:Int = pageViewControllers.firstIndex(of: viewController) ?? 0
            if currentIndex >= pageViewControllers.count - 1 {
                return nil
            }
            return pageViewControllers[currentIndex + 1]
        }
        

        
        func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
            let index = pageViewControllers.firstIndex(of: pendingViewControllers.first!) ?? 0
            nextpageIndex = index
    
        }
        
        func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
            if completed {
                currentPageIndex = pageViewControllers.firstIndex(of: viewControllers![0]) ?? 0
                delegateHome?.resetTopBarButton(index: currentPageIndex)
            }
            
        }
        
        func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
            let Xoffset = scrollView.contentOffset.x
            let viewWidth = scrollView.bounds.width
            
            if (currentPageIndex == 0 && Xoffset < viewWidth || currentPageIndex == pageViewControllers.count - 1 && Xoffset > viewWidth) {
                targetContentOffset.pointee = CGPoint(x: viewWidth, y: 0)
            }
        }
}
