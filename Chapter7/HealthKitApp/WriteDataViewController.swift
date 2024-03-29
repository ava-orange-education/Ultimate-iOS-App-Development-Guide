//
//  WriteDataViewController.swift
//  HealthKitApp
//
//  Created by Surabhi Chopada
//

import UIKit

class WriteDataViewController: UIViewController {

    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func submitClick(_ sender: Any) {
        if heightTextField.text != "" && weightTextField.text != "" {
            guard let heightvalue = heightTextField.text else {
                return
            }
            guard let height = Double(heightvalue) else {
                return
            }

            guard let weightvalue = weightTextField.text else {
                return
            }
            guard let weight = Double(weightvalue) else {
                return
            }
            HealthkitSetup().writeHealthkitData(height: height, weight: weight, completion: { (success) in
                guard success else {
                    return
                }
                self.showAlert(message: "Data saved successfully")
            })
        }
        else {
            self.showAlert(message: "Enter height and weight values")
        }

    }

    func showAlert(message: String) {
            let alertController = UIAlertController(title: "", message: message, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            present(alertController, animated: true, completion: nil)
        }
}
