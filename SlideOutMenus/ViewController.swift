//
//  ViewController.swift
//  SlideOutMenus
//
//  Created by iOSDevTips on 3/16/17.
//  Copyright © 2017 iOSDevTips. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var isShowing: Bool = false

    let menuView : UIView = {
        let view = UIView()
        view.backgroundColor = .orange
        view.addCustomMenuShadow()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // setup navigation bar:
        navigationItem.title = "Menu"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Show Menu", style: .plain, target: self, action: #selector(handleShowMenu))
        navigationController?.navigationBar.isTranslucent = false
        
        setupViews()
    }
    
    
    var rightAnchor : NSLayoutConstraint?
    
    func setupViews(){
        self.view.backgroundColor = .white
        // add the menu view into the view:
        self.view.addSubview(menuView)
        
        // set our constraints on our view:
        rightAnchor = menuView.rightAnchor.constraint(equalTo: view.leftAnchor, constant: -10)
        rightAnchor?.isActive = true
        
        menuView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        menuView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        menuView.widthAnchor.constraint(equalToConstant: self.view.frame.width/2).isActive = true
        
    }

    func handleShowMenu(){
        // drop the current right anchor:
        rightAnchor?.isActive = false
        
        // assigning the new value and setting it active:
        let constraintUpdate: NSLayoutConstraint = isShowing ? menuView.rightAnchor.constraint(equalTo: view.leftAnchor, constant: -10) : menuView.rightAnchor.constraint(equalTo: self.view.leftAnchor, constant: self.menuView.frame.width)
        rightAnchor = constraintUpdate
        rightAnchor?.isActive = true
        
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 10, options: .curveEaseOut, animations: { 
            self.view.layoutIfNeeded()
        }, completion: nil)
        
        isShowing = !isShowing
        
    }
    
}

extension UIView {
    func addCustomMenuShadow(){
        self.layer.shadowOffset = CGSize(width: 5, height: self.frame.height)
        self.layer.shadowOpacity = 0.1
    }
}

