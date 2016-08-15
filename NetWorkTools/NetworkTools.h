//
//  NetworkTools.h
//  
//
//  Created by MrQ on 16/7/25.
//
//

#import <Foundation/Foundation.h>
#import "AFNetworking/AFNetworking.h"

typedef enum : NSUInteger {
    GET,
    POST,
} RequestMethod;

@interface NetworkTools : AFHTTPSessionManager

//单例
+(instancetype)sharedTools;

//登录
-(void)login:(NSString *)phone password:(NSString *)password finished:(void (^)(id result, NSError *error))finished;

//获取高端品牌列表
-(void)acquireHighCarList:(NSString *)accountid finished:(void (^)(id result, NSError *error))finished;

//获取主页车源信息
-(void)newCarSourceList:(NSString *)accountid finished:(void (^)(id result, NSError *error))finished;

// 车源发布时间判断
-(void)isCheckPublish:(void (^)(id result, NSError *error))finished;

//发布寻车时选择品牌
-(void)fondBandList:(NSString *)accountid finished:(void (^)(id result, NSError *error))finished;

//车系列表
-(void)seriesList:(NSString *)brandId accountid:(NSString *)accountid finished:(void (^)(id result, NSError *error))finished;
@end
