//
//  NetworkTools.m
//  
//
//  Created by MrQ on 16/7/25.
//
//

#import "NetworkTools.h"


@protocol NetworkToolsProxy <NSObject>

@optional
- (NSURLSessionDataTask *)dataTaskWithHTTPMethod:(NSString *)method
                                       URLString:(NSString *)URLString
                                      parameters:(id)parameters
                                  uploadProgress:(nullable void (^)(NSProgress *uploadProgress)) uploadProgress
                                downloadProgress:(nullable void (^)(NSProgress *downloadProgress)) downloadProgress
                                         success:(void (^)(NSURLSessionDataTask *, id))success
                                         failure:(void (^)(NSURLSessionDataTask *, NSError *))failure;

@end

@interface NetworkTools () <NetworkToolsProxy>

@end

@implementation NetworkTools

#pragma mark 单例
+(instancetype)sharedTools {
    static NetworkTools *tools;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURL *baseUrl = [NSURL URLWithString:@"http://iosapi.itcast.cn/car/"];
        
        tools = [[self alloc] initWithBaseURL:baseUrl];
        
        //设置请求格式
        tools.requestSerializer = [AFJSONRequestSerializer serializer];
        
        //设置反序列化格式
        tools.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    });
    
    return tools;
}

#pragma mark 用户
//登录
-(void)login:(NSString *)phone password:(NSString *)password finished:(void (^)(id, NSError *))finished {
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setValue:phone forKey:@"phone"];
    [parameters setValue:password forKey:@"password"];
    
    NSString *urlString = @"login.json.php";
    
    
    [self request:POST URLString:urlString parameters:parameters finished:finished];
}

//获取高端品牌列表
-(void)acquireHighCarList:(NSString *)accountid finished:(void (^)(id, NSError *))finished {
    
    
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setValue:accountid forKey:@"accountid"];
    
    NSString *urlString = @"highcarlist.json.php";
    
    [self request:POST URLString:urlString parameters:parameters finished:finished];
}

//获取主页车源信息
-(void)newCarSourceList:(NSString *)accountid finished:(void (^)(id, NSError *))finished {
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setValue:accountid forKey:@"accountid"];
    
    NSString *urlString = @"newcarlist.json.php";
    
    [self request:POST URLString:urlString parameters:parameters finished:finished];
}

//车源发布时间判断
-(void)isCheckPublish:(void (^)(id, NSError *))finished {
    NSString *urlString = @"checkpublish.json.php";
    
    [self request:POST URLString:urlString parameters:nil finished:finished];
}

//发布寻车时选择品牌
-(void)fondBandList:(NSString *)accountid finished:(void (^)(id, NSError *))finished {
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setValue:accountid forKey:@"accountid"];
    
    NSString *urlString = @"band.json.php";
    
    [self request:POST URLString:urlString parameters:parameters finished:finished];
}

//车系列表
-(void)seriesList:(NSString *)brandId accountid:(NSString *)accountid finished:(void (^)(id, NSError *))finished {
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setValue:brandId forKey:@"brandId"];
    [parameters setValue:accountid forKey:@"accountid"];
    
    NSString *urlString = @"series.json.php";
    
    
    [self request:POST URLString:urlString parameters:parameters finished:finished];
}


#pragma mark 封装AFN网络方法
-(void)request:(RequestMethod)method URLString:(NSString *)URLString parameters:(id)parameters finished:(void (^)(id, NSError *))finished {
    
    NSString *methodName = (method == GET) ? @"GET" : @"POST";
    
    // dataTaskWithHTTPMethod本类没有实现方法，但是父类实现了
    // 在调用方法的时候，如果本类没有提供，直接调用父类的方法，AFN 内部已经实现！
    [[self dataTaskWithHTTPMethod:methodName URLString:URLString parameters:parameters uploadProgress:nil downloadProgress:nil success:^(NSURLSessionDataTask * task, id responseObject) {
        
        finished(responseObject, nil);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        finished(nil, error);
    }] resume];
    
    
    
}

@end
