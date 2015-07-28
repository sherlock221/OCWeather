//
//  ViewController.m
//  OCWeather
//
//  Created by 贾奥博 on 15-7-24.
//  Copyright (c) 2015年 abjia. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <AFNetworking/AFNetworking.h>
#import "WeatherSev.h"



@interface ViewController ()<CLLocationManagerDelegate>

@property (nonatomic,strong) CLLocationManager  *locMgr;


@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *temperature;


@property (nonatomic,strong) WeatherSev *weatherSev;

@end




@implementation ViewController



- (WeatherSev *)weatherSev{
    
    
    if(!_weatherSev){
        _weatherSev =  [[WeatherSev alloc] init];
    }
    
    return _weatherSev;
}


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




- (void)updateWeatherInfo:(CLLocationDegrees)latitude andLongitude:(CLLocationDegrees)longitude{
    
    
        [self.weatherSev retrieveForecast:latitude andLongitude:longitude successBlock:^(id responseObject) {
            
            NSLog(@"获得到数据");
            NSLog(@"%@",responseObject);
            
            
        } errorBlock:^(id errorObj) {
            NSLog(@"%@",errorObj);
        }];
    
    
}


//更新ui
- (void)updateUI:(NSDictionary *)weatherObj{
    id temp  =  [[weatherObj  objectForKey:@"main"] objectForKey:@"temp"];
    id location = [weatherObj objectForKey:@"name"];
    
    //温度转化
    if( [[[weatherObj objectForKey:@"sys"] objectForKey:@"country"] isEqualToString:@"US"]){
        
    }
    
    
    NSNumber   *condition = [[[weatherObj objectForKey:@"weather"] objectAtIndex:0] objectForKey:@"id"];
    
    //日出
    NSNumber *sunrise = [[weatherObj objectForKey:@"sys"] objectForKey:@"sunrise"];
    
    //日落
    NSNumber *sunset = [[weatherObj objectForKey:@"sys"] objectForKey:@"sunset"];
    
    //白天还是黑夜
    BOOL isNight = NO;
    
    //当前时间
    NSTimeInterval now = [[NSDate alloc] init].timeIntervalSince1970 ;
    
    
    //日出之前 和 日落之后 晚上
    if(now < [sunrise doubleValue]|| now > [sunset doubleValue]){
        isNight = YES;
    }
    
    [self updateWeatherIcon:condition withNightTime: isNight];
    
   //  NSLog(@"%d",condition);

    
    
    self.temperature.text = [[temp stringValue] stringByAppendingString:@"℃"];
    self.locationLabel.text = location;
    
    
   }


//更新天气icon
- (void)updateWeatherIcon:(NSNumber *)condition withNightTime:(BOOL)isNight{
    if([condition intValue] < 300){
        if(isNight){
            self.icon.image = [UIImage imageNamed:@"tstorm1_night"];
        }
        else{
            self.icon.image = [UIImage imageNamed:@"tstorm1"];
        }
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
    
    CLLocation *location = [locations firstObject];
    NSLog(@"定位到:%@", location);
    
    if([location horizontalAccuracy] >0){
        
        [manager stopUpdatingLocation];
        [self updateWeatherInfo:location.coordinate.latitude andLongitude:  location.coordinate.longitude];

    }
   
    
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

@end
