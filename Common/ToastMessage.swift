//
//  ToastMessage.swift
//  The Unit
//
//  Created by user187351 on 3/12/21.
//

import UIKit

extension UIViewController {

    func showToast(message: String, font: UIFont) {
        let toastlabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height - 425, width: 150, height: 35))
        
        toastlabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastlabel.textColor = UIColor.white
        toastlabel.font = font
        toastlabel.textAlignment = .center
        toastlabel.text = message
        toastlabel.alpha = 1.0
        toastlabel.layer.cornerRadius = 10
        toastlabel.clipsToBounds = true
        self.view.addSubview(toastlabel)
        
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastlabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastlabel.removeFromSuperview()
        })
    }

}
