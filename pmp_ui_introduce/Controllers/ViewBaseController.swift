//
//  ViewBaseController.swift
//  pmp_ui_introduce
//
//  Created by Student on 12/13/19.
//  Copyright © 2019 Dehtiar_Olekandr. All rights reserved.
//

import UIKit

class ViewBaseController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    public func showError(with text: String) {
        DispatchQueue.main.async {
            let actionCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil);
            let alert = UIAlertController(title: "Error occured", message: text, preferredStyle: .alert);
            alert.addAction(actionCancel);
            self.present(alert, animated: true, completion: nil);
        }
    }
}
