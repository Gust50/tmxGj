//
//  KBHttpTool.m
//  TMX3DPrinter
//
//  Created by kobe on 16/6/16.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "KBHttpTool.h"
#import <AFNetworking.h>
#import "AppDelegate.h"


@interface KBHttpTool ()
{
    NSURLSessionDataTask *dataTask;
}
@property (nonatomic, strong) AFHTTPSessionManager *manager;
@end


@implementation KBHttpTool
static NSTimeInterval const KBHttpToolRequestTimeoutInterval=30;


-(AFHTTPSessionManager *)manager{
    if (!_manager) {
        _manager=[AFHTTPSessionManager manager];
        _manager.requestSerializer=[AFJSONRequestSerializer serializer];
        _manager.responseSerializer=[AFJSONResponseSerializer serializer];
    
        //Request timed out
        [_manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        _manager.requestSerializer.timeoutInterval=KBHttpToolRequestTimeoutInterval;
        [_manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html",@"text/javascript",@"multipart/form-data",@"charset=UTF-8", nil];
        [_manager.requestSerializer setValue:@"iOS1.1" forHTTPHeaderField:@"App-Version"];
        [_manager.requestSerializer setValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    }
    return _manager;
}



-(void)post:(NSString *)url
     params:(NSDictionary *)params
    success:(void (^)(id))success
    failure:(void (^)(NSError *))failure
{
    
//    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
//    manager.requestSerializer=[AFJSONRequestSerializer serializer];
//    manager.responseSerializer=[AFJSONResponseSerializer serializer];
//    
//    //Request timed out
//    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
//    manager.requestSerializer.timeoutInterval=KBHttpToolRequestTimeoutInterval;
//    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
//    
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html",@"text/javascript",@"multipart/form-data",@"charset=UTF-8", nil];
//    [manager.requestSerializer setValue:@"iOS1.1" forHTTPHeaderField:@"App-Version"];
//    [manager.requestSerializer setValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    
    
    if ([[NSBundle getCurrentLanguage] hasPrefix:@"en"]) {
        [_manager.requestSerializer setValue:@"en_US" forHTTPHeaderField:@"lan"];
    }else{
        [_manager.requestSerializer setValue:@"zh_CN" forHTTPHeaderField:@"lan"];
    }
  dataTask=[self.manager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:responseObject];
//        LRLog(@"----------------测试数据---------------------%@",responseObject);
        
        if (baseModel.code==ResponseSuccess)
        {
            success(responseObject);
            
        }else if (baseModel.code==ResponseUnLogin)
        {
            [FetchAppPublicKeyModel shareAppPublicKeyManager].isLogin=NO;
//            [[NSNotificationCenter defaultCenter]postNotificationName:@"StopTask" object:nil userInfo:nil];
            [ShareApp againLogin];
        
        }else
        {
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {
            failure(error);
        }
    }];
}


-(void)get:(NSString *)url
    params:(NSDictionary *)params
   success:(void (^)(id))success
   failure:(void (^)(NSError *))failure
{
    
    if ([[NSBundle getCurrentLanguage] hasPrefix:@"en"]) {
        [_manager.requestSerializer setValue:@"en_US" forHTTPHeaderField:@"lan"];
    }else{
        [_manager.requestSerializer setValue:@"zh_CN" forHTTPHeaderField:@"lan"];
    }
    
    [self.manager GET:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:responseObject];
        
        if (baseModel.code==ResponseSuccess)
        {
             success(responseObject);
            
        }else if (baseModel.code==ResponseUnLogin)
        {
            [FetchAppPublicKeyModel shareAppPublicKeyManager].isLogin=NO;
            [ShareApp againLogin];
            
        }else{
             success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {
            failure(error);
        }
    }];

}


+(id)shareKBHttpToolManager{
    
    
    
    static KBHttpTool *shareManager=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareManager=[[KBHttpTool alloc]init];
    });
    return shareManager;
    
}

-(void)cancelAllTask{
//    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
//    [_manager.operationQueue cancelAllOperations];
    [dataTask cancel];
}
@end
