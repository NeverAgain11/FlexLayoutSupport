//
//  Flex.swift
//  FlexBoxSupport
//
//  Created by Endless Summer on 2021/5/11.
//

import Foundation
import FlexLayout

extension FlexLayout {
    
    private var yoga: YGLayout {
        return view.yoga
    }
    
    //
    // MARK: Flex item addition and definition
    //
    
    /**
     This method adds a flex item (UIView) to a flex container. Internally the methods adds the UIView has subviews and enables flexbox.
    
     - Returns: The added view flex interface
     */
    @discardableResult
    public func addItem() -> Self {
        let view = UIView()
        return addItem(view)
    }
    
    /**
     This method is similar to `addItem(: UIView)` except that it also creates the flex item's UIView. Internally the method creates an
     UIView, adds it has subviews and enables flexbox. This is useful to add a flex item/container easily when you don't need to refer to it later.
    
     - Parameter view: view to add to the flex container
     - Returns: The added view flex interface
     */
    @discardableResult
    public func addItem(_ view: UIView) -> Self {
        self.view.addSubview(view)
        return self
    }
    
    //
    // MARK: Layout / intrinsicSize / sizeThatFits
    //
    
    /**
     The method layout the flex container's children
    
     - Parameter mode: specify the layout mod (LayoutMode).
    */
    public func layout(mode: Flex.LayoutMode = .fitContainer) {
        if case .fitContainer = mode {
            yoga.applyLayout(preservingOrigin: true)
        } else {
            yoga.applyLayout(preservingOrigin: true, dimensionFlexibility: mode == .adjustWidth ? YGDimensionFlexibility.flexibleWidth : YGDimensionFlexibility.flexibleHeight)
        }
    }
    
    /**
     This property controls dynamically if a flexbox's UIView is included or not in the flexbox layouting. When a
     flexbox's UIView is excluded, FlexLayout won't layout the view and its children views.
    */
    public var isIncludedInLayout: Bool {
        get {
            return yoga.isIncludedInLayout
        }
        set {
            yoga.isIncludedInLayout = newValue
        }
    }
    
    /**
     This method controls dynamically if a flexbox's UIView is included or not in the flexbox layouting. When a
     flexbox's UIView is excluded, FlexLayout won't layout the view and its children views.
    
     - Parameter included: true to layout the view
     - Returns:
     */
    @discardableResult
    public func isIncludedInLayout(_ included: Bool) -> Self {
        yoga.isIncludedInLayout = included
        return self
    }

    /**
     The framework is so highly optimized, that flex item are layouted only when a flex property is changed and when flex container
     size change. In the event that you want to force FlexLayout to do a layout of a flex item, you can mark it as dirty
     using `markDirty()`.
     
     Dirty flag propagates to the root of the flexbox tree ensuring that when any item is invalidated its whole subtree will be re-calculated
    
     - Returns: Flex interface
    */
    @discardableResult
    public func markDirty() -> Self {
        yoga.markDirty()
        return self
    }
    
    /**
     Returns the item size when layouted in the specified frame size
    
     - Parameter size: frame size
     - Returns: item size
    */
    public func sizeThatFits(size: CGSize) -> CGSize {
        return yoga.calculateLayout(with: size)
    }
    
    //
    // MARK: Direction, wrap, flow
    //
    
    /**
     The `direction` property establishes the main-axis, thus defining the direction flex items are placed in the flex container.
    
     The `direction` property specifies how flex items are laid out in the flex container, by setting the direction of the flex
     container’s main axis. They can be laid out in two main directions,  like columns vertically or like rows horizontally.
    
     Note that row and row-reverse are affected by the layout direction (see `layoutDirection` property) of the flex container.
     If its text direction is LTR (left to right), row represents the horizontal axis oriented from left to right, and row-reverse
     from right to left; if the direction is rtl, it's the opposite.
    
     - Parameter value: Default value is .column
    */
    @discardableResult
    public func direction(_ value: Flex.Direction) -> Self {
        flex.direction(value)
        return self
    }
    
    /**
     The `wrap` property controls whether the flex container is single-lined or multi-lined, and the direction of the cross-axis, which determines the direction in which the new lines are stacked in.
    
     - Parameter value: Default value is .noWrap
    */
    @discardableResult
    public func wrap(_ value: Flex.Wrap) -> Self {
        flex.wrap(value)
        return self
    }
    
    /**
     Direction defaults to Inherit on all nodes except the root which defaults to LTR. It is up to you to detect the
     user’s preferred direction (most platforms have a standard way of doing this) and setting this direction on the
     root of your layout tree.
    
     - Parameter value: new LayoutDirection
     - Returns:
    */
    @discardableResult
    public func layoutDirection(_ value: Flex.LayoutDirection) -> Self {
        
        flex.layoutDirection(value)
        //}
        return self
    }
    
    //
    // MARK: justity, alignment, position
    //
    
    /**
     The `justifyContent` property defines the alignment along the main-axis of the current line of the flex container.
     It helps distribute extra free space leftover when either all the flex items on a line have reached their maximum
     size. For example, if children are flowing vertically, `justifyContent` controls how they align vertically.
    
     - Parameter value: Default value is .start
    */
    @discardableResult
    public func justifyContent(_ value: Flex.JustifyContent) -> Self {
        flex.justifyContent(value)
        return self
    }
    
    /**
     The `alignItems` property defines how flex items are laid out along the cross axis on the current line.
     Similar to `justifyContent` but for the cross-axis (perpendicular to the main-axis). For example, if
     children are flowing vertically, `alignItems` controls how they align horizontally.
     
     - Parameter value: Default value is .stretch
     */
    @discardableResult
    public func alignItems(_ value: Flex.AlignItems) -> Self {
        flex.alignItems(value)
        return self
    }
    
    /**
     The `alignSelf` property controls how a child aligns in the cross direction, overriding the `alignItems`
     of the parent. For example, if children are flowing vertically, `alignSelf` will control how the flex item
     will align horizontally.
    
     - Parameter value: Default value is .auto
    */
    @discardableResult
    public func alignSelf(_ value: Flex.AlignSelf) -> Self {
        flex.alignSelf(value)
        return self
    }
    
    /**
     The align-content property aligns a flex container’s lines within the flex container when there is extra space
     in the cross-axis, similar to how justifyContent aligns individual items within the main-axis.
     
     - Parameter value: Default value is .start
     */
    @discardableResult
    public func alignContent(_ value: Flex.AlignContent) -> Self {
        flex.alignContent(value)
        return self
    }

    /*@discardableResult
    public func overflow(_ value: Overflow) -> Self {
        yoga.overflow = value.yogaValue
        return self
    }*/
    
    //
    // MARK: grow / shrink / basis
    //
    
    /**
     The `grow` property defines the ability for a flex item to grow if necessary. It accepts a unitless value
     that serves as a proportion. It dictates what amount of the available space inside the flex container the
     item should take up.
    
     - Parameter value: Default value is 0
    */
    @discardableResult
    public func grow(_ value: CGFloat) -> Self {
        yoga.flexGrow = value
       return self
    }
    
    /**
     It specifies the "flex shrink factor", which determines how much the flex item will shrink relative to the
     rest of the flex items in the flex container when there isn't enough space on the main-axis.
    
     When omitted, it is set to 0 and the flex shrink factor is multiplied by the flex `basis` when distributing
     negative space.
    
     A shrink value of 0 keeps the view's size in the main-axis direction. Note that this may cause the view to
     overflow its flex container.
    
     - Parameter value: Default value is 0
    */
    @discardableResult
    public func shrink(_ value: CGFloat) -> Self {
        yoga.flexShrink = value
        return self
    }

    /**
     This property takes the same values as the width and height properties, and specifies the initial size of the
     flex item, before free space is distributed according to the grow and shrink factors.
    
     Specifying `nil` set the basis as `auto`, which means the length is equal to the length of the item. If the
     item has no length specified, the length will be according to its content.
    
     - Parameter value: Default value is 0
    */
    @discardableResult
    public func basis(_ value: CGFloat?) -> Self {
        flex.basis(value)
        return self
    }

    /**
     This property takes the same values as the width and height properties, and specifies the initial size of the
     flex item, before free space is distributed according to the grow and shrink factors.
    
     Specifying `nil` set the basis as `auto`, which means the length is equal to the length of the item. If the
     item has no length specified, the length will be according to its content.
    */
    @discardableResult
    public func basis(_ percent: FPercent) -> Self {
        flex.basis(percent)
        return self
    }

    //
    // MARK: Width / height / height
    //
    
    /**
     The value specifies the view's width in pixels. The value must be non-negative.
    */
    @discardableResult
    public func width(_ value: CGFloat?) -> Self {
        flex.width(value)
        return self
    }
    
    /**
     The value specifies the view's width in percentage of its container width. The value must be non-negative.
     Example: view.flex.width(20%)
     */
    @discardableResult
    public func width(_ percent: FPercent) -> Self {
        flex.width(percent)
        return self
    }
    
    /**
     The value specifies the view's height in pixels. The value must be non-negative.
     */
    @discardableResult
    public func height(_ value: CGFloat?) -> Self {
        flex.height(value)
        return self
    }
    
    /**
     The value specifies the view's height in percentage of its container height. The value must be non-negative.
     Example: view.flex.height(40%)
     */
    @discardableResult
    public func height(_ percent: FPercent) -> Self {
        flex.height(percent)
        return self
    }
    
    /**
     The value specifies view's width and the height in pixels. Values must be non-negative.
     */
    @discardableResult
    public func size(_ size: CGSize?) -> Self {
        flex.size(size)
        return self
    }
    
    /**
     The value specifies the width and the height of the view in pixels, creating a square view. Values must be non-negative.
     */
    @discardableResult
    public func size(_ sideLength: CGFloat) -> Self {
        yoga.width = YGValue(sideLength)
        yoga.height = YGValue(sideLength)
        return self
    }

    /**
     The value specifies the view's minimum width in pixels. The value must be non-negative.
     */
    @discardableResult
    public func minWidth(_ value: CGFloat?) -> Self {
        flex.minWidth(value)
        return self
    }
    
    /**
     The value specifies the view's minimum width in percentage of its container width. The value must be non-negative.
     */
    @discardableResult
    public func minWidth(_ percent: FPercent) -> Self {
        flex.minWidth(percent)
        return self
    }

    /**
     The value specifies the view's maximum width in pixels. The value must be non-negative.
     */
    @discardableResult
    public func maxWidth(_ value: CGFloat?) -> Self {
        flex.maxWidth(value)
        return self
    }
    
    /**
     The value specifies the view's maximum width in percentage of its container width. The value must be non-negative.
     */
    @discardableResult
    public func maxWidth(_ percent: FPercent) -> Self {
        flex.maxWidth(percent)
        return self
    }
    
    /**
     The value specifies the view's minimum height in pixels. The value must be non-negative.
     */
    @discardableResult
    public func minHeight(_ value: CGFloat?) -> Self {
        flex.minHeight(value)
        return self
    }
    
    /**
     The value specifies the view's minimum height in percentage of its container height. The value must be non-negative.
     */
    @discardableResult
    public func minHeight(_ percent: FPercent) -> Self {
        flex.minHeight(percent)
        return self
    }

    /**
     The value specifies the view's maximum height in pixels. The value must be non-negative.
     */
    @discardableResult
    public func maxHeight(_ value: CGFloat?) -> Self {
        flex.maxHeight(value)
        return self
    }
    
    /**
     The value specifies the view's maximum height in percentage of its container height. The value must be non-negative.
     */
    @discardableResult
    public func maxHeight(_ percent: FPercent) -> Self {
        flex.maxHeight(percent)
        return self
    }
    
    /**
     AspectRatio is a property introduced by Yoga that don't exist in CSS. AspectRatio solves the problem of knowing
     one dimension of an element and an aspect ratio, this is very common when it comes to images, videos, and other
     media types. AspectRatio accepts any floating point value > 0, the default is undefined.
    
     - Parameter value:
     - Returns:
    */
    @discardableResult
    public func aspectRatio(_ value: CGFloat?) -> Self {
        yoga.aspectRatio = value != nil ? value! : CGFloat(YGValueUndefined.value)
        return self
    }
    
    /**
     AspectRatio is a property introduced by Yoga that don't exist in CSS. AspectRatio solves the problem of knowing
     one dimension of an element and an aspect ratio, this is very common when it comes to images, videos, and other
     media types. AspectRatio accepts any floating point value > 0, the default is undefined.
    
     - Parameter value:
     - Returns:
    */
    @discardableResult
    public func aspectRatio(of imageView: UIImageView) -> Self {
        if let imageSize = imageView.image?.size {
            yoga.aspectRatio = imageSize.width / imageSize.height
        }
        return self
    }
    
    //
    // MARK: Absolute positionning
    //
    
    /**
     The position property tells Flexbox how you want your item to be positioned within its parent.
     
     - Parameter value: Default value is .relative
     */
    @discardableResult
    public func position(_ value: Flex.Position) -> Self {
        flex.position(value)
        return self
    }
    
    /**
     Set the left edge distance from the container left edge in pixels.
     This method is valid only when the item position is absolute (`view.flex.position(.absolute)`)
     */
    @discardableResult
    public func left(_ value: CGFloat) -> Self {
        yoga.left = YGValue(value)
        return self
    }

    /**
     Set the left edge distance from the container left edge in percentage of its container width.
     This method is valid only when the item position is absolute (`view.flex.position(.absolute)`)
     */
    @discardableResult
    public func left(_ percent: FPercent) -> Self {
        flex.left(percent)
        return self
    }
    
    /**
     Set the top edge distance from the container top edge in pixels.
     This method is valid only when the item position is absolute (`view.flex.position(.absolute)`)
     */
    @discardableResult
    public func top(_ value: CGFloat) -> Self {
        yoga.top = YGValue(value)
        return self
    }

    /**
     Set the top edge distance from the container top edge in percentage of its container height.
     This method is valid only when the item position is absolute (`view.flex.position(.absolute)`)
     */
    @discardableResult
    public func top(_ percent: FPercent) -> Self {
        flex.top(percent)
        return self
    }
    
    /**
     Set the right edge distance from the container right edge in pixels.
     This method is valid only when the item position is absolute (`view.flex.position(.absolute)`)
     */
    @discardableResult
    public func right(_ value: CGFloat) -> Self {
        yoga.right = YGValue(value)
        return self
    }

    /**
     Set the right edge distance from the container right edge in percentage of its container width.
     This method is valid only when the item position is absolute (`view.flex.position(.absolute)`)
     */
    @discardableResult
    public func right(_ percent: FPercent) -> Self {
        flex.right(percent)
        return self
    }

    /**
     Set the bottom edge distance from the container bottom edge in pixels.
     This method is valid only when the item position is absolute (`view.flex.position(.absolute)`)
     */
    @discardableResult
    public func bottom(_ value: CGFloat) -> Self {
        yoga.bottom = YGValue(value)
        return self
    }

    /**
     Set the bottom edge distance from the container bottom edge in percentage of its container height.
     This method is valid only when the item position is absolute (`view.flex.position(.absolute)`)
     */
    @discardableResult
    public func bottom(_ percent: FPercent) -> Self {
        flex.bottom(percent)
        return self
    }
    
    /**
     Set the start edge (LTR=left, RTL=right) distance from the container start edge in pixels.
     This method is valid only when the item position is absolute (`view.flex.position(.absolute)`)
     */
    @discardableResult
    public func start(_ value: CGFloat) -> Self {
        yoga.start = YGValue(value)
        return self
    }

    /**
     Set the start edge (LTR=left, RTL=right) distance from the container start edge in
     percentage of its container width.
     This method is valid only when the item position is absolute (`view.flex.position(.absolute)`)
     */
    @discardableResult
    public func start(_ percent: FPercent) -> Self {
        flex.start(percent)
        return self
    }
    
    /**
     Set the end edge (LTR=right, RTL=left) distance from the container end edge in pixels.
     This method is valid only when the item position is absolute (`view.flex.position(.absolute)`)
     */
    @discardableResult
    public func end(_ value: CGFloat) -> Self {
        yoga.end = YGValue(value)
        return self
    }

    /**
     Set the end edge (LTR=right, RTL=left) distance from the container end edge in
     percentage of its container width.
     This method is valid only when the item position is absolute (`view.flex.position(.absolute)`)
     */
    @discardableResult
    public func end(_ percent: FPercent) -> Self {
        flex.end(percent)
        return self
    }
    
    /**
      Set the left and right edges distance from the container edges in pixels.
      This method is valid only when the item position is absolute (`view.flex.position(.absolute)`)
      */
    @discardableResult
    public func horizontally(_ value: CGFloat) -> Self {
        yoga.left = YGValue(value)
        yoga.right = YGValue(value)
        return self
     }

     /**
      Set the left and right edges distance from the container edges in percentage of its container width.
      This method is valid only when the item position is absolute (`view.flex.position(.absolute)`)
      */
    @discardableResult
    public func horizontally(_ percent: FPercent) -> Self {
        flex.horizontally(percent)
        return self
    }
    
    /**
     Set the top and bottom edges distance from the container edges in pixels.
     This method is valid only when the item position is absolute (`view.flex.position(.absolute)`)
     */
    @discardableResult
    public func vertically(_ value: CGFloat) -> Self {
        yoga.top = YGValue(value)
        yoga.bottom = YGValue(value)
        return self
    }
    
    /**
     Set the top and bottom edges distance from the container edges in percentage of its container height.
     This method is valid only when the item position is absolute (`view.flex.position(.absolute)`)
     */
    @discardableResult
    public func vertically(_ percent: FPercent) -> Self {
        flex.vertically(percent)
        return self
    }
    
    /**
     Set all edges distance from the container edges in pixels.
     This method is valid only when the item position is absolute (`view.flex.position(.absolute)`)
     */
    @discardableResult
    public func all(_ value: CGFloat) -> Self {
        yoga.top = YGValue(value)
        yoga.left = YGValue(value)
        yoga.bottom = YGValue(value)
        yoga.right = YGValue(value)
        return self
    }
    
    /**
     Set all edges distance from the container edges in percentage of its container size.
     This method is valid only when the item position is absolute (`view.flex.position(.absolute)`)
     */
    @discardableResult
    public func all(_ percent: FPercent) -> Self {
        flex.all(percent)
        return self
    }
    
    //
    // MARK: Margins
    //
    
    /**
     Set the top margin. Top margin specify the offset the top edge of the item should have from it’s closest sibling (item) or parent (container).
     */
    @discardableResult
    public func marginTop(_ value: CGFloat) -> Self {
        yoga.marginTop = YGValue(value)
        return self
    }
    
    @discardableResult
    public func marginTop(_ percent: FPercent) -> Self {
        flex.marginTop(percent)
        return self
    }
    
    /**
     Set the left margin. Left margin specify the offset the left edge of the item should have from it’s closest sibling (item) or parent (container).
     */
    @discardableResult
    public func marginLeft(_ value: CGFloat) -> Self {
        yoga.marginLeft = YGValue(value)
        return self
    }
    
    @discardableResult
    public func marginLeft(_ percent: FPercent) -> Self {
        flex.marginLeft(percent)
        return self
    }

    /**
     Set the bottom margin. Bottom margin specify the offset the bottom edge of the item should have from it’s closest sibling (item) or parent (container).
     */
    @discardableResult
    public func marginBottom(_ value: CGFloat) -> Self {
        yoga.marginBottom = YGValue(value)
        return self
    }
    
    @discardableResult
    public func marginBottom(_ percent: FPercent) -> Self {
        flex.marginBottom(percent)
        return self
    }
    
    /**
     Set the right margin. Right margin specify the offset the right edge of the item should have from it’s closest sibling (item) or parent (container).
     */
    @discardableResult
    public func marginRight(_ value: CGFloat) -> Self {
        yoga.marginRight = YGValue(value)
        return self
    }
    
    @discardableResult
    public func marginRight(_ percent: FPercent) -> Self {
        flex.marginRight(percent)
        return self
    }

    /**
     Set the start margin.
     
     Depends on the item `LayoutDirection`:
     * In LTR direction, start margin specify the offset the **left** edge of the item should have from it’s closest sibling (item) or parent (container).
     * IN RTL direction, start margin specify the offset the **right** edge of the item should have from it’s closest sibling (item) or parent (container).
     */
    @discardableResult
    public func marginStart(_ value: CGFloat) -> Self {
        yoga.marginStart = YGValue(value)
        return self
    }
    
    @discardableResult
    public func marginStart(_ percent: FPercent) -> Self {
        flex.marginStart(percent)
        return self
    }
    
    /**
     Set the end margin.
     
     Depends on the item `LayoutDirection`:
     * In LTR direction, end margin specify the offset the **right** edge of the item should have from it’s closest sibling (item) or parent (container).
     * IN RTL direction, end margin specify the offset the **left** edge of the item should have from it’s closest sibling (item) or parent (container).
     */
    @discardableResult
    public func marginEnd(_ value: CGFloat) -> Self {
        yoga.marginEnd = YGValue(value)
        return self
    }
    
    @discardableResult
    public func marginEnd(_ percent: FPercent) -> Self {
        flex.marginEnd(percent)
        return self
    }
    
    /**
     Set the left, right, start and end margins to the specified value.
     */
    @discardableResult
    public func marginHorizontal(_ value: CGFloat) -> Self {
        yoga.marginHorizontal = YGValue(value)
        return self
    }
    
    @discardableResult
    public func marginHorizontal(_ percent: FPercent) -> Self {
        flex.marginHorizontal(percent)
        return self
    }
    
    /**
     Set the top and bottom margins to the specified value.
     */
    @discardableResult
    public func marginVertical(_ value: CGFloat) -> Self {
        yoga.marginVertical = YGValue(value)
        return self
    }
    
    @discardableResult
    public func marginVertical(_ percent: FPercent) -> Self {
        flex.marginVertical(percent)
        return self
    }
    
    /**
     Set all margins using UIEdgeInsets.
     This method is particularly useful to set all margins using iOS 11 `UIView.safeAreaInsets`.
     */
    @discardableResult
    public func margin(_ insets: UIEdgeInsets) -> Self {
        yoga.marginTop = YGValue(insets.top)
        yoga.marginLeft = YGValue(insets.left)
        yoga.marginBottom = YGValue(insets.bottom)
        yoga.marginRight = YGValue(insets.right)
        return self
    }
    
    /**
     Set margins using NSDirectionalEdgeInsets.
     This method is particularly to set all margins using iOS 11 `UIView.directionalLayoutMargins`.
     
     Available only on iOS 11 and higher.
     */
    @available(tvOS 11.0, iOS 11.0, *)
    @discardableResult
    func margin(_ directionalInsets: NSDirectionalEdgeInsets) -> Self {
        yoga.marginTop = YGValue(directionalInsets.top)
        yoga.marginStart = YGValue(directionalInsets.leading)
        yoga.marginBottom = YGValue(directionalInsets.bottom)
        yoga.marginEnd = YGValue(directionalInsets.trailing)
        return self
    }

    /**
     Set all margins to the specified value.
     */
    @discardableResult
    public func margin(_ value: CGFloat) -> Self {
        yoga.margin = YGValue(value)
        return self
    }
    
    @discardableResult
    public func margin(_ percent: FPercent) -> Self {
        flex.margin(percent)
        return self
    }
    
    /**
     Set the individually vertical margins (top, bottom) and horizontal margins (left, right, start, end).
     */
    @discardableResult func margin(_ vertical: CGFloat, _ horizontal: CGFloat) -> Self {
        yoga.marginVertical = YGValue(vertical)
        yoga.marginHorizontal = YGValue(horizontal)
        return self
    }
    
    @discardableResult func margin(_ vertical: FPercent, _ horizontal: FPercent) -> Self {
        flex.marginHorizontal(horizontal)
        flex.marginVertical(vertical)
        return self
    }
    
    /**
     Set the individually top, left, bottom and right margins.
     */
    @discardableResult
    public func margin(_ top: CGFloat, _ left: CGFloat, _ bottom: CGFloat, _ right: CGFloat) -> Self {
        yoga.marginTop = YGValue(top)
        yoga.marginLeft = YGValue(left)
        yoga.marginBottom = YGValue(bottom)
        yoga.marginRight = YGValue(right)
        return self
    }
    
    @discardableResult
    public func margin(_ top: FPercent, _ left: FPercent, _ bottom: FPercent, _ right: FPercent) -> Self {
        flex.margin(top, left, bottom, right)
        return self
    }

    //
    // MARK: Padding
    //
    
    /**
     Set the top padding. Top padding specify the **offset children should have** from the container's top edge.
     */
    @discardableResult
    public func paddingTop(_ value: CGFloat) -> Self {
        yoga.paddingTop = YGValue(value)
        return self
    }

    /**
     Set the left padding. Left padding specify the **offset children should have** from the container's left edge.
     */
    @discardableResult
    public func paddingLeft(_ value: CGFloat) -> Self {
        yoga.paddingLeft = YGValue(value)
        return self
    }

    /**
     Set the bottom padding. Bottom padding specify the **offset children should have** from the container's bottom edge.
     */
    @discardableResult
    public func paddingBottom(_ value: CGFloat) -> Self {
        yoga.paddingBottom = YGValue(value)
        return self
    }

    /**
     Set the top padding. Top padding specify the **offset children should have** from the container's top edge.
     */
    @discardableResult
    public func paddingRight(_ value: CGFloat) -> Self {
        yoga.paddingRight = YGValue(value)
        return self
    }

    /**
     Set the start padding.
     
     Depends on the item `LayoutDirection`:
     * In LTR direction, start padding specify the **offset children should have** from the container's left edge.
     * IN RTL direction, start padding specify the **offset children should have** from the container's right edge.
     */
    @discardableResult
    public func paddingStart(_ value: CGFloat) -> Self {
        yoga.paddingStart = YGValue(value)
        return self
    }

    /**
     Set the end padding.
     
     Depends on the item `LayoutDirection`:
     * In LTR direction, end padding specify the **offset children should have** from the container's right edge.
     * IN RTL direction, end padding specify the **offset children should have** from the container's left edge.
     */
    @discardableResult
    public func paddingEnd(_ value: CGFloat) -> Self {
        yoga.paddingEnd = YGValue(value)
        return self
    }

    /**
     Set the left, right, start and end paddings to the specified value.
     */
    @discardableResult
    public func paddingHorizontal(_ value: CGFloat) -> Self {
        yoga.paddingHorizontal = YGValue(value)
        return self
    }

    /**
     Set the top and bottom paddings to the specified value.
     */
    @discardableResult
    public func paddingVertical(_ value: CGFloat) -> Self {
        yoga.paddingVertical = YGValue(value)
        return self
    }
    
    /**
     Set paddings using UIEdgeInsets.
     This method is particularly useful to set all paddings using iOS 11 `UIView.safeAreaInsets`.
     */
    @discardableResult
    public func padding(_ insets: UIEdgeInsets) -> Self {
        yoga.paddingTop = YGValue(insets.top)
        yoga.paddingLeft = YGValue(insets.left)
        yoga.paddingBottom = YGValue(insets.bottom)
        yoga.paddingRight = YGValue(insets.right)
        return self
    }
    
    /**
     Set paddings using NSDirectionalEdgeInsets.
     This method is particularly to set all paddings using iOS 11 `UIView.directionalLayoutMargins`.
     
     Available only on iOS 11 and higher.
     */
    @available(tvOS 11.0, iOS 11.0, *)
    @discardableResult
    func padding(_ directionalInsets: NSDirectionalEdgeInsets) -> Self {
        yoga.paddingTop = YGValue(directionalInsets.top)
        yoga.paddingStart = YGValue(directionalInsets.leading)
        yoga.paddingBottom = YGValue(directionalInsets.bottom)
        yoga.paddingEnd = YGValue(directionalInsets.trailing)
        return self
    }

    /**
     Set all paddings to the specified value.
     */
    @discardableResult
    public func padding(_ value: CGFloat) -> Self {
        yoga.padding = YGValue(value)
        return self
    }

    /**
     Set the individually vertical paddings (top, bottom) and horizontal paddings (left, right, start, end).
     */
    @discardableResult func padding(_ vertical: CGFloat, _ horizontal: CGFloat) -> Self {
        yoga.paddingVertical = YGValue(vertical)
        yoga.paddingHorizontal = YGValue(horizontal)
        return self
    }
    
    /**
     Set the individually top, horizontal paddings and bottom padding.
     */
    @discardableResult func padding(_ top: CGFloat, _ horizontal: CGFloat, _ bottom: CGFloat) -> Self {
        yoga.paddingTop = YGValue(top)
        yoga.paddingHorizontal = YGValue(horizontal)
        yoga.paddingBottom = YGValue(bottom)
        return self
    }
    
    /**
     Set the individually top, left, bottom and right paddings.
     */
    @discardableResult
    public func padding(_ top: CGFloat, _ left: CGFloat, _ bottom: CGFloat, _ right: CGFloat) -> Self {
        yoga.paddingTop = YGValue(top)
        yoga.paddingLeft = YGValue(left)
        yoga.paddingBottom = YGValue(bottom)
        yoga.paddingRight = YGValue(right)
        return self
    }
    
    //
    // MARK: UIView Visual properties
    //

    /**
     Set the view background color.
    
     - Parameter color: new color
     - Returns: flex interface
    */
    @discardableResult
    public func backgroundColor(_ color: UIColor) -> Self {
        view.backgroundColor = color
        return self
    }
    
    //
    // MARK: Display
    //
    
    /**
     Set the view display or not
     */
    @discardableResult
    public func display(_ value: Flex.Display) -> Self {
        flex.display(value)
        return self
    }
    
}
