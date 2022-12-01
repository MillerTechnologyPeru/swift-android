package com.pureswift.swiftandroid

import androidx.compose.runtime.Composable

@SuppressWarnings("JniMissingFunction")
public final class LazyColumnDataSource(private val __swiftObject: Long) {

    fun count(): Int {
        return __count(__swiftObject)
    }

    fun keyForRow(row: Int): Any {
        return __keyForRow(__swiftObject, row)
    }

    @Composable
    fun content(row: Int) {
        __content(__swiftObject, row)
    }

    fun finalize() {
        __finalize(__swiftObject)
    }

    private external fun __count(__swiftObject: Long): Int

    private external fun __keyForRow(__swiftObject: Long, row: Int): Any

    @Composable
    private external fun __content(__swiftObject: Long, row: Int)

    private external fun __finalize(__swiftObject: Long)
}