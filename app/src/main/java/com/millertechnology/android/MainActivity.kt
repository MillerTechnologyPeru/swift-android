package com.millertechnology.android

import android.content.pm.PackageManager
import android.support.v7.app.AppCompatActivity
import android.os.Bundle
import android.support.v4.app.ActivityCompat
import android.support.v4.content.ContextCompat
import com.johnholdsworth.swiftbindings.SwiftBluetoothScannerBinding
import org.pureswift.swiftandroidsupport.widget.SwiftBaseAdapter

class MainActivity : AppCompatActivity(), SwiftBluetoothScannerBinding.Responder {

    companion object {

        const val LOCATION_REQUEST_PERMISSION_CODE = 1000

        fun loadNativeDependencies(){
            System.loadLibrary("swiftandroid")
        }
    }

    external fun bind(self: SwiftBluetoothScannerBinding.Responder) : SwiftBluetoothScannerBinding.Listener

    private var listener: SwiftBluetoothScannerBinding.Listener? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        loadNativeDependencies()

        listener = bind(this)

        if ( ContextCompat.checkSelfPermission( this, android.Manifest.permission.ACCESS_FINE_LOCATION ) != PackageManager.PERMISSION_GRANTED ) {

            ActivityCompat.requestPermissions( this, arrayOf(android.Manifest.permission.ACCESS_FINE_LOCATION), LOCATION_REQUEST_PERMISSION_CODE )
        } else {

            val checkedListener = checkNotNull(listener){
                "Listener is null"
            }

            checkedListener.viewDidLoad()
        }
    }

    override fun getCellResource(): Int {
        return R.layout.cell
    }

    override fun getTextViewResource(): Int {
        return R.id.tvDeviceName
    }

    override fun setAdapter(adapter: Any?) {
        val checkedAdapter = checkNotNull(adapter){
            "Adapter is Null"
        }

        //val swiftAdapter = checkedAdapter as SwiftBaseAdapter
        //lvDevices.adapter = swiftAdapter
    }

    override fun onRequestPermissionsResult(requestCode: Int, permissions: Array<out String>, grantResults: IntArray) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults)

        if(requestCode == LOCATION_REQUEST_PERMISSION_CODE && grantResults[0] == PackageManager.PERMISSION_GRANTED){

            val checkedListener = checkNotNull(listener){
                "Listener is null"
            }

            checkedListener.viewDidLoad()
        }
    }
}
