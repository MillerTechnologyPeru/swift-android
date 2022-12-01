package com.pureswift.swiftandroid

import androidx.activity.compose.setContent
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.material.Text
import androidx.compose.runtime.Composable
import org.pureswift.swiftandroidsupport.app.SwiftComponentActivity

open class ComposableContent(val activity: SwiftComponentActivity) {

    private var __swiftObject: Long = 0L

    init {
        __swiftObject = bind()
    }

    private external fun bind(): Long

    @Composable
    private external fun composeContents(__swiftObject: Long)

    internal fun setContent() {
        activity.setContent {
            composeContents(__swiftObject)
        }
    }

    @Composable
    fun text(text: String) {
        Text(text = text)
    }

    @Composable
    fun lazyColumn(dataSource: LazyColumnDataSource) {
        LazyColumn {
            items(
                count = dataSource.count(),
                key = { dataSource.keyForRow(it) },
                itemContent = { dataSource.content(it) }
            )
        }
    }
}
