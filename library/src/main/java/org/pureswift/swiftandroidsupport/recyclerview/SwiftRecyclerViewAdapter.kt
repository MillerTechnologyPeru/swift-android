package org.pureswift.swiftandroidsupport.recyclerview

import android.support.v7.widget.RecyclerView
import android.view.ViewGroup

class SwiftRecyclerViewAdapter(private val __swiftObject: Long): RecyclerView.Adapter<RecyclerView.ViewHolder>() {

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): RecyclerView.ViewHolder {
        return __onCreateViewHolder(__swiftObject, parent, viewType)
    }

    override fun getItemViewType(position: Int): Int {
        return __getItemViewType(__swiftObject, position)
    }

    override fun getItemCount(): Int {
        return __getItemCount(__swiftObject)
    }

    override fun onBindViewHolder(holder: RecyclerView.ViewHolder, position: Int) {
        __onBindViewHolder(__swiftObject, holder, position)
    }

    fun finalize() {
        __finalize(__swiftObject)
    }

    private external fun __onCreateViewHolder(__swiftObject: Long, parent: ViewGroup, viewType: Int): RecyclerView.ViewHolder

    private external fun __getItemCount(__swiftObject: Long): Int

    private external fun __onBindViewHolder(__swiftObject: Long, holder: RecyclerView.ViewHolder, position: Int)

    private external fun __getItemViewType(__swiftObject: Long, position: Int): Int

    private external fun __finalize(__swiftObject: Long)
}