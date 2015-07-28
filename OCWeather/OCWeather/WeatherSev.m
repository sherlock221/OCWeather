//
//  WeatherSev.m
//  OCWeather
//
//  Created by locksher on 15/7/28.
//  Copyright (c) 2015年 abjia. All rights reserved.
//

#import "WeatherSev.h"

@interface WeatherSev()

@property (nonatomic,strong) AFHTTPRequestOperationManager  *afManager;

@end


@implementation WeatherSev


- (AFHTTPRequestOperationManager *)afManager{
    if(!_afManager){
        _afManager = [[AFHTTPRequestOperationManager alloc] init ];
        
    }
    return _afManager;
}



//根据经纬度查询天气
- (void)retrieveForecast:(CLLocationDegrees)latitude andLongitude:(CLLocationDegrees)longitude successBlock:(void (^)(id))successBlock errorBlock:(void (^)(id))errorBlock{
    
    
    //免费天气应用
    NSString *url = @"http://api.openweathermap.org/data/2.5/weather";
    
    NSDictionary  *map = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithDouble:longitude ],@"lon",[NSNumber numberWithDouble:latitude ], @"lat",nil];
    
    
    
    //get请求获取数据
    [self.afManager GET:url parameters:map success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //成功返回
        successBlock(responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //失败返回
        errorBlock(error);
    }];
     
     
}


//更新weather图标
-(void)updateWeatherIcon:(int)condition isNightTime:(BOOL)isNightTime index:(int)index callBack:(void (^)(int, NSString *))callBack{
    
    
}
     


@end
