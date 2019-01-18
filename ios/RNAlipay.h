
#if __has_include("RCTBridgeModule.h")
#import "RCTBridgeModule.h"
#else
#import <React/RCTBridgeModule.h>
#endif
#import <AlipaySDK/AlipaySDK.h>

@interface RNAlipay : NSObject <RCTBridgeModule>

@end
  
