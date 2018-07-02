package com.millertechnology.android

import android.content.pm.PackageManager
import android.os.Build
import android.support.v7.app.AppCompatActivity
import android.os.Bundle
import com.johnholdsworth.swiftbindings.SwiftBluetoothScannerBinding
import kotlinx.android.synthetic.main.activity_main.*
import org.pureswift.swiftandroidsupport.widget.SwiftBaseAdapter

class MainActivity : AppCompatActivity(), SwiftBluetoothScannerBinding.Responder {

    companion object {

        const val LOCATION_REQUEST_PERMISSION_CODE = 1000
    }

    external fun bind(self: SwiftBluetoothScannerBinding.Responder) : SwiftBluetoothScannerBinding.Listener

    private var listener: SwiftBluetoothScannerBinding.Listener? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        listener = bind(this)

        if ( Build.VERSION.SDK_INT >= Build.VERSION_CODES.M && checkSelfPermission(android.Manifest.permission.ACCESS_FINE_LOCATION) != PackageManager.PERMISSION_GRANTED ) {

            requestPermissions(arrayOf(android.Manifest.permission.ACCESS_FINE_LOCATION), LOCATION_REQUEST_PERMISSION_CODE)
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
            "SwiftRecyclerViewAdapter is Null"
        }

        val swiftAdapter = checkedAdapter as SwiftBaseAdapter
        lvDevices.adapter = swiftAdapter
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
