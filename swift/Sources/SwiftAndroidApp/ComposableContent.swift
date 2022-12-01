//
//  File.swift
//  
//
//  Created by Alsey Coleman Miller on 11/30/22.
//

import Foundation
import Android
import JNI
import java_swift

/// Composable Content
open class ComposableContent: JavaObject {
    
    var activity: SwiftComponentActivity {
        fatalError()
    }
    
    public func setContent() {
        
        var __locals = [jobject]()
        var __args = [jvalue]()
        JNIMethod.CallVoidMethod(
            object: javaObject,
            methodName: "setContent",
            methodSig: "()V",
            methodCache: &JNICache.MethodID.setContent,
            args: &__args,
            locals: &__locals
        )
    }
    
    open func composeContents(compose: (JavaObject, Int32)) {
        text("Hi ✋! \(Date())", compose)
    }
    
    /// Composable Text builder
    ///
    /// `public final void text(java.lang.String, androidx.compose.runtime.Composer, int);`
    public func text(_ text: String, _ compose: (JavaObject, Int32)) {
        
        var __locals = [jobject]()
        var __args = [jvalue]( repeating: jvalue(), count: 3 )
        __args[0] = JNIType.toJava(value: text, locals: &__locals)
        __args[1] = JNIType.toJava(value: compose.0, locals: &__locals )
        __args[2] = JNIType.toJava(value: compose.1, locals: &__locals )
        
        JNIMethod.CallVoidMethod(
            object: javaObject,
            methodName: "text",
            methodSig: "(Ljava/lang/String;Landroidx/compose/runtime/Composer;I)V",
            methodCache: &JNICache.MethodID.text,
            args: &__args,
            locals: &__locals
        )
    }
}

extension ComposableContent {
    
    struct JNICache {
        
        struct MethodID {
            
            static var setContent: jmethodID?
            static var text: jmethodID?
        }
    }
}

extension ComposableContent: JNIListener { }

public extension ComposableContent {
    
    @_silgen_name("Java_com_pureswift_swiftandroid_ComposableContent_bind")
    static func bind(
        _ __env: UnsafeMutablePointer<JNIEnv?>,
        _ __this: jobject?
    ) -> jlong? {
        
        let swiftObject = ComposableContent.init(javaObject: __this)
        return swiftObject.swiftValue().j
    }
    
    @_silgen_name("Java_com_pureswift_swiftandroid_ComposableContent_composeContents")
    static func composeContents(
        _ __env: UnsafeMutablePointer<JNIEnv?>,
        _ __this: jobject?,
        _ __swiftObject: jlong,
        _ __composer: jobject,
        _ __composerInt: jint
    ) {
        
        let composableContent = ComposableContent.swiftObject(from: __swiftObject)
        let composer = JavaObject(javaObject: __composer)
        composableContent?.composeContents(compose: (composer, __composerInt))
    }
    
    @_silgen_name("Java_com_pureswift_swiftandroid_ComposableContent_finalizeNative")
    static func finalize(
        _ __env: UnsafeMutablePointer<JNIEnv?>,
        _ __this: jobject?,
        _ __swiftObject: jlong
    ) {
        
        ComposableContent.release(swiftObject: __swiftObject )
    }
}
