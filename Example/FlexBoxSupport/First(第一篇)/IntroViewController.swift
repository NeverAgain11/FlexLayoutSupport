//
//  IntroViewController.swift
//  FlexLayoutDemo1
//
//  Created by darkhandz on 2018/7/13.
//  Copyright © 2018年 darkhandz. All rights reserved.
//

import UIKit
import FlexLayout


class IntroViewController: UIViewController {
    
    fileprivate var rootFlexContainer = UIView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }
    
    
    private func configUI() {
        view.backgroundColor = .white
        view.addSubview(rootFlexContainer)
        
        let imageView = UIImageView(image: UIImage(named: "flexlayout-logo"))
        
        let segmentedControl = UISegmentedControl(items: ["Intro", "FlexLayout", "PinLayout"])
        segmentedControl.selectedSegmentIndex = 0
        
        let label = UILabel()
        label.text = "Flexbox layouting is simple, powerfull and fast.\n\nFlexLayout syntax is concise and chainable."
//        label.text = ""
        label.numberOfLines = 0
        
        let bottomLabel = UILabel()
        bottomLabel.text = "FlexLayout/yoga is incredibly fast, its even faster than manual layout."
        bottomLabel.numberOfLines = 0
        
        
        FlexLayout(direction: .vertical, background: rootFlexContainer) {
            FlexLayout(direction: .horizontal, background: UIView()) {
//                imageView.layout.width(100).aspectRatio(of: imageView)
//                UIView().layout.height(1/UIScreen.main.scale).backgroundColor(.lightGray)
            }.maxHeight(130).backgroundColor(.purple)
        }.padding(12)
        
        print("rootFlexContainer: ", rootFlexContainer)
//        rootFlexContainer.build {
//            FlexLayout(direction: .horizontal, background: UIView()) {
//                imageView.layout.width(100).aspectRatio(of: imageView)
//                FlexLayout(direction: .vertical, background: UIView()) {
//                    segmentedControl.layout.marginBottom(12)
//                    label.layout.shrink(1)
//                }.layout.shrink(1).marginLeft(12)
//            }.layout.maxHeight(130)
            
//            FlexLayout(direction: .vertical, background: UIView()) {
////                UIView().layout.height(1/UIScreen.main.scale).backgroundColor(.lightGray)
//                bottomLabel.layout.marginTop(60).marginHorizontal(20)
//            }.layout.marginTop(12)
//        }.padding(12)
        
//        rootFlexContainer.layout.padding(12).define { flex in
//            flex.addItem().direction(.row).define { flex in
//                flex.addItem(imageView).width(100).aspectRatio(of: imageView)
//                flex.addItem().paddingLeft(12).grow(1).shrink(1).define { flex in
//                    flex.addItem(segmentedControl).marginBottom(12).grow(1)
//                    flex.addItem(label)
//                }
//            }
//            // 分隔线
//            flex.addItem().height(1).marginTop(12).backgroundColor(.lightGray)
//            flex.addItem(bottomLabel).marginTop(12)
//        }
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if #available(iOS 11, *) {
            rootFlexContainer.layout.margin(view.safeAreaInsets)
        } else {
            rootFlexContainer.layout.margin(topLayoutGuide.length, 0, bottomLayoutGuide.length, 0)
        }
        rootFlexContainer.frame = view.bounds
        rootFlexContainer.layout.layout(mode: .adjustHeight)
    }
}
