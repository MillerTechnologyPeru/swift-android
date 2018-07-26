package com.kgr.swiftbindings;

public interface MainActivityBindings {

    // Messages from Java to Swift
    interface Listener {

        void hello();

    }

    // Messages from Swift back to Java Activity
    interface Responder{

    }
}