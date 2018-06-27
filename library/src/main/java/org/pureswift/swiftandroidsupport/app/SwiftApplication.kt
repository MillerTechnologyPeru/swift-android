package org.pureswift.swiftandroidsupport.app

import android.app.Application
import android.content.ComponentCallbacks
import android.content.res.Configuration

class SwiftApplication: Application() {

    companion object {
        @JvmStatic fun loadNativeDependencies(libName: String = "swiftandroid"){
            System.loadLibrary(libName)
        }

        init {
            loadNativeDependencies()
        }
    }

    private var __swiftObject: Long = 0L

    override fun onConfigurationChanged(newConfig: Configuration?) {
        super.onConfigurationChanged(newConfig)

        onConfigurationChangedNative(newConfig)
    }

    override fun onCreate() {
        super.onCreate()

        loadNativeDependencies()

        __swiftObject = bind()

        onCreateNative()
    }

    override fun onLowMemory() {
        super.onLowMemory()

        onLowMemoryNative()
    }

    override fun onTerminate() {
        super.onTerminate()

        onTerminateNative()
    }

    override fun onTrimMemory(level: Int) {
        super.onTrimMemory(level)

        onTrimMemoryNative(level)
    }

    override fun registerActivityLifecycleCallbacks(callback: ActivityLifecycleCallbacks?) {
        super.registerActivityLifecycleCallbacks(callback)

        registerActivityLifecycleCallbacksNative(callback)

    }

    override fun unregisterActivityLifecycleCallbacks(callback: ActivityLifecycleCallbacks?) {
        super.unregisterActivityLifecycleCallbacks(callback)

        unregisterActivityLifecycleCallbacksNative(callback)
    }

    override fun registerComponentCallbacks(callback: ComponentCallbacks?) {
        super.registerComponentCallbacks(callback)

        registerComponentCallbacksNative(callback)
    }

    override fun unregisterComponentCallbacks(callback: ComponentCallbacks?) {
        super.unregisterComponentCallbacks(callback)

        unregisterComponentCallbacksNative(callback)
    }

    override fun registerOnProvideAssistDataListener(callback: OnProvideAssistDataListener?) {
        super.registerOnProvideAssistDataListener(callback)

        registerOnProvideAssistDataListenerNative(callback)
    }

    override fun unregisterOnProvideAssistDataListener(callback: OnProvideAssistDataListener?) {
        super.unregisterOnProvideAssistDataListener(callback)

        unregisterOnProvideAssistDataListenerNative(callback)
    }

    fun finalize() {

        finalizeNative(__swiftObject)
    }

    external fun bind(): Long

    external fun onConfigurationChangedNative(newConfig: Configuration?)

    external fun onCreateNative()

    external fun onLowMemoryNative()

    external fun onTerminateNative()

    external fun onTrimMemoryNative(level: Int)

    external fun registerActivityLifecycleCallbacksNative(callback: ActivityLifecycleCallbacks?)

    external fun unregisterActivityLifecycleCallbacksNative(callback: ActivityLifecycleCallbacks?)

    external fun registerComponentCallbacksNative(callback: ComponentCallbacks?)

    external fun unregisterComponentCallbacksNative(callback: ComponentCallbacks?)

    external fun registerOnProvideAssistDataListenerNative(callback: OnProvideAssistDataListener?)

    external fun unregisterOnProvideAssistDataListenerNative(callback: OnProvideAssistDataListener?)

    external fun finalizeNative(__swiftObject: Long)
}