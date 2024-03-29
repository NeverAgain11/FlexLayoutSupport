//
//  FlexBuilder.swift
//  FlexLayoutDemo1
//
//  Created by Endless Summer on 2020/11/23.
//  Copyright © 2020 darkhandz. All rights reserved.
//

import Foundation
import FlexLayout
import UIKit

public typealias FlexBuilder = () -> _FlexLayoutElementType

public protocol _FlexLayoutElementType {
    func make() -> [UIView]
}

extension Array: _FlexLayoutElementType where Element: _FlexLayoutElementType {
    
    public func make() -> [UIView] {
        self.flatMap {
            $0.make()
        }
    }
    
}

@resultBuilder
public struct FlexLayoutBuilder {
    
    public static func buildBlock() -> _FlexLayoutElementType {
        MultiLayout([])
    }
    
    public static func buildBlock(_ content: _FlexLayoutElementType) -> _FlexLayoutElementType {
        content
    }
    
    @_disfavoredOverload
    public static func buildBlock(_ content: _FlexLayoutElementType?...) -> _FlexLayoutElementType {
        MultiLayout(content.compactMap { $0 })
    }
    
    @_disfavoredOverload
    public static func buildBlock<C: Collection>(_ contents: C) -> MultiLayout where C.Element : _FlexLayoutElementType {
        MultiLayout(Array(contents))
    }
    
    public static func buildIf(_ content: _FlexLayoutElementType) -> _FlexLayoutElementType  {
        content
    }
    
    public static func buildIf(_ content: _FlexLayoutElementType?) -> _FlexLayoutElementType? {
        content
    }
    
    public static func buildEither(first: _FlexLayoutElementType) -> _FlexLayoutElementType {
        first
    }
    
    public static func buildEither(second: _FlexLayoutElementType) -> _FlexLayoutElementType {
        second
    }
    
}

public struct MultiLayout : _FlexLayoutElementType {
    
    public let elements: [_FlexLayoutElementType?]
    
    init(_ elements: [_FlexLayoutElementType?]) {
        self.elements = elements
    }
    
    public func make() -> [UIView] {
        elements.compactMap { $0 }.flatMap { $0.make() }
    }
}

public struct FlexLayout: _FlexLayoutElementType {
    public func make() -> [UIView] {
        [view]
    }
    
    public enum Direction {
        case vertical
        case horizontal
        
        var direction: Flex.Direction {
            switch self {
            case .vertical:
                return .column
            case .horizontal:
                return .row
            }
        }
    }
    
    let view: UIView
    
    @discardableResult
    public init(direction: Direction, background: UIView = UIView(), @FlexLayoutBuilder builder: FlexBuilder) {
        self.view = background
        
        view.build(builder)
        
        view.flex.direction(direction.direction)
    }
    
    @discardableResult
    init(background: UIView) {
        self.view = background
        
    }
    
    var flex: Flex {
        return view.flex
    }
}

extension Flex {
    @discardableResult
    public func build(@FlexLayoutBuilder _ builder: FlexBuilder) -> Flex  {
        let views = builder().make()
        
        views.forEach { addItem($0) }
        
        return self
    }
}

extension UIView {
    @discardableResult
    public func build(@FlexLayoutBuilder _ builder: FlexBuilder) -> Flex  {
        flex.build(builder)
        return self.flex
    }
    
    public var layout: FlexLayout {
        return FlexLayout(background: self)
    }
}

extension UIView: _FlexLayoutElementType {
    public func make() -> [UIView] {
        [self]
    }
}

//extension BoxKit: _FlexLayoutElementType where Base: UIView {
//    public func make() -> [UIView] {
//        [base]
//    }
//}

//extension Flex: _FlexLayoutElementType {
//    public func make() -> [ViewCapture] {
//        if let view = view {
//            return [ViewCapture(view: view)]
//        }
//        return []
//    }
//
//    public func make() -> [UIView] {
//        if let view = view {
//            return [view]
//        }
//        return []
//    }
//}
