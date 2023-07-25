//
//  OnboardViewController.swift
//  OutDoor
//
//  Created by hoang the anh on 20/07/2023.
//

import UIKit
import JGProgressHUD

class OnboardViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource, UIScrollViewDelegate {
   
    private let spinner = JGProgressHUD(style: .dark)
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
                pageControl?.currentPage = currentPageIndex
            }else {return}
        }
    }
    var nextpageIndex = 0
    var pageControl : UIPageControl?
    var bottomButton: UIButton?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        delegate = self
        dataSource = self
        let scrollView = view.subviews.first(where: { $0 is UIScrollView }) as? UIScrollView
              scrollView?.delegate = self
        setViewControllers()
        configurePageControl()
        configureButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if currentPageIndex > pageViewControllers.count - 1 {
            currentPageIndex = pageViewControllers.count - 1
        }
        resetPage(index: currentPageIndex, direction: .forward)
    }
    
    func setViewControllers() {
        let onboard1 = storyboard?.instantiateViewController(withIdentifier: "Onboard1") as? Onboard1
        let onboard2 = storyboard?.instantiateViewController(withIdentifier: "Onboard2") as? Onboard2
        let onboard3 = storyboard?.instantiateViewController(withIdentifier: "Onboard3") as? Onboard3
        let onboard4 = storyboard?.instantiateViewController(withIdentifier: "Onboard4") as? Onboard4
        let onboard5 = storyboard?.instantiateViewController(withIdentifier: "Onboard5") as? Onboard5
        pageViewControllers.append(onboard1!)
        pageViewControllers.append(onboard2!)
        pageViewControllers.append(onboard3!)
        pageViewControllers.append(onboard4!)
        pageViewControllers.append(onboard5!)
        
        
    }
    func resetPage(index:Int, direction: UIPageViewController.NavigationDirection) {
        self.setViewControllers([pageViewControllers[index]], direction: direction, animated: true)
    }
    func configurePageControl() {
       pageControl = UIPageControl(frame: CGRect(x: 0,y: UIScreen.main.bounds.maxY - UIScreen.main.bounds.maxY/7, width: UIScreen.main.bounds.width,height: 10))
        pageControl?.numberOfPages = pageViewControllers.count
        pageControl?.currentPage = currentPageIndex
        pageControl?.alpha = 1
        pageControl?.tintColor = UIColor.black
        pageControl?.pageIndicatorTintColor = Constants.Colors.textColorType8.color
        pageControl?.currentPageIndicatorTintColor = Constants.Colors.buttonBackgroundColor.color
        pageControl?.addTarget(self, action: #selector(didTapPageControll), for: .valueChanged)
       
        self.view.addSubview(pageControl!)
    }
    
    @objc private func didTapPageControll() {
       
        currentPageIndex = pageControl!.currentPage
        
    }
    
    func configureButton() {
        let buttonWidth: CGFloat = 60
        bottomButton = UIButton(frame: CGRect(x: view.bounds.width - buttonWidth - 10, y: view.bounds.height - buttonWidth - 30, width: buttonWidth, height: buttonWidth))
        bottomButton?.setImage(UIImage(named: Constants.Images.onboardBottomButton), for: .normal)
        bottomButton?.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        view.addSubview(bottomButton!)
    }
    
    @objc private func didTapButton() {
       
        currentPageIndex = currentPageIndex + 1
        if currentPageIndex > pageViewControllers.count - 1 {
            spinner.show(in: view)
            let userInfo = UserDefaults.standard.value(forKey: "userInfo") as? String ?? ""
            
            print("userInfo \(userInfo)")
            
            if userInfo.count == 0 {
                let vc = storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController
                vc?.modalPresentationStyle = .fullScreen
                present(vc!, animated: true)
            }else {
                DatabaseManager.shared.checkUserExists(with: userInfo) { [weak self] exist in
                    guard let self = self else {return}
                    
                    DispatchQueue.main.async {
                        self.spinner.dismiss()
                    }
                    if exist {
                        let vc = storyboard?.instantiateViewController(withIdentifier: "TabBarViewController") as? TabBarViewController
                        vc?.modalPresentationStyle = .fullScreen
                        present(vc!, animated: true)
                    }else {
                        let vc = storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController
                        vc?.modalPresentationStyle = .fullScreen
                        vc?.delegate = self
                        present(vc!, animated: true)
                    }
                }
            }
            
            
            
          
        }
     
    }

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
                pageControl?.currentPage = currentPageIndex
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

extension OnboardViewController:LoginViewControllerDelegate {
    func presentHomeVC() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "TabBarViewController") as? TabBarViewController
        
        vc?.modalPresentationStyle = .fullScreen
        present(vc!, animated: true)
    }
    
    
}
