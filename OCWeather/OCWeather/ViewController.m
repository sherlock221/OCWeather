//
//  ViewController.m
//  OCWeather
//
//  Created by 贾奥博 on 15-7-24.
//  Copyright (c) 2015年 abjia. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>




@interface ViewController ()<CLLocationManagerDelegate>

@property (nonatomic,strong) CLLocationManager  *locMgr;

@end




@implementation ViewController

//get
- (CLLocationManager *)locMgr{
    
    if(!_locMgr){
        
        //创建位置管理器
        _locMgr = [[CLLocationManager alloc] init];
        //设置代理
        _locMgr.delegate = self;
    }
    
    return _locMgr;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSLog(@"viewDidLoad....");
    
    
    //ios8询问权限
    if ([[[UIDevice currentDevice] systemVersion] doubleValue] > 8.0)
    {
        
        //在使用这两个方法授权前 必须在plist中
        //添加NSLocationWhenInUseUsageDescription  和  NSLocationAlwaysUsageDescription  授权alert的描述
        
        //使用应用程序期间允许访问位置数据
        [self.locMgr requestWhenInUseAuthorization];
        
        //始终允许访问位置信息
        //  [locationManager requestAlwaysAuthorization];
    }
    
    
    //用户定位服务是否开启
    if ([CLLocationManager locationServicesEnabled]) {
        
        //开始定位用户位置
        [self.locMgr startUpdatingLocation];
        
        //每间隔多少米定位一次 (任何移动)
        self.locMgr.distanceFilter = kCLDistanceFilterNone;
        
        //设置定位精准度 一般精度越高越耗费电(精度最高)
        self.locMgr.desiredAccuracy = kCLLocationAccuracyBest;
    }
    else{
        NSLog(@"定位服务未开启!");
    }

   
    
}



//定位失败
- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error{
    
    NSLog(@"ERROR");
}

#pragma mark-CLLocationManagerDelegate
//定位回调方法
- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations{
    
    NSLog(@"定位到:%@", [locations firstObject]);
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

@end
