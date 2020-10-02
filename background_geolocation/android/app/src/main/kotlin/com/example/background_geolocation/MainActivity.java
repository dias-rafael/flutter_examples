package com.example.background_geolocation;

import android.content.BroadcastReceiver;
import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.ServiceConnection;
import android.os.Build;
import android.os.IBinder;
import android.telephony.ServiceState;
import android.util.Log;

import androidx.localbroadcastmanager.content.LocalBroadcastManager;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugins.GeneratedPluginRegistrant;

import static android.content.ContentValues.TAG;

public class MainActivity extends FlutterActivity {

    private MyReceiver myReceiver = new MyReceiver();
    private LocationUpdatesService mService = null;

    private boolean mBound = false;
    // Monitors the state of the connection to the service.
    private final ServiceConnection mServiceConnection = new ServiceConnection() {

        @Override
        public void onServiceConnected(ComponentName name, IBinder service) {
            LocationUpdatesService.LocalBinder binder = (LocationUpdatesService.LocalBinder) service;
            mService = binder.getService();
            mBound = true;
            mService.requestLocationUpdates();
        }

        @Override
        public void onServiceDisconnected(ComponentName name) {
            mService = null;
            mBound = false;
        }
    };


    @Override
    public void configureFlutterEngine(FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        GeneratedPluginRegistrant.registerWith(flutterEngine);

    }

    @Override
    protected void onStart() {
        bindService(new Intent(this, LocationUpdatesService.class), mServiceConnection, Context.BIND_AUTO_CREATE);
        super.onStart();
    }

    @Override
    protected void onPause() {
        LocalBroadcastManager.getInstance(this).unregisterReceiver(myReceiver);
        super.onPause();
    }

    @Override
    protected void onStop() {
        if (mBound) {
            unbindService(mServiceConnection);
            mBound = false;
        }
        super.onStop();
    }

    public class MyReceiver extends BroadcastReceiver {
        @Override
        public void onReceive(Context context, Intent intent) {

                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                        Log.i(TAG, "Starting the service in >=26 Mode from a BroadcastReceiver");
                        context.startForegroundService(new Intent(context, LocationUpdatesService.class));
                        return;
                    }
                    Log.i(TAG, "Starting the service in < 26 Mode from a BroadcastReceiver");
                    context.startService(new Intent(context, LocationUpdatesService.class));


            //startForegroundService(new Intent(applicationContext, LocationUpdatesService.class));
            //TODO: Implementar codigo para receber a latitude e longitute quando estiver em foreground.
        }
    }
}