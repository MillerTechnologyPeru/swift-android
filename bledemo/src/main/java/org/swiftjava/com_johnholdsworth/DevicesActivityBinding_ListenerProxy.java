
/// generated by: genswift.java 'java/lang|java/util|java/sql' 'Sources' '../java' ///

/// interface com.johnholdsworth.swiftbindings.DevicesActivityBinding$Listener ///

package org.swiftjava.com_johnholdsworth;

@SuppressWarnings("JniMissingFunction")
public class DevicesActivityBinding_ListenerProxy implements com.johnholdsworth.swiftbindings.DevicesActivityBinding.Listener {

    // address of proxy object
    long __swiftObject;

    DevicesActivityBinding_ListenerProxy( long __swiftObject ) {
        this.__swiftObject = __swiftObject;
    }

    /// public abstract void com.johnholdsworth.swiftbindings.DevicesActivityBinding$Listener.startDiscovery()

    public native void __startDiscovery( long __swiftObject );

    public void startDiscovery() {
        __startDiscovery( __swiftObject  );
    }

    /// public abstract void com.johnholdsworth.swiftbindings.DevicesActivityBinding$Listener.validateBluetooth()

    public native void __validateBluetooth( long __swiftObject );

    public void validateBluetooth() {
        __validateBluetooth( __swiftObject  );
    }

    public native void __finalize( long __swiftObject );

    public void finalize() {
        __finalize( __swiftObject );
    }

}
