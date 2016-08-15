//
//  ViewController.m
//  NetWorkTools
//
//  Created by MrQ on 16/7/25.
//

#import "ViewController.h"
#import "NetworkTools.h"
#import "NSString+Hash.h"

@interface ViewController ()

@property (nonatomic,copy)NSMutableString *accountid;
@property (nonatomic,copy)NSMutableString *brandId;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSString *md5String = [@"123456" md5String];
    [[NetworkTools sharedTools] login:@"13800111100" password:md5String finished:^(id result, NSError *error) {
        NSLog(@"登录:%@",result);
        NSDictionary *dict = result[@"data"];
        self.accountid = dict[@"accountid "];
        
        
        //高端品牌列表
        [[NetworkTools sharedTools] acquireHighCarList:self.accountid finished:^(id result, NSError *error) {
            NSLog(@"高端品牌列表:%@",result);
        }];
        
        //主页车源信息
        [[NetworkTools sharedTools] newCarSourceList:self.accountid finished:^(id result, NSError *error) {
            NSLog(@"主页车源信息:%@",result);
        }];
        
        //发布寻车时选择品牌
        [[NetworkTools sharedTools] fondBandList:self.accountid finished:^(id result, NSError *error) {
            NSLog(@"发布寻车时选择品牌:%@",result);
            NSLog(@"---%@",result[@"data"]);
            NSDictionary *dict = result[@"data"];
            NSArray *arr = dict[@"brandList"];
            NSDictionary *dict1 = arr.firstObject;
            self.brandId = dict1[@"brandId"];
            
            //车系列表
            [[NetworkTools sharedTools] seriesList:self.brandId accountid:self.accountid finished:^(id result, NSError *error) {
                NSLog(@"车系列表：%@",result);
            }];

        }];
    }];
    
    
    //车源发布时间判断
    [[NetworkTools sharedTools] isCheckPublish:^(id result, NSError *error) {
        NSLog(@"车源发布时间判断：%@",result);
    }];
    
    
    
    
    
    
    

}


@end
