//
//  ViewController.swift
//  SocialMediaApp
//
//  Created by Surabhi Chopada on 25/11/2023.
//

import UIKit
import FBSDKLoginKit
import FBSDKShareKit

class ViewController: UIViewController,LoginButtonDelegate, SharingDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    let baseView = BaseView()
    var imagePicker = UIImagePickerController()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view = baseView
        baseView.loginButton.delegate = self
        baseView.profileButton.addTarget(self, action: #selector(getProfile), for: .touchUpInside)
        baseView.shareButton.addTarget(self, action: #selector(sharePost), for: .touchUpInside)
        setupView()
    }

    func setupView() {
        if let token = AccessToken.current,
           !token.isExpired {
            baseView.profileButton.isHidden = false
            baseView.shareButton.isHidden = false
        }
        else {
            baseView.profileButton.isHidden = true
            baseView.shareButton.isHidden = true
        }
    }

    // MARK: - Login
    func loginButton(_ loginButton: FBSDKLoginKit.FBLoginButton, didCompleteWith result: FBSDKLoginKit.LoginManagerLoginResult?, error: Error?) {
        setupView()
    }

    func loginButtonDidLogOut(_ loginButton: FBSDKLoginKit.FBLoginButton) {
        setupView()
    }

    // MARK: - Profile
    @objc func getProfile(){
        if AccessToken.current != nil {
            let paramenters = ["fields":"first_name, last_name, email, picture"]
            GraphRequest(graphPath: "me", parameters: paramenters).start { connection, result, error in
                if let result = result {
                    print("Fetched Result: \(result)")
                    let viewController = self.storyboard?.instantiateViewController(withIdentifier: "profileVC") as! ProfileViewController
                    viewController.profileData = result as! NSDictionary
                    self.navigationController?.pushViewController(viewController, animated: true)
                }
            }
        }
    }
    
    // MARK: - sharePost
    @objc func sharePost(){
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = true
            present(imagePicker, animated: true, completion: nil)
        }
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else {
            return
        }
        let photo = SharePhoto(
            image: image,
            isUserGenerated: true
        )
        let content = SharePhotoContent()
        content.photos = [photo]
        self.dismiss(animated: true, completion: { () -> Void in
            let dialog = ShareDialog(
                viewController: self,
                content: content,
                delegate: self
            )
            dialog.show()
        })

    }


    func sharer(_ sharer: FBSDKShareKit.Sharing, didCompleteWithResults results: [String : Any]) {
        print("complete")
    }

    func sharer(_ sharer: FBSDKShareKit.Sharing, didFailWithError error: Error) {
        print("failed",error)
    }

    func sharerDidCancel(_ sharer: FBSDKShareKit.Sharing) {
        print("cancelled")
    }
}
