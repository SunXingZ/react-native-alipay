
#import "RNAlipay.h"

static RCTPromiseResolveBlock _payOrderComplete;

@implementation RNAlipay

RCT_EXPORT_MODULE()

RCT_EXPORT_METHOD(payOrder:(NSString *)orderParams callback:(RCTResponseSenderBlock)callback) {
    _payOrderComplete = callback;
    [[AlipaySDK defaultService] payOrder:orderParams fromScheme: [self getAlipayUrlScheme] callback:^(NSDictionary *result) {
        _payOrderComplete(@[result]);
    }];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleOpenURL:) name:@"RCTOpenURLNotification" object:nil];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (dispatch_queue_t)methodQueue
{
    return dispatch_get_main_queue();
}

- (NSString *)getAlipayUrlScheme {
    NSArray *urlTypes = [NSBundle mainBundle].infoDictionary[@"CFBundleURLTypes"];
    for (NSDictionary *urlType in urlTypes) {
         NSString *urlName = urlType[@"CFBundleURLName"];
        if ([urlName hasPrefix:@"alipay"]) {
            NSArray *schemes = urlType[@"CFBundleURLSchemes"];
            return [schemes objectAtIndex:0];
        }
    }
    return nil;
}

- (void)handleOpenURL:(NSNotification *)notification {
    NSString *urlString = notification.userInfo[@"url"];
    NSURL *url = [NSURL URLWithString:urlString];
    if ([url.host isEqualToString:@"safepay"]) {
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *result){
            _payOrderComplete(@[result]);
        }];
    }
}

@end

