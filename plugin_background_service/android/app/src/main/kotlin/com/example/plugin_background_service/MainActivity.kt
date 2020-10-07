package com.example.plugin_background_service

import android.Manifest
import android.content.Context
import android.content.ContextWrapper
import android.content.Intent
import android.content.IntentFilter
import android.content.pm.PackageManager
import android.location.Location
import android.location.LocationListener
import android.location.LocationManager
import android.location.LocationProvider
import android.os.BatteryManager
import android.os.Build
import android.os.Build.VERSION
import android.os.Build.VERSION_CODES
import android.os.Bundle
import android.widget.Toast
import androidx.annotation.NonNull
import androidx.core.app.ActivityCompat
import io.flutter.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel


class MainActivity: FlutterActivity() {
    private var geoLocation = ""
    private val CHANNEL = "backgroundServices"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
            // Note: this method is invoked on the main thread.
            call, result ->
            if (call.method == "getBatteryLevel") {
                val batteryLevel = getBatteryLevel()

                if (batteryLevel != -1) {
                    result.success(batteryLevel)
                } else {
                    result.error("UNAVAILABLE", "Battery level not available.", null)
                }
            } else {
                if (call.method == "getGeoLocation") {
                    val geoLocation = getGeoLocation()
                    if (geoLocation != "") {
                        result.success(geoLocation)
                    } else {
                        result.error("UNAVAILABLE", "Geolocation not available.", null)
                    }
                } else {
                    result.notImplemented()
                }
            }
        }
    }

    private fun getBatteryLevel(): Int {
        val batteryLevel: Int
        if (VERSION.SDK_INT >= VERSION_CODES.LOLLIPOP) {
            val batteryManager = getSystemService(Context.BATTERY_SERVICE) as BatteryManager
            batteryLevel = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
        } else {
            val intent = ContextWrapper(applicationContext).registerReceiver(null, IntentFilter(Intent.ACTION_BATTERY_CHANGED))
            batteryLevel = intent!!.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) * 100 / intent.getIntExtra(BatteryManager.EXTRA_SCALE, -1)
        }

        return batteryLevel
    }

    private fun getGeoLocation(): String {
        val location: Location
        if (VERSION.SDK_INT >= VERSION_CODES.LOLLIPOP) {
            val locationManager = getSystemService(Context.LOCATION_SERVICE) as LocationManager
            val provider: LocationProvider = locationManager.getProvider(LocationManager.NETWORK_PROVIDER)

            if (ActivityCompat.checkSelfPermission(this, Manifest.permission.ACCESS_FINE_LOCATION) != PackageManager.PERMISSION_GRANTED && ActivityCompat.checkSelfPermission(this, Manifest.permission.ACCESS_COARSE_LOCATION) != PackageManager.PERMISSION_GRANTED) {
                // TODO: Consider calling
                //    ActivityCompat#requestPermissions
                // here to request the missing permissions, and then overriding
                //   public void onRequestPermissionsResult(int requestCode, String[] permissions,
                //                                          int[] grantResults)
                // to handle the case where the user grants the permission. See the documentation
                // for ActivityCompat#requestPermissions for more details.
                // Request updates from just the fine (gps) provider.
                geoLocation = "Not Authorized"

            } else {
                //NETWORK
                //locationManager.requestLocationUpdates(provider.name, 5000, 1000, listener)
                location = locationManager.getLastKnownLocation(provider.name)
                geoLocation = location.latitude.toString() + "," + location.longitude.toString()

                //GPS
                //var provider = "";
                //var criteria = Criteria();
                //criteria.setAccuracy(Criteria.ACCURACY_FINE);
                //criteria.setCostAllowed(false)
                //provider = locationManager.getBestProvider(criteria,true)
            }
        } else {
            geoLocation = "X"
            //val intent = ContextWrapper(applicationContext).registerReceiver(null, IntentFilter(Intent.ACTION_BATTERY_CHANGED))
            //geoLocation = intent!!.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) * 100 / intent.getIntExtra(BatteryManager.EXTRA_SCALE, -1)
        }

        return geoLocation
    }


    private val listener: LocationListener = object : LocationListener {
        override fun onLocationChanged(location: Location) {
            // A new location update is received.  Do something useful with it.  Update the UI with
            // the location update.
            //updateUILocation(location)
            Toast.makeText(context, location.toString(), Toast.LENGTH_LONG).show();
        }

        override fun onProviderDisabled(provider: String) {}
        override fun onProviderEnabled(provider: String) {}
        override fun onStatusChanged(provider: String, status: Int, extras: Bundle) {}
    }
}

/*
private fun Any.requestLocationUpdates(name: String?, i: Int, i1: Int, listener: LocationListener) {

}
*/
