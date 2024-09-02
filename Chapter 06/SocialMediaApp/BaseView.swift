//
//  IntegrationView.swift
//  SocialMediaApp
//
//  Created by Surabhi Chopada on 25/11/2023.
//

import Foundation
import UIKit
import FBSDKLoginKit

final class BaseView: UIView {

    private let stackView: UIStackView = {
        let this = UIStackView()
        this.translatesAutoresizingMaskIntoConstraints = false
        this.axis = .vertical
        this.alignment = .leading
        this.spacing = 14
        return this
    }()

    let loginButton: FBLoginButton = {
        let this = FBLoginButton()
        this.translatesAutoresizingMaskIntoConstraints = false
        return this
    }()

    let profileButton: UIButton = {
        let this = UIButton()
        var configuration = UIButton.Configuration.filled()
        configuration.title = "Profile"
        configuration.baseBackgroundColor = .orange
        this.configuration = configuration
        this.translatesAutoresizingMaskIntoConstraints = false
        return this
    }()

    let shareButton: UIButton = {
        let this = UIButton()
        var configuration = UIButton.Configuration.filled()

        configuration.title = "Share"
        configuration.baseBackgroundColor = .purple
        this.configuration = configuration
        this.translatesAutoresizingMaskIntoConstraints = false
        return this
    }()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup

    private func setupViews() {
        self.backgroundColor = .white
        addSubview(stackView)
        stackView.addArrangedSubview(loginButton)
        stackView.addArrangedSubview(profileButton)
        stackView.addArrangedSubview(shareButton)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),

            profileButton.widthAnchor.constraint(equalToConstant: 210),
            shareButton.widthAnchor.constraint(equalToConstant: 210),

        ])
    }
}
