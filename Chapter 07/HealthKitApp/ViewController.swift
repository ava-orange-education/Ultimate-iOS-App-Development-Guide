//
//  ViewController.swift
//  HealthKitApp
//
//  Created by Surabhi Chopada
//

import UIKit
import HealthKit

class ViewController: UIViewController {

    @IBOutlet weak var stepValue: UILabel!
    @IBOutlet weak var distanceValue: UILabel!
    @IBOutlet weak var calorieValue: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func authorizehealthkit(_ sender: Any) {
        HealthkitSetup().authorizeHealthKit { (success) in
            guard success else {
                print("HealthKit Authorization Failed")
                return
            }
            print("HealthKit Successfully Authorized")
        }
    }

    @IBAction func readHealthkitData(_ sender: Any) {
        guard let stepsCountSample = HKObjectType.quantityType(forIdentifier: .stepCount) else {
            return
        }

        guard let distanceSample = HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning) else {
            return
        }

        guard let calorieSample = HKObjectType.quantityType(forIdentifier: .activeEnergyBurned) else {
            return
        }

        HealthkitSetup().readHealthkitData(for: stepsCountSample, completion: { (data) in
            guard let steps = data else {
                return
            }
            self.stepValue.text = "Steps - \(steps.doubleValue(for: HKUnit.count()))"
        })

        HealthkitSetup().readHealthkitData(for: distanceSample, completion: { (data) in
            guard let distance = data else {
                return
            }

            self.distanceValue.text = "Distance - \(distance.doubleValue(for: HKUnit.mile()).rounded(.toNearestOrAwayFromZero)) mi"
        })

        HealthkitSetup().readHealthkitData(for: calorieSample, completion: { (data) in
            guard let calories = data else {
                return
            }
            self.calorieValue.text = "Calories - \(calories.doubleValue(for: HKUnit.kilocalorie()).rounded(.toNearestOrAwayFromZero)) kcal"
        })
    }
    
}

