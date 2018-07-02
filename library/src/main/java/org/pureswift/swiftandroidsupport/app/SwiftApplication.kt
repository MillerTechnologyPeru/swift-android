package org.pureswift.swiftandroidsupport.app

import android.app.Application
import android.content.ComponentCallbacks
import android.content.res.Configuration

open class SwiftApplication: Application() {

    private var __swiftObject: Long = 0L

    override fun onConfigurationChanged(newConfig: Configuration?) {
        super.onConfigurationChanged(newConfig)

        onConfigurationChangedNative(__swiftObject, newConfig)
    }

    override fun onCreate() {
        super.onCreate()

        __swiftObject = bind()

        onCreateNative(__swiftObject)
    }

    override fun onLowMemory() {
        super.onLowMemory()

        onLowMemoryNative(__swiftObject)
    }

    override fun onTerminate() {
        super.onTerminate()

        onTerminateNative(__swiftObject)
    }

    override fun onTrimMemory(level: Int) {
        super.onTrimMemory(level)

        onTrimMemoryNative(__swiftObject, level)
    }

    override fun registerActivityLifecycleCallbacks(callback: ActivityLifecycleCallbacks?) {
        super.registerActivityLifecycleCallbacks(callback)

        registerActivityLifecycleCallbacksNative(__swiftObject, callback)

    }

    override fun unregisterActivityLifecycleCallbacks(callback: ActivityLifecycleCallbacks?) {
        super.unregisterActivityLifecycleCallbacks(callback)

        unregisterActivityLifecycleCallbacksNative(__swiftObject, callback)
    }

    override fun registerComponentCallbacks(callback: ComponentCallbacks?) {
        super.registerComponentCallbacks(callback)

        registerComponentCallbacksNative(__swiftObject, callback)
    }

    override fun unregisterComponentCallbacks(callback: ComponentCallbacks?) {
        super.unregisterComponentCallbacks(callback)

        unregisterComponentCallbacksNative(__swiftObject, callback)
    }

    override fun registerOnProvideAssistDataListener(callback: OnProvideAssistDataListener?) {
        super.registerOnProvideAssistDataListener(callback)

        registerOnProvideAssistDataListenerNative(__swiftObject, callback)
    }

    override fun unregisterOnProvideAssistDataListener(callback: OnProvideAssistDataListener?) {
        super.unregisterOnProvideAssistDataListener(callback)

        unregisterOnProvideAssistDataListenerNative(__swiftObject, callback)
    }

    fun finalize() {

        finalizeNative(__swiftObject)
    }

    external fun bind(): Long

    external fun onConfigurationChangedNative(__swiftObject: Long, newConfig: Configuration?)

    external fun onCreateNative(__swiftObject: Long)

    external fun onLowMemoryNative(__swiftObject: Long)

    external fun onTerminateNative(__swiftObject: Long)

    external fun onTrimMemoryNative(__swiftObject: Long, level: Int)

    external fun registerActivityLifecycleCallbacksNative(__swiftObject: Long, callback: ActivityLifecycleCallbacks?)

    external fun unregisterActivityLifecycleCallbacksNative(__swiftObject: Long, callback: ActivityLifecycleCallbacks?)

    external fun registerComponentCallbacksNative(__swiftObject: Long, callback: ComponentCallbacks?)

    external fun unregisterComponentCallbacksNative(__swiftObject: Long, callback: ComponentCallbacks?)

    external fun registerOnProvideAssistDataListenerNative(__swiftObject: Long, callback: OnProvideAssistDataListener?)

    external fun unregisterOnProvideAssistDataListenerNative(__swiftObject: Long, callback: OnProvideAssistDataListener?)

    external fun finalizeNative(__swiftObject: Long)
}