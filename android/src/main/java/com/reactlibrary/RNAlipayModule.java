
package com.reactlibrary;

import com.alipay.sdk.app.PayTask;
import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.Callback;
import com.facebook.react.bridge.WritableMap;

import java.util.Map;

public class RNAlipayModule extends ReactContextBaseJavaModule {

  private final ReactApplicationContext reactContext;

  public RNAlipayModule(ReactApplicationContext reactContext) {
    super(reactContext);
    this.reactContext = reactContext;
  }

  @Override
  public String getName() {
    return "RNAlipay";
  }

  @ReactMethod
  public void payOrder(final String orderString, final String orderScheme, final Callback callback) {
    Runnable payRunnable = new Runnable() {
      @Override
      public void run() {
        WritableMap map = Arguments.createMap();
        PayTask alipay = new PayTask(getCurrentActivity());
        Map<String, String> result = alipay.payV2(orderString, true);
        for (Map.Entry<String, String> entry : result.entrySet())
        map.putString(entry.getKey(), entry.getValue());
        callback.invoke(map);
      }
    };
    Thread payThread = new Thread(payRunnable);
    payThread.start();
  }
}