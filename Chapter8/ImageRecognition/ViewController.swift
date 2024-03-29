//
//  ViewController.swift
//  ImageRecognition
//
//  Created by Surabhi Chopada on 8/01/2024.
//

import UIKit
import CoreML
import Vision

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(
            target: self,
            action: #selector(didTapImage)
        )
        tap.numberOfTapsRequired = 1
        imageView.addGestureRecognizer(tap)
    }

    //MARK: Action
    @objc func didTapImage() {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        present(picker, animated: true)
    }

    //MARK: ImagePicker Delegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            return
        }
        imageView.image = image
        classifyImage(image: image)
    }

    //MARK: Image Classification
    func classifyImage(image: UIImage) {
        guard let ciImage = CIImage(image: image) else { return }
        do {
            let config = MLModelConfiguration()
            let coreMLModel = try MobileNetV2(configuration: config)
            let visionModel = try VNCoreMLModel(for: coreMLModel.model)
            let request = VNCoreMLRequest(model: visionModel) { (request, error) in
                guard let results = request.results as? [VNClassificationObservation], let _ = results.first else {
                    return
                }
                DispatchQueue.main.async {
                    let classifications = results.prefix(2)
                    let descriptions = classifications.map { classification in
                        return String(format: "  (%.2f) %@", classification.confidence, classification.identifier)
                    }
                    self.descriptionLabel.text = "Classification:\n" + descriptions.joined(separator: "\n")
                }
            }

            let handler = VNImageRequestHandler(ciImage: ciImage)
            do {
                try handler.perform([request])
            } catch {
                print("Error performing classification: \(error)")
            }
        }
        catch {
            fatalError("Failed to load model: \(error)")
        }
    }
}

