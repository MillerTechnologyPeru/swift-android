package org.pureswift.swiftandroidsupport.view

import android.content.Context
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
}