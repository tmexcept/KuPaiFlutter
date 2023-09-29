package kupai.flutterapp;

import android.content.ContextWrapper;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.BatteryManager;
import android.os.Build;
import android.os.Bundle;
import android.util.Log;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class MainActivity extends FlutterActivity {
  private static final String CHANNEL = "flutter.io/sign";

  @Override
   public void configureFlutterEngine(FlutterEngine flutterEngine) {
//           GeneratedPluginRegistrant.registerWith(flutterEngine);
//           new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
//                           .setMethodCallHandler(
//                               (call, result) -> {
//                Log.e("tag", "getBatteryLevel");
//                if (call.method.equals("getBatteryLevel")) {
//                  int batteryLevel = getBatteryLevels();
//
//                  if (batteryLevel != -1) {
//                    result.success(batteryLevel);
//                  } else {
//                    result.error("UNAVAILABLE", "Battery level not available.", null);
//                  }
//                } else {
//                  result.notImplemented();
//                }
//                                     }
//                           );
       }
  private int getBatteryLevels() {
    int batteryLevel = -1;
    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
      BatteryManager batteryManager = (BatteryManager) getSystemService(BATTERY_SERVICE);
      batteryLevel = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY);
    } else {
      Intent intent = new ContextWrapper(getApplicationContext()).
              registerReceiver(null, new IntentFilter(Intent.ACTION_BATTERY_CHANGED));
      batteryLevel = (intent.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) * 100) /
              intent.getIntExtra(BatteryManager.EXTRA_SCALE, -1);
    }

    return batteryLevel;
  }
}
