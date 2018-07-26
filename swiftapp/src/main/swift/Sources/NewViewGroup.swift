//
//  NewViewGroup.swift
//  Android
//
//  Created by Killian Greene on 7/24/18.
//

import Foundation
import java_swift
import java_lang
import java_util
import Android

open class NewViewGroup: Android.View.ViewGroup {
    public required init(javaObject: jobject?) {
        NSLog("NVG: ViewGroup initalized - required")
        super.init(javaObject: javaObject)
    }
    
    public convenience init(context: Android.Content.Context) {
        NSLog("NVG: convenience init with context")
        self.init(javaObject: nil)
        var isNil: Bool = self.javaObject == nil
        NSLog("NVG: Nil test: \(isNil)")
        bindNewObject()
        isNil = self.javaObject == nil
        NSLog("NVG: Nil test: \(isNil)")
    }
    
    open override func addView(child: Android.View.View, width: Int, height: Int) {
        NSLog("NVG: Adding a child")
        super.addView(child: child, width: width, height: height)
    }
    
    open override func addView(_ child: Android.View.View) {
        NSLog("NVG: Adding a child")
        super.addView(child)
    }
    
    open override func onLayout(changed: Bool, l: Int, t: Int, r: Int, b: Int) {
        NSLog("NVG: onLayout called")
        let count: Int = getChildCount()
        var curWidth, curHeight, curLeft, curTop, maxHeight: Int
        
        let childLeft = getPaddingLeft()
        let childRight = getMeasuredWidth() - getPaddingRight()
        let childTop = getPaddingTop()
        let childBottom = getMeasuredHeight() - getPaddingEnd()
        let childWidth = childRight - childLeft
        let childHeight = childBottom - childTop
        
        maxHeight = 0
        curLeft = childLeft
        curTop = childTop
        
        for i in 0...count-1 {
            let child: Android.View.View = getChildAt(index: i)
            
            // Gone: 2, invisible: 1, visible: 0
            if child.getVisibility() == 2 {
                return
            }
            
            // Get max size of child
            child.measure(widthMeasureSpec: childWidth, heightMeasureSpec: childHeight)
            curWidth = child.getMeasuredWidth()
            curHeight = child.getMeasuredHeight()
            if curLeft + curWidth >= childRight {
                curLeft = childLeft
                curTop += maxHeight
                maxHeight = 0
            }
            
            // Make layout
            child.layout(l: curLeft, t: curTop, r: curLeft + curWidth, b: curTop + curHeight)
            // Save max height
            if maxHeight < curHeight {
                maxHeight = curHeight
            }
            curLeft += curWidth
        }
    }
    
    open override func onMeasure(widthMeasureSpec: Int, heightMeasureSpec: Int) {
        let count = getChildCount()
        var maxHeight = 0, maxWidth = 0, childState = 0, mLeftWidth = 0, rowCount = 0
        
        for i in 0...count-1 {
            let child: Android.View.View = getChildAt(index: i)
            
            // Gone: 2, invisible: 1, visible: 0
            if child.getVisibility() == 2 {
                return
            }
            
            // Measure it
            measureChild(child: child, parentWidthMeasureSpec: widthMeasureSpec, parentHeightMeasureSpec: heightMeasureSpec)
            maxWidth += max(maxWidth, child.getMeasuredWidth())
            mLeftWidth += child.getMeasuredWidth()
            
            // TODO: fix device width
            if (mLeftWidth/1200) > rowCount {
                maxHeight += child.getMeasuredHeight()
                rowCount += 1
            } else {
                maxHeight = max(maxHeight, child.getMeasuredHeight())
            }
            childState = combineMeasuredStates(curState: childState, newState: child.getMeasuredState())
        }
        
        //maxHeight = max(maxHeight, getSuggestedMinimumHeight())
        //maxWidth = max(maxWidth, getSuggestedMinimumWidth())
        
        // Report our final dimensions.
        setMeasuredDimension(measuredWidth: resolveSizeAndState(size: maxWidth, measureSpec: widthMeasureSpec, childMeasuredState: childState), measuredHeight: resolveSizeAndState(size: maxHeight, measureSpec: heightMeasureSpec, childMeasuredState: childState << 16))
    }
}









