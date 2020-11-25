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
    func make() -> [Flex]
}

extension Array: _FlexLayoutElementType where Element: _FlexLayoutElementType {
    
    public func make() -> [Flex] {
        self.flatMap {
            $0.make()
        }
    }
    
}

@_functionBuilder
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
    
    public func make() -> [Flex] {
        elements.compactMap { $0 }.flatMap { $0.make() }
    }
}

public struct FlexLayout: _FlexLayoutElementType {
    public func make() -> [Flex] {
        [view.flex]
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
        
        view.flex.direction(direction.direction)
        
        view.flex.define { (flex) in
            builder().make().compactMap { $0.view }.forEach { flex.addItem($0) }
        }
        
    }
    
    public var flex: Flex {
        return view.flex
    }
}

extension Flex {
    @discardableResult
    public func build(@FlexLayoutBuilder _ builder: FlexBuilder) -> Flex  {
        define { (flex) in
            builder().make().compactMap { $0.view }.forEach { addItem($0) }
        }
        return self
    }
}

extension UIView {
    @discardableResult
    public func build(@FlexLayoutBuilder _ builder: FlexBuilder) -> Flex  {
        flex.build(builder)
        return self.flex
    }
}

extension UIView: _FlexLayoutElementType {
    public func make() -> [Flex] {
        [flex]
    }
}

extension Flex: _FlexLayoutElementType {
    public func make() -> [Flex] {
        [self]
    }
}
