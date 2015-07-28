//
//  WeatherSev.h
//  OCWeather
//
//  Created by locksher on 15/7/28.
//  Copyright (c) 2015年 abjia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <AFNetworking/AFNetworking.h>



@interface WeatherSev : NSObject


- (void)retrieveForecast:(CLLocationDegrees)latitude andLongitude:(CLLocationDegrees)longitude
    //成功block
    successBlock:(void (^)(id responseObject))successBlock
    //error block
    errorBlock: (void (^)(id errorObj))errorBlock;





- (void)updateWeatherIcon:(int)condition
            isNightTime:(BOOL)isNightTime
            index:(int)index
                callBack : (void (^)(int index, NSString *name))callBack;


//根据国家转换温度显示
- (void)convertTemperatureWithCountry:(NSString *)country
            temperature:(double)temperature;


//判断图标
- (BOOL)isNightTimeWithIcon:(NSString *)icon;



@end
