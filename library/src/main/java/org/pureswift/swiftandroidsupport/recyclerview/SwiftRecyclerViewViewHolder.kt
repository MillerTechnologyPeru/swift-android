package org.pureswift.swiftandroidsupport.recyclerview

import android.support.v7.widget.RecyclerView
import android.view.View

class SwiftRecyclerViewViewHolder(private val __swiftObject: Long, itemView: View): RecyclerView.ViewHolder(itemView) {

    fun obtainAdapterPosition(): Int {
        return this.adapterPosition
    }

    fun obtainItemId(): Long {
        return this.itemId
    }

    fun obtainItemViewType(): Int {
        return this.itemViewType
    }

    fun obtainLayoutPosition(): Int {
        return this.layoutPosition
    }

    fun obtainOldPosition(): Int {
        return this.oldPosition
    }

    fun itemIsRecyclable(): Boolean {
        return this.isRecyclable
    }

    fun putIsRecyclable(recyclable: Boolean) {
        this.setIsRecyclable(recyclable)
    }

    fun finalize() {
        __finalize(__swiftObject)
    }

    private external fun __finalize(__swiftObject: Long)
}