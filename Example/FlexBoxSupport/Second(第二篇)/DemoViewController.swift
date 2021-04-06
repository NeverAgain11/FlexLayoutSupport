//
//  DemoViewController.swift
//  FlexBoxSupport_Example
//
//  Created by Endless Summer on 2021/4/2.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation

final class DemoViewController: UIViewController {
    fileprivate var rootFlex = UIView()
    
    //MARK: UIViewController 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if #available(iOS 11.0, *) {
            rootFlex.flex.marginTop(view.safeAreaInsets.top)
        } else {
            rootFlex.flex.marginTop(topLayoutGuide.length)
        }
        rootFlex.frame = view.bounds
        rootFlex.flex.layout()
    }
}

private extension DemoViewController {
    func setupUI() {
        view.addSubview(rootFlex)
        rootFlex.backgroundColor = .black
        
        let v = UIView()
        let a = UIView()
        FlexLayout(direction: .vertical, background: rootFlex) {
            UIView().then {
                $0.flex.height(100).backgroundColor(.purple).marginBottom(10)
            }
            
            FlexLayout(direction: .horizontal, background: UIView()) {
                UIView().then {
                    $0.backgroundColor = .yellow
                    $0.flex.height(400)
                }
            }
            UIView().then {
                $0.backgroundColor = .yellow
                $0.flex.height(400)
            }
            
        }
    }

    func setupData() {
    
    }
}
