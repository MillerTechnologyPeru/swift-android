package org.pureswift.swiftandroidsupport.recyclerview

import android.support.v7.widget.RecyclerView
import android.view.ViewGroup

class SwiftAdapter: RecyclerView.Adapter<RecyclerView.ViewHolder>() {

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): RecyclerView.ViewHolder {
        return __onCreateViewHolder(parent, viewType)
    }

    override fun getItemViewType(position: Int): Int {
        return __getItemViewType(position)
    }

    override fun getItemCount(): Int {
        return __getItemCount()
    }

    override fun onBindViewHolder(holder: RecyclerView.ViewHolder, position: Int) {
        __onBindViewHolder(holder, position)
    }

    external fun __onCreateViewHolder(parent: ViewGroup, viewType: Int): RecyclerView.ViewHolder

    external fun __getItemCount(): Int

    external fun __onBindViewHolder(holder: RecyclerView.ViewHolder, position: Int)

    external fun __getItemViewType(position: Int): Int
}