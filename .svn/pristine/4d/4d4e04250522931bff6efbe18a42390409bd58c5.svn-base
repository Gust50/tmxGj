//
//  NSObject+KBExtension.m
//  ClshUser
//
//  Created by kobe on 16/6/4.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "NSObject+KBExtension.h"

@implementation NSObject (KBExtension)


+(NSDictionary *)returnJson:(id)jsonData{
    
    if (jsonData==nil || [jsonData isEqual:[NSNull class]]) {
        return @{};
    }
    if ([jsonData isKindOfClass:[NSDictionary class]]) {
        return jsonData;
    }
    /* Create a Foundation object from JSON data. Set the NSJSONReadingAllowFragments option if the parser should allow top-level objects that are not an NSArray or NSDictionary. Setting the NSJSONReadingMutableContainers option will make the parser generate mutable NSArrays and NSDictionaries. Setting the NSJSONReadingMutableLeaves option will make the parser generate mutable NSString objects. If an error occurs during the parse, then the error parameter will be set and the result will be nil.
     The data must be in one of the 5 supported encodings listed in the JSON specification: UTF-8, UTF-16LE, UTF-16BE, UTF-32LE, UTF-32BE. The data may or may not have a BOM. The most efficient encoding to use for parsing is UTF-8, so if you have a choice in encoding the data passed to this method, use UTF-8.
     */
    if ([[NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil]isKindOfClass:[NSDictionary class]]) {
        
        return (NSDictionary *)[NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
    }else{
        return @{};
    }
    
    return (NSDictionary *)[NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
}

+(NSString *)stringWithData:(NSData *)data{
    return [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
}

+(NSString *)jsonTypeStringWithString:(NSString *)string{
//    return [NSString stringWithFormat:@"%@",[[string stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"]stringByReplacingOccurrencesOfString:@"''" withString:@"\""]];
    
#warning bug
    return [NSString stringWithFormat:@"%@",
            [[string stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"] stringByReplacingOccurrencesOfString:@"''"withString:@"\""]
            ];
}

+(NSString *)jsonTypeStringWithData:(id)object{
    NSString *jsonString=nil;
    NSError *error;
    
    /* Generate JSON data from a Foundation object. If the object will not produce valid JSON then an exception will be thrown. Setting the NSJSONWritingPrettyPrinted option will generate JSON with whitespace designed to make the output more readable. If that option is not set, the most compact possible JSON will be generated. If an error occurs, the error parameter will be set and the return value will be nil. The resulting data is a encoded in UTF-8.
     */
    NSData *jsonData=[NSJSONSerialization dataWithJSONObject:object options:NSJSONWritingPrettyPrinted error:&error];
    if (!jsonData) {
        
    }else{
        jsonString=[[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    return jsonString;
}

+(NSData *)dataWithDictionary:(NSDictionary *)dict{
    NSData *data=[NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
    return data;
}
@end
