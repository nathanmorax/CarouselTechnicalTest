//
//  UIALert.swift
//  CarouselTechnicalTest
//
//  Created by Xcaret Mora on 19/04/24.
//

import UIKit

struct Alert {
    
    static func showAlert(on vc: UIViewController, with title: String, message: String) {
          let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
          alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
          vc.present(alert, animated: true)
       }
}
