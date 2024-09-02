//
//  ProfileViewController.swift
//  SocialMediaApp
//
//  Created by Surabhi Chopada on 25/11/2023.
//

import UIKit
import SDWebImage

class ProfileViewController: UIViewController {

    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    var profileData = NSDictionary()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        profilePic.layer.cornerRadius = profilePic.frame.width/2
        profilePic.clipsToBounds = true
        profilePic.contentMode = .scaleAspectFill
        setupData()
    }

    func setupData(){
        if let firstname = profileData["first_name"] as? String {
            var name = firstname
            if let lastname = profileData["last_name"] as? String {
                name = "\(name) \(lastname)"
            }
            nameLabel.text = name
        }
        if let email = profileData["email"] as? String {
            emailLabel.text = email
        }
        var pictureUrl = ""
        if let picture = profileData["picture"] as? NSDictionary, let data = picture["data"] as? NSDictionary, let url = data["url"] as? String {
            pictureUrl = url
        }
        profilePic.sd_setImage(with: URL(string: pictureUrl))
    }
}
