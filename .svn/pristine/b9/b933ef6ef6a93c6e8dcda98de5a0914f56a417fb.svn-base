//
//  KBHttpTool.h
//  TMX3DPrinter
//
//  Created by kobe on 16/6/16.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KBHttpTool : NSObject


/**
 *  Post
 *
 *  @param url     URL
 *  @param params  Params
 *  @param success Success
 *  @param failure Failure
 */
-(void)post:(NSString *)url
     params:(NSDictionary *)params
    success:(void(^)(id response))success
    failure:(void(^)(NSError *error))failure;


/**
 *  Get
 *
 *  @param url     URL
 *  @param params  Params
 *  @param success Success
 *  @param failure Failure
 */
-(void)get:(NSString *)url
     params:(NSDictionary *)params
    success:(void(^)(id response))success
    failure:(void(^)(NSError *error))failure;


/**
 *  singleton
 *
 *  @return id
 */
+(id)shareKBHttpToolManager;

-(void)cancelAllTask;

@end
