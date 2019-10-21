package com.example.credit_card_sms_receiver;

import android.content.Intent;
import android.os.Build;
import android.os.Bundle;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {

    private Intent forService;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        GeneratedPluginRegistrant.registerWith(this );

        forService = new Intent(MainActivity.this, MyService.class);

        new MethodChannel(getFlutterView(), "com.example.credit_card_sms_receiver").setMethodCallHandler(new MethodChannel.MethodCallHandler() {
            @Override
            public void onMethodCall(MethodCall call, MethodChannel.Result result) {
                System.out.println("MainActivity:onMethodCall");
                if(call.method.equals("startService")) {
                    startService();
                    result.success("service started");
                }
            }
        });
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        stopService(forService);
    }

    private void startService() {
        if(Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            System.out.println("MainActivity:startService");
            startForegroundService(forService);
        }
        else {
            System.out.println("MainActivity:startService");
            startService(forService);
        }
    }
}
