package org.pureswift.swiftandroidsupport.view

import android.content.Context
import android.view.View
import android.view.ViewGroup
import android.widget.FrameLayout

class SwiftView(context: Context): FrameLayout(context) {

    override fun setBackgroundColor(color: Int) {
        super.setBackgroundColor(color)
    }

    override fun setX(x: Float) {
        super.setX(x)
    }

    override fun getX(): Float {
        return super.getX()
    }

    override fun setY(y: Float) {
        super.setY(y)
    }

    override fun getY(): Float {
        return super.getY()
    }

    fun setLayoutParams(params: SwiftViewLayoutParams) {
        super.setLayoutParams(params)
    }

    override fun getLayoutParams(): SwiftViewLayoutParams {
        return super.getLayoutParams() as SwiftViewLayoutParams
    }

    fun addView(child: SwiftView) {
        super.addView(child)
    }

    fun addView(child: SwiftView, width: Int, height: Int) {
        super.addView(child, width, height)
    }

    fun addView(child: SwiftView, index: Int) {
        super.addView(child, index)
    }

    fun addView(child: SwiftView, params: ViewGroup.LayoutParams) {
        super.addView(child, params)
    }

    fun addView(child: SwiftView, index: Int, params: ViewGroup.LayoutParams) {
        super.addView(child, index, params)
    }
}