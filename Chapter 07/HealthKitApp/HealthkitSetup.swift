//
//  HealthkitSetup.swift
//  HealthKitApp
//
//  Created by Surabhi Chopada
//

import Foundation
import HealthKit

class HealthkitSetup {

    let healthStore = HKHealthStore()

    func authorizeHealthKit(completion: @escaping (Bool) -> Void) {
        guard HKHealthStore.isHealthDataAvailable() else {
            completion(false)
            return
        }
        guard
            let height = HKObjectType.quantityType(forIdentifier: .height),
            let weight = HKObjectType.quantityType(forIdentifier: .bodyMass),
            let distance = HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning),
            let stepCount = HKObjectType.quantityType(forIdentifier: .stepCount),
            let activeEnergy = HKObjectType.quantityType(forIdentifier: .activeEnergyBurned) else {
            completion(false)
            return
        }

        let typesToWrite: Set<HKSampleType> = [height,
                                               weight]

        let typesToRead: Set<HKObjectType> = [distance,
                                              stepCount,
                                              activeEnergy]

        healthStore.requestAuthorization(toShare: typesToWrite,
                                         read: typesToRead) { (success, error) in
            completion(success)
        }
    }

    func readHealthkitData(for sampleType: HKQuantityType, completion: @escaping (HKQuantity?) -> Void) {
        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        let predicate = HKQuery.predicateForSamples(
            withStart: startOfDay,
            end: now,
            options: .strictStartDate
        )
        let query = HKStatisticsQuery(
            quantityType: sampleType,
            quantitySamplePredicate: predicate,
            options: .cumulativeSum
        ) { _, result, _ in
            guard let result = result, let sum = result.sumQuantity() else {
                completion(nil)
                return
            }
            DispatchQueue.main.async {
                completion(sum)
            }
        }
        healthStore.execute(query)
    }

    func writeHealthkitData(height: Double, weight: Double, completion: @escaping (Bool) -> Void) {
        let date = Date()
        if let heighttype = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.height) {
            let heightvalue = HKQuantity(unit: HKUnit.inch(), doubleValue: height)
            let heightdata = HKQuantitySample(type: heighttype, quantity: heightvalue, start: date, end: date)
            healthStore.save(heightdata, withCompletion: { (success, error) in
                print("Saved Height")
            })
        }

        if let weighttype = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bodyMass) {
            let weightvalue = HKQuantity(unit: HKUnit.pound(), doubleValue: weight)
            let weightdata = HKQuantitySample(type: weighttype, quantity: weightvalue, start: date, end: date)
            healthStore.save(weightdata, withCompletion: { (success, error) in
                DispatchQueue.main.async {
                    completion(success)
                }
                print("Saved Weight")
            })

        }
    }
}
