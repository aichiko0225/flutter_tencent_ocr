#import "FlutterTencentOcrPlugin.h"
#import <AipOcrSdk/AipOcrSdk.h>
#import "UIViewController+bd_present.h"

// SECRET_ID 信息
static NSString *SECRET_ID = nil;
// SECRET_KEY 信息
static NSString *SECRET_KEY = nil;

@implementation FlutterTencentOcrPlugin
{
    // 默认的识别成功的回调
    void (^_successHandler)(id);
    // 默认的识别失败的回调
    void (^_failHandler)(NSError *);
}

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar {
    FlutterMethodChannel *channel = [FlutterMethodChannel
      methodChannelWithName:@"flutter_tencent_ocr"
            binaryMessenger:[registrar messenger]];
    FlutterMethodChannel *baidu_channel = [FlutterMethodChannel
        methodChannelWithName:@"flutter_baidu_ocr"
              binaryMessenger:[registrar messenger]];
    FlutterTencentOcrPlugin* instance = [[FlutterTencentOcrPlugin alloc] init];
    [registrar addMethodCallDelegate:instance channel:channel];
    [registrar addMethodCallDelegate:instance channel:baidu_channel];
}

- (void)handleMethodCall:(FlutterMethodCall *)call result:(FlutterResult)result {
  if ([@"getPlatformVersion" isEqualToString:call.method]) {
    result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
  } else if ([@"initOcrSDKConfig" isEqualToString:call.method]) {
      // OCR 配置信息
      NSDictionary *dic = call.arguments;
      NSDictionary *appkey_dic = dic[@"appkey"];
      
      if (appkey_dic == nil) {
          NSParameterAssert(appkey_dic != nil);
          result(@NO);
      }
      
      SECRET_ID = appkey_dic[@"secretId"];
      SECRET_KEY = appkey_dic[@"secretKey"];
      
      NSParameterAssert(SECRET_ID != nil && SECRET_KEY != nil);
      
#warning 【必须！】请在 ai.baidu.com中新建App, 绑定BundleId后，在此填写授权信息
#warning 【必须！】上传至AppStore前，请使用lipo移除AipBase.framework、AipOcrSdk.framework的模拟器架构，参考FAQ：ai.baidu.com/docs#/OCR-iOS-SDK/top
      //  授权方法1：在此处填写App的Api Key/Secret Key
      [[AipOcrService shardService] authWithAK:SECRET_ID andSK:SECRET_KEY];
      [self configCallback];
      
      result(@YES);
  } else if ([@"startProcessOcr" isEqualToString:call.method]) {
      
      NSDictionary *dic = call.arguments;
      NSDictionary *config_dic = dic[@"config"];
      
      NSParameterAssert(config_dic[@"ocrType"] != nil);
      
      int type = [config_dic[@"ocrType"] intValue];
      
      [self idcardOCROnlineFront];

  } else {
    result(FlutterMethodNotImplemented);
  }
}

- (void)idcardOCROnlineFront {
    
    UIViewController * vc =
    [AipCaptureCardVC ViewControllerWithCardType:CardTypeIdCardFont
                                 andImageHandler:^(UIImage *image) {
        
        [[AipOcrService shardService] detectIdCardFrontFromImage:image
                                                     withOptions:nil
                                                  successHandler:_successHandler
                                                     failHandler:_failHandler];
    }];
    
    [[FlutterTencentOcrPlugin topViewController] bd_presentViewControllerWithFullScreen:vc animated:YES completion:nil];
    
}
- (void)idcardOCROnlineBack{
    
    UIViewController * vc =
    [AipCaptureCardVC ViewControllerWithCardType:CardTypeIdCardBack
                                 andImageHandler:^(UIImage *image) {
        
        [[AipOcrService shardService] detectIdCardBackFromImage:image
                                                    withOptions:nil
                                                 successHandler:_successHandler
                                                    failHandler:_failHandler];
    }];
    [[FlutterTencentOcrPlugin topViewController] bd_presentViewControllerWithFullScreen:vc animated:YES completion:nil];
}


+ (UIViewController *)topViewController {
    return [self cc_topViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
}

+ (UIViewController *)cc_topViewController:(UIViewController *)base {
    if ([base isKindOfClass:UINavigationController.class]) {
        UINavigationController *navi_base = (UINavigationController *)base;
        return [self cc_topViewController:[navi_base visibleViewController]];
    }
    
    if ([base isKindOfClass:UITabBarController.class]) {
        UITabBarController *tabar_base = (UITabBarController *)base;
        return [self cc_topViewController:[tabar_base selectedViewController]];
    }
    
    UIViewController *presented = [base presentedViewController];
    if (presented) {
        return [self cc_topViewController:presented];
    }
    
    return base;
}


- (void)configCallback {

    UIViewController *viewController = [FlutterTencentOcrPlugin topViewController];
    __weak typeof(viewController) weak_viewController = viewController;
    
    // 这是默认的识别成功的回调
    _successHandler = ^(id result){
        NSLog(@"%@", result);
        NSString *title = @"识别结果";
        NSMutableString *message = [NSMutableString string];
        
        if (result[@"words_result"]){
            if ([result[@"words_result"] isKindOfClass:[NSDictionary class]]){
                [result[@"words_result"] enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
                    if ([obj isKindOfClass:[NSDictionary class]] && [obj objectForKey:@"words"]){
                        [message appendFormat:@"%@: %@\n", key, obj[@"words"]];
                    } else {
                        [message appendFormat:@"%@: %@\n", key, obj];
                    }
                }];
            } else if ([result[@"words_result"] isKindOfClass:[NSArray class]]){
                for(NSDictionary *obj in result[@"words_result"]){
                    if ([obj isKindOfClass:[NSDictionary class]] && [obj objectForKey:@"words"]){
                        [message appendFormat:@"%@\n", obj[@"words"]];
                    } else {
                        [message appendFormat:@"%@\n", obj];
                    }
                }
            }
        } else if (result[@"codes_result"]){
            if ([result[@"codes_result"] isKindOfClass:[NSArray class]]){
                for (id dict in result[@"codes_result"]) {
                    if ([dict isKindOfClass:[NSDictionary class]]) {
                        NSArray *array = dict[@"text"];
                        for (int i=0; i<array.count; i++) {
                            [message appendFormat:@"%@\n", array[i]];
                        }
                    }
                }
            }
        } else {
            
            NSError*parseError =nil;
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:result options:NSJSONWritingPrettyPrinted error:&parseError];
            [message appendFormat:@"%@", [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]];
        }
       
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{

            UIAlertController * alertCon = [UIAlertController alertControllerWithTitle:@"识别结果" message:message preferredStyle:UIAlertControllerStyleAlert];
               
                UIAlertAction * ok =[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
 
                }];
                [alertCon addAction:ok];

                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [weak_viewController dismissViewControllerAnimated:YES completion:^{
                        [weak_viewController bd_presentViewControllerWithFullScreen:alertCon animated:YES completion:nil];
                    }];

                });
            });

    };
    
    _failHandler = ^(NSError *error){
        NSLog(@"%@", error);
        NSString *msg = [NSString stringWithFormat:@"%li:%@", (long)[error code], [error localizedDescription]];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{

            UIAlertController * alertCon = [UIAlertController alertControllerWithTitle:@"识别失败" message:msg preferredStyle:UIAlertControllerStyleAlert];
               
                UIAlertAction * ok =[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
 
                }];
                [alertCon addAction:ok];

                dispatch_async(dispatch_get_main_queue(), ^{

                    [weak_viewController dismissViewControllerAnimated:YES completion:^{
                        [weak_viewController bd_presentViewControllerWithFullScreen:alertCon animated:YES completion:nil];
                    }];

                });

            });
    };
}



@end
