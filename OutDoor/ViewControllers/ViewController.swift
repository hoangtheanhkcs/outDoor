//
//  ViewController.swift
//  OutDoor
//
//  Created by hoang the anh on 20/07/2023.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var slider: UISlider!
    var values:Float = 0
    var timer: Timer?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSubviews()
        sliderAction()
        
    }
    
    private func setupSubviews() {
        imageView.image = UIImage(named: Constants.Images.loadAppImage)
        imageView.contentMode = .scaleToFill
        
        slider.tintColor = Constants.Colors.sliderTintColor.color
        slider.value = 0
        slider.minimumValue = 0
        slider.maximumValue = 500
        slider.maximumTrackTintColor = .white
        slider.setThumbImage(UIImage(), for: .normal)
        
    }
    
    func sliderAction() {
        timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(loadSlider), userInfo: nil, repeats: true)
    }

    @objc private func loadSlider() {
       
        values = values + 1
        slider.value = values
        
        if values > 500 {
            timer?.invalidate()
            slider.isHidden = true
            let vc = storyboard?.instantiateViewController(withIdentifier: "OnboardViewController") as? OnboardViewController
            vc?.modalPresentationStyle = .fullScreen
            present(vc!, animated: true)
        }
    }
    
    
}

