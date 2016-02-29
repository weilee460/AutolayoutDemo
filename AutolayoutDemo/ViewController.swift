//
//  ViewController.swift
//  AutolayoutDemo
//
//  Created by ying on 16/2/26.
//  Copyright © 2016年 ying. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{

    @IBOutlet weak var loginField: UITextField!

    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    var loggedInUser: User? {
        didSet { updateUI()
        }
    }
    
    var secure: Bool = false {
        didSet {
            updateUI()
        }
    }
    
    var image: UIImage? {
        get {
            return imageView.image
        }
        set {
            imageView.image = newValue
            if let constrainedView = imageView
            {
                if let newImage = newValue
                {
                    aspectRatioConstraint = NSLayoutConstraint(item: constrainedView, attribute: .Width, relatedBy: .Equal, toItem: constrainedView, attribute: .Height, multiplier: newImage.aspectRadio, constant: 0)
                }
                else
                {
                    aspectRatioConstraint = nil
                }
            }
        }
    }
    
    var aspectRatioConstraint: NSLayoutConstraint?
    {
        willSet {
            if let existingConstraint = aspectRatioConstraint
            {
                view.removeConstraint(existingConstraint)
            }
        }
        didSet {
            if let newConstraint = aspectRatioConstraint {
                view.addConstraint(newConstraint)
            }
        }
    }
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
   
    @IBOutlet weak var companyLabel: UILabel!
    
    @IBAction func toggleSecurity() {
        secure = !secure
        
    }
    
    @IBAction func login() {
        loggedInUser = User.login(loginField.text ?? "", password: passwordField.text ?? "")
    }
    
    private func updateUI()
    {
        passwordField.secureTextEntry = secure
        passwordLabel.text = secure ? "Secured Password" : "Password"
        nameLabel.text = loggedInUser?.name
        companyLabel.text = loggedInUser?.company
        imageView.image = loggedInUser?.image
    }
    
}

//extension model, add image to model
extension User
{
    var image: UIImage? {
        if let image = UIImage(named: login)
        {
            return image
        }
        else
        {
            return UIImage(named: "unknown_user")
        }
    }
    
}

//extension UIImage
extension UIImage
{
    var aspectRadio: CGFloat
    {
        return (size.height != 0) ? (size.width/size.height) : 0
    }
}


