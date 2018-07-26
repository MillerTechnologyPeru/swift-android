package com.kgr.swiftapp;

import org.pureswift.swiftandroidsupport.app.SwiftApplication;

public class SwiftApp extends SwiftApplication {
    static {
        System.loadLibrary("swiftapp");
    }
}