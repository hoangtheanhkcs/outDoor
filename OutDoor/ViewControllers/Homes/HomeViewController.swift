//
//  HomeViewController.swift
//  OutDoor
//
//  Created by hoang the anh on 25/07/2023.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController, TopbarButtonDelegate, HomeContainerViewControllerDelegate {
    
    
    @IBOutlet weak var topView: UIView!
    
    @IBOutlet weak var bottomView: UIStackView!
    private var topBarButtons = [TopbarButton]()
    private var homeVC: HomeContainerViewController?
    @IBOutlet weak var topBarStackView: UIStackView!
    private var selectedIndex = 0 {
        didSet {
            topBarButtons[selectedIndex].selected = true
            homeVC?.currentPageIndex = selectedIndex
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubvies()
        selectedIndex = 0
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
       

    }
    
   private func setupSubvies() {
       
       
       
        homeVC = storyboard?.instantiateViewController(withIdentifier: "HomeContainerViewController") as? HomeContainerViewController
        homeVC?.delegateHome = self
        let vcView = homeVC?.view
        vcView?.frame = bottomView.bounds
        addChild(homeVC!)
        bottomView.addArrangedSubview(vcView!)
        homeVC?.didMove(toParent: self)
        
       topView.backgroundColor = Constants.Colors.buttonBackgroundColor.color
       topBarStackView.backgroundColor = .clear
       
       
       
        let topBarButton1 = TopbarButton(title: Constants.Strings.homeContainerTopbarTitleSpotlight)
        let topBarButton2 = TopbarButton(title: Constants.Strings.homeContainerTopbarTitleBreakingNews)
        let topBarButton3 = TopbarButton(title: Constants.Strings.homeContainerTopbarTitleFollowing)
        topBarButtons.append(topBarButton1)
        topBarButtons.append(topBarButton2)
        topBarButtons.append(topBarButton3)
        topBarButtons.forEach({$0.delegate = self})
        topBarStackView.addArrangedSubview(topBarButton1)
        topBarStackView.addArrangedSubview(topBarButton2)
        topBarStackView.addArrangedSubview(topBarButton3)
        
    }
    
   
   
    fileprivate func didReceiveTouch(topbarButton: TopbarButton) {
        let index = topBarButtons.firstIndex(of: topbarButton)
        selectedIndex = index ?? 0
        switch index {
        case 0:
            topBarButtons[1].selected = false
            topBarButtons[2].selected = false
        case 1:
            topBarButtons[0].selected = false
            topBarButtons[2].selected = false
        case 2:
            topBarButtons[0].selected = false
            topBarButtons[1].selected = false
        default:
            break
            
        }
    }
    
    func resetTopBarButton(index: Int) {
        
        selectedIndex = index
        switch index {
        case 0:
            topBarButtons[1].selected = false
            topBarButtons[2].selected = false
        case 1:
            topBarButtons[0].selected = false
            topBarButtons[2].selected = false
        case 2:
            topBarButtons[0].selected = false
            topBarButtons[1].selected = false
        default:
            break
            
        }
    }

}
private protocol TopbarButtonDelegate: class {
    func didReceiveTouch(topbarButton: TopbarButton)
}

private class TopbarButton: UIView {

    var titleButton:String = ""
    weak var delegate: TopbarButtonDelegate?
    let dotView = UIView()
    let touchReceiver = UIButton()
    var selected:Bool = false {
        didSet {
            setupSubview()
        }
    }
    init(title: String) {
        super.init(frame: .zero)
        self.titleButton = title

        touchReceiver.setTitle(titleButton, for: .normal)
        touchReceiver.setupAutolocalization(withKey: titleButton, keyPath: "autolocalizationTitle")
        touchReceiver.changeButtonFont(Constants.Fonts.SFSemibold16)
        touchReceiver.addTarget(self, action: #selector(didReceiveTouch), for: .touchUpInside)
        
        dotView.alpha = 0
        dotView.backgroundColor = .white
        addSubview(touchReceiver)
        addSubview(dotView)
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let dotWidth :CGFloat = 7
        
        touchReceiver.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: 30)
        touchReceiver.layer.cornerRadius = 15
        dotView.frame.size = CGSize(width: dotWidth, height: dotWidth)
        dotView.center.x = touchReceiver.center.x
        dotView.frame.origin.y = touchReceiver.frame.maxY + 15
        dotView.layer.cornerRadius = 3.5
        
    }
    
    func setupSubview() {
        
        if selected {
            touchReceiver.backgroundColor = Constants.Colors.textColorType5.color
            touchReceiver.setTitleColor(Constants.Colors.buttonBackgroundColor.color, for: .normal)
            dotView.alpha = 1
        }else {
            touchReceiver.backgroundColor = .clear
            touchReceiver.setTitleColor(Constants.Colors.textColorType5.color, for: .normal)
            dotView.alpha = 0
        }
    }

    @objc func didReceiveTouch() {
        delegate?.didReceiveTouch(topbarButton: self)
    }

}
