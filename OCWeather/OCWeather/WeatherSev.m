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




//更新icon



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
-(void)updateWeatherIcon:(int)condition isNightTime:(BOOL)isNightTime index:(int)index callBack:(void (^)(int, NSString *))callBack {
    
    // Thunderstorm
    if (condition < 300) {
        if (isNightTime) {
            callBack(index,@"tstorm1_night");
        } else {
            callBack(index,@"tstorm1");
            
        }
    }
    else if (condition < 500) {
        callBack(index,@"light_rain");
        
    }
    // Rain / Freezing rain / Shower rain
    else if (condition < 600) {
        callBack(index,@"shower3");
    }
    // Snow
    else if (condition < 700) {
        callBack(index,@"snow4");
    }
    // Fog / Mist / Haze / etc.
    else if (condition < 771) {
        if (isNightTime) {
            callBack(index,@"fog_night");
        } else {
            callBack(index,@"fog");
        }
    }
    // Tornado / Squalls
    else if (condition < 800) {
        callBack(index,@"tstorm3");
    }
    // Sky is clear
    else if (condition == 800) {
        if (isNightTime){
            callBack(index,@"sunny_night");
        }
        else {
            callBack(index,@"sunny");
        }
    }
    // few / scattered / broken clouds
    else if (condition < 804) {
        if (isNightTime){
            callBack(index,@"cloudy2_night");
        }
        else{
            callBack(index,@"cloudy2");
        }
    }
    // overcast clouds
    else if (condition == 804) {
        callBack(index,@"overcast");
    }
    // Extreme
    else if ((condition >= 900 && condition < 903) || (condition > 904 && condition < 1000)) {
        callBack(index,@"tstorm3");
    }
    // Cold
    else if (condition == 903) {
        callBack(index,@"snow5");
    }
    // Hot
    else if (condition == 904) {
        callBack(index,@"sunny");
    }
    // Weather condition is not available
    else {
        callBack(index,@"dunno");
    }

    
    
}



@end
