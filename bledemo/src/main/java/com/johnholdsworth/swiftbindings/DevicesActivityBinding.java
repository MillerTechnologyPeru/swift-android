package com.johnholdsworth.swiftbindings;

public interface DevicesActivityBinding {
    interface Listener {

        void validateBluetooth();
        void startDiscovery();
    }

    // Messages from Swift back to Java Activity
    interface Responder{
        void activateBluetooth();
        void verifyGpsPermission();
    }
}
