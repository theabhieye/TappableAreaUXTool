//
//  TapAreaOverlayRootViewController.swift
//  TappableAreaUXTool
//
//  Created by Abhishek kapoor on 04/01/26.
//

import UIKit

final class DebugTappableButton: UIButton { }

final class TapAreaOverlayRootViewController: UIViewController {
    
    var onRefreshTapped: (() -> Void)?
    var onCloseTapped: (() -> Void)?
    
    private var refreshButton = DebugTappableButton()
    private var onClosedButton = DebugTappableButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureRootView()
        addSubviews()
        setupLayout()
    }
    
    private func configureRootView() {
        view.backgroundColor = .clear
        view.isUserInteractionEnabled = true
    }
    
    private func addSubviews() {
        setupCloseButton()
        setupRefreshButton()
    }
    
    private func setupCloseButton() {
        onClosedButton.backgroundColor = UIColor.red.withAlphaComponent(0.9)
        onClosedButton.layer.cornerRadius = 24
        
        let closeImage = UIImage(systemName: "xmark")
        onClosedButton.setImage(closeImage, for: .normal)
        onClosedButton.tintColor = .white
        onClosedButton.addTarget(self, action: #selector(didClosedTapped), for: .touchUpInside)
        onClosedButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(onClosedButton)
    }
    
    private func setupRefreshButton() {
        refreshButton.backgroundColor = UIColor.orange.withAlphaComponent(0.9)
        refreshButton.layer.cornerRadius = 24
        
        let refreshImage = UIImage(systemName: "arrow.clockwise")
        refreshButton.setImage(refreshImage, for: .normal)
        refreshButton.tintColor = .white
        refreshButton.addTarget(self, action: #selector(didTapRefresh), for: .touchUpInside)
        refreshButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(refreshButton)
    }
    
    @objc func didTapRefresh() {
        onRefreshTapped?()
    }
    
    @objc func didClosedTapped() {
        onCloseTapped?()
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            refreshButton.heightAnchor.constraint(equalToConstant: 48),
            refreshButton.widthAnchor.constraint(equalToConstant: 48),
            refreshButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -48),
            refreshButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 28),
            
            onClosedButton.heightAnchor.constraint(equalToConstant: 48),
            onClosedButton.widthAnchor.constraint(equalToConstant: 48),
            onClosedButton.bottomAnchor.constraint(equalTo: refreshButton.topAnchor, constant: -16),
            onClosedButton.leadingAnchor.constraint(equalTo: refreshButton.leadingAnchor),
        ])
    }
}
