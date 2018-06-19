package com.johnholdsworth.swiftbindings;

public interface DevicesActivityBinding {
    interface Listener {

        void validateBluetooth();
        void startScan();
        void stopScan();
    }

    // Messages from Swift back to Java Activity
    interface Responder{
        void activateBluetooth();
        void verifyGpsPermission();
    }
}
