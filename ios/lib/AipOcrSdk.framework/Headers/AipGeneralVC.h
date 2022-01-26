//
//  AipGeneralVC.h
//  OCRLib
//
//  Created by Yan,Xiangda on 2017/2/16.
//  Copyright © 2017年 Baidu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BDAipOCRConstant.h"

@interface AipGeneralVC : UIViewController


@property (nonatomic, copy) void (^handler)(UIImage *);

+(UIViewController *)ViewControllerWithHandler:(void (^)(UIImage *image))handler;

/**
 在线文字识别接口
* @param type 识别类型
* @param options 可选参数
* @param successHandler 成功回调
* @param failHandler 失败回调

*/
+(UIViewController *)viewControllerWithReconizeType:(BDRecognizeType)type
                                            options:(NSDictionary *)options
                                     successHandler:(void (^)(id result))successHandler
                                        failHandler:(void (^)(NSError *err))failHandler;

@end
