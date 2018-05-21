package com.millertechnology.android

import android.support.v7.app.AppCompatActivity
import android.os.Bundle
import com.johnholdsworth.swiftbindings.SwiftBluetoothScannerBinding
import kotlinx.android.synthetic.main.activity_main.*
import swiftandroid.widget.SwiftBaseAdapter

class MainActivity : AppCompatActivity(), SwiftBluetoothScannerBinding.Responder {

    companion object {

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

        val checkedListener = checkNotNull(listener){
            "Listener is null"
        }

        checkedListener.viewDidLoad()
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


        val swiftAdapter = checkedAdapter as SwiftBaseAdapter
        lvDevices.adapter = swiftAdapter
    }
}
