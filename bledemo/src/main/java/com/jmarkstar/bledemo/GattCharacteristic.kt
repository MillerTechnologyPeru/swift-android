package com.jmarkstar.bledemo

import android.os.Parcelable
import kotlinx.android.parcel.Parcelize

@Parcelize
class GattCharacteristic(val uuid: String): GattInfoItem, Parcelable {

    override fun getGattItemType(): Int {
        return GattInfoItem.GATT_CHARACTERISTIC
    }
}