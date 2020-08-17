//
//  LaunchVCViewController.swift
//  HackSwiftly
//
//  Created by Shreeniket Bendre on 8/16/20.
//  Copyright © 2020 Shreeniket Bendre. All rights reserved.
//

import UIKit

class LaunchVCViewController: UIViewController {
    

    private let imageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 360, height: 200))
        imageView.image = UIImage(named: "logo")
        imageView
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(imageView)
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5, execute: {
            self.animate()
        })
       
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageView.center = view.center
    }
    
    private func animate(){
        
        UIView.animate(withDuration: 1, animations:  {
            let size = self.view.frame.size.width * 6
            let diffX = size - self.view.frame.size.width
            let diffY = self.view.frame.size.height - size
            self.imageView.frame = CGRect(x: -(diffX/2), y: diffY/2, width: size, height: size)
            //self.imageView.frame = CGRect(x: -(diffX/2), y: diffY/2, width: size, height: size)
        })
        UIView.animate(withDuration: 1.5, animations:  {
                 
            self.imageView.alpha = 0
        }, completion: { done in
            if done {
                DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
                    self.performSegue(withIdentifier: "first", sender: self.self)
            })
        }
        })
    }
}

