//
//  TestingView.swift
//  TappableAreaUXTool
//
//  Created by Abhishek kapoor on 04/01/26.
//

import SwiftUI
import UIKit

import UIKit

class TestingViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupTabView()
        setupButtons()
        setupScrollView()
        setupImageView()
    }

    private func setupTabView() {
        let tabView = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        tabView.view.frame = CGRect(x: 0, y: 100, width: view.frame.width, height: 200)
        
        var viewControllers: [UIViewController] = []
        for id in 11...15 {
            let vc = createTabItem(id: id)
            viewControllers.append(vc)
        }
        
        tabView.setViewControllers([viewControllers.first!], direction: .forward, animated: true, completion: nil)
        addChild(tabView)
        view.addSubview(tabView.view)
        tabView.didMove(toParent: self)
    }
    
    private func createTabItem(id: Int) -> UIViewController {
        let tabItemVC = UIViewController()
        tabItemVC.view.backgroundColor = UIColor.green.withAlphaComponent(0.2)
        
        let label = UILabel()
        label.text = "HI"
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.translatesAutoresizingMaskIntoConstraints = false
        tabItemVC.view.addSubview(label)
        
        let button = UIButton(type: .system)
        button.setTitle("tap \(id)", for: .normal)
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        button.tag = id
        button.translatesAutoresizingMaskIntoConstraints = false
        tabItemVC.view.addSubview(button)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: tabItemVC.view.centerXAnchor),
            label.topAnchor.constraint(equalTo: tabItemVC.view.topAnchor, constant: 20),
            button.centerXAnchor.constraint(equalTo: tabItemVC.view.centerXAnchor),
            button.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 12)
        ])
        
        return tabItemVC
    }
    
    @objc private func buttonTapped(_ sender: UIButton) {
        print("Area id: \(sender.tag)")
    }
    
    private func setupButtons() {
        let area1Button = UIButton(type: .system)
        area1Button.setTitle("Area 1", for: .normal)
        area1Button.addTarget(self, action: #selector(area1Tapped), for: .touchUpInside)
        area1Button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(area1Button)
        
        let area2Label = UILabel()
        area2Label.text = "Area 2"
        area2Label.isUserInteractionEnabled = true
        area2Label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(area2Tapped)))
        area2Label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(area2Label)
        
        NSLayoutConstraint.activate([
            area1Button.topAnchor.constraint(equalTo: view.topAnchor, constant: 320),
            area1Button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            area2Label.topAnchor.constraint(equalTo: area1Button.bottomAnchor, constant: 16),
            area2Label.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    @objc private func area1Tapped() {
        print("Area 1")
        // Simulate TapAreaDebug.enable() behavior here
        TapAreaDebug.enable()
    }
    
    @objc private func area2Tapped() {
        print("Area 2")
    }
    
    private func setupImageView() {
        let imageView = UIImageView(image: UIImage(systemName: "calendar.and.person"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(area4Tapped)))
        view.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 400),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 100),
            imageView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    @objc private func area4Tapped() {
        print("Area 4")
    }
    
    private func setupScrollView() {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        
        var lastView: UIView = contentView
        for id in 5...10 {
            let stackView = UIStackView()
            stackView.axis = .horizontal
            stackView.spacing = 8
            stackView.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(stackView)
            
            let label = UILabel()
            label.text = "HI"
            stackView.addArrangedSubview(label)
            
            let button = UIButton(type: .system)
            button.setTitle("tap \(id)", for: .normal)
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
            button.tag = id
            stackView.addArrangedSubview(button)
            
            NSLayoutConstraint.activate([
                stackView.topAnchor.constraint(equalTo: lastView.bottomAnchor, constant: 16),
                stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
            ])
            
            lastView = stackView
        }
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 500),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
}


//final class TestingViewController: UIHostingController<TestingView> {
    
//}
//
//struct TestingView: View {
//    
//    var body: some View {
//        VStack {
//            
//            TabView {
//                ForEach(11...15, id: \.self) { id in
//                    VStack(spacing: 12) {
//                        Text("HI")
//                            .font(.headline)
//
//                        Button("tap \(id)") {
//                            print("Area id : \(id)")
//                        }
//                    }
//                    .frame(width: 250, height: 180)
//                    .background(Color.green.opacity(0.2))
//                    .cornerRadius(16)
//                }
//            }
//            .frame(height: 200)
//            .tabViewStyle(.page(indexDisplayMode: .automatic))
//            HStack {
//                Text("dsfadsfasd dsasd  sd asd asd s asdfadsf asdf asd")
//                Spacer()
//                Text("Area 2")
//                    .onTapGesture {
//                        print("area 2")
//                    }
//            }
//            Button("area 1") {
//                print("area 1")
//                TapAreaDebug.enable()
//            }
//            
//            HStack {
//                HStack {
//                    Text("dsfadsfasd dsasd  sd asd asd s asdfadsf asdf asd")
//                    Spacer()
//                    Text("Area 3")
//                        .onTapGesture {
//                            print("area 3")
//                        }
//                }
//            }
//            
//            Image(systemName: "calendar.and.person")
//                .resizable(resizingMode: .stretch)
//                .frame(width: 100, height: 100)
//                
//                .onTapGesture {
//                    print("Area 4")
//                }
//            
//            
//            ScrollView {
//                ForEach(5...10, id: \.self) { id in
//                    HStack {
//                        Text("HI")
//                        Button("tap \(id)") {
//                            print("Area id : \(id)")
//                        }
//                    }
//                }
//            }
//            
//
//            
//            
//        }
//        .padding(.all, 40)
//    }
//    
//}
