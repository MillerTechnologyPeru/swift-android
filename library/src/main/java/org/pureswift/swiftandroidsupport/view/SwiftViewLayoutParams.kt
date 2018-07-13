package org.pureswift.swiftandroidsupport.view

import android.content.res.TypedArray
import android.widget.FrameLayout

class SwiftViewLayoutParams(width: Int, height: Int) : FrameLayout.LayoutParams(width, height) {

    override fun setMargins(left: Int, top: Int, right: Int, bottom: Int) {
        super.setMargins(left, top, right, bottom)
    }

    override fun setMarginStart(start: Int) {
        super.setMarginStart(start)
    }

    override fun getMarginStart(): Int {
        return super.getMarginStart()
    }

    override fun setMarginEnd(end: Int) {
        super.setMarginEnd(end)
    }

    override fun getMarginEnd(): Int {
        return super.getMarginEnd()
    }

    override fun getLayoutDirection(): Int {
        return super.getLayoutDirection()
    }

    override fun setLayoutDirection(layoutDirection: Int) {
        super.setLayoutDirection(layoutDirection)
    }

    override fun isMarginRelative(): Boolean {
        return super.isMarginRelative()
    }

    override fun resolveLayoutDirection(layoutDirection: Int) {
        super.resolveLayoutDirection(layoutDirection)
    }

    override fun setBaseAttributes(a: TypedArray?, widthAttr: Int, heightAttr: Int) {
        super.setBaseAttributes(a, widthAttr, heightAttr)
    }
}