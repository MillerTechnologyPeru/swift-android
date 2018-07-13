package com.example.swiftbindings;

public interface MainActivitytBindings {

    // Messages from Java to Swift
    interface Listener {

        void hello();

    }

    // Messages from Swift back to Java Activity
    interface Responder{

    }
}
