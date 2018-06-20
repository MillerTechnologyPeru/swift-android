package com.johnholdsworth.swiftbindings;

public interface DevicesActivityBinding {
    interface Listener {

        void validateBluetooth();
        void startScan();
        void stopScan();
        void connectToDevice(Object context, Object device);
    }

    // Messages from Swift back to Java Activity
    interface Responder{
        void activateBluetooth();
        void verifyGpsPermission();
        void loadFoundDevice(Object device, Integer rssi);
        void connectionFailure();
    }
}
