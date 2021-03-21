//
//  SplashVC.swift
//  The Unit
//
//  Created by user187351 on 3/13/21.
//

import UIKit

class SplashVC: UIViewController {
    @IBOutlet weak var appName: UILabel!
    @IBOutlet weak var splashButton: UIButton!
    
    @IBAction func handleWelcome(_ sender: Any) {
        let mainTabController = storyboard?.instantiateViewController(withIdentifier : "MainController") as! MainController
        mainTabController.selectedViewController = mainTabController.viewControllers?[0]
        present(mainTabController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        appName.font = UIFont(name: "ProzaLibre-SemiBold", size: 35)
        
        splashButton.layer.cornerRadius = 10; splashButton.layer.masksToBounds = true; splashButton.titleLabel?.font = UIFont(name: "ProzaLibre-SemiBold", size: 25)
        
        
        
    }
}
