//
//  LazyColumnDataSource.swift
//  
//
//  Created by Alsey Coleman Miller on 11/30/22.
//

import Foundation
import JNI
import java_swift
import java_lang

/// `LazyColumn` Data Source
public final class LazyColumnDataSource: JavaObject {
        
    internal private(set) var count: () -> Int = { return 0 }
    
    internal private(set) var key: (Int) -> JavaObject = { return JavaString("\($0)") }
    
    internal private(set) var content: (Int, Composer) -> () = { _,_ in }
    
    public convenience init(
        count: @escaping () -> Int,
        key: @escaping (Int) -> JavaObject,
        content: @escaping (Int, Composer) -> ()
    ) {
        self.init(javaObject: nil)
        self.bindNewJavaObject()
        self.count = count
        self.key = key
        self.content = content
    }
    
    required init(javaObject: jobject?) {
        super.init(javaObject: javaObject)
    }
    
    private func bindNewJavaObject() {
        /// Release old swift value.
        let hasOldJavaObject = javaObject != nil
        if hasOldJavaObject {
            try! finalize()
        }
        var locals = [jobject]()
        var args: [jvalue] = [self.swiftValue()]
        guard let object = JNIMethod.NewObject(
            className: JNICache.className,
            classCache: &JNICache.jniClass,
            methodSig: "(J)V",
            methodCache: &JNICache.MethodID.init_method,
            args: &args,
            locals: &locals
        ) else { fatalError("Could not initialize \(JNICache.className)") }
        
        self.javaObject = object // dereference old value, add global ref for new value
        JNI.DeleteLocalRef(object) // delete local ref
    }
}

public extension LazyColumnDataSource {
    
    convenience init<C>(
        _ collection: C,
        key: @escaping (C.Element) -> JavaObject,
        content: @escaping (C.Element, Composer) -> ()
    ) where C: RandomAccessCollection, C.Index == Int {
        self.init(
            count: { collection.count },
            key: { key(collection[$0]) },
            content: { content(collection[$0], $1) }
        )
    }
}

extension LazyColumnDataSource: JNIListener { }

public extension LazyColumnDataSource {
    
    @_silgen_name("Java_com_pureswift_swiftandroid_LazyColumnDataSource__1_1count")
    static func count(
        _ __env: UnsafeMutablePointer<JNIEnv?>,
        _ __this: jobject?,
        _ __swiftObject: jlong
    ) -> jint {
        let object = LazyColumnDataSource.swiftObject(from: __swiftObject)
        return jint((object?.count() ?? 0))
    }
    
    @_silgen_name("Java_com_pureswift_swiftandroid_LazyColumnDataSource__1_1keyForRow")
    static func keyForRow(
        _ __env: UnsafeMutablePointer<JNIEnv?>,
        _ __this: jobject?,
        _ __swiftObject: jlong,
        _ __row: jint
    ) -> jobject? {
        guard let object = LazyColumnDataSource.swiftObject(from: __swiftObject) else {
            fatalError()
        }
        let keyObject = object.key(Int(__row))
        var __locals = [jobject]()
        return keyObject.localJavaObject(&__locals)
    }
    
    @_silgen_name("Java_com_pureswift_swiftandroid_LazyColumnDataSource__1_1content")
    static func contentForRow(
        _ __env: UnsafeMutablePointer<JNIEnv?>,
        _ __this: jobject?,
        _ __swiftObject: jlong,
        _ __row: jint,
        _ __composer: jobject,
        _ __composerInt: jint
    ) {
        let composer = Composer(
            object: __composer,
            intValue: __composerInt
        )
        let object = LazyColumnDataSource.swiftObject(from: __swiftObject)
        object?.content(Int(__row), composer)
    }
}

internal extension LazyColumnDataSource {
    
    struct JNICache {
        
        static let classSignature = ["com", "pureswift", "swiftandroid"] ☕️ ["LazyColumnDataSource"]
                
        /// JNI Java class name
        static let className = classSignature.rawValue
        
        /// JNI Java class
        static var jniClass: jclass?
        
        /// JNI Method ID cache
        struct MethodID {
            
            static var init_method: jmethodID?
        }
    }
}
