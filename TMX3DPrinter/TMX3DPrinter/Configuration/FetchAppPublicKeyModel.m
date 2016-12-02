//
//  FetchAppPublicKey.m
//  ClshUser
//
//  Created by kobe on 16/6/6.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "FetchAppPublicKeyModel.h"

@implementation FetchAppPublicKeyModel
static FetchAppPublicKeyModel *publicKeyModel=nil;

+(instancetype)shareAppPublicKeyManager{
  
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        publicKeyModel=[[FetchAppPublicKeyModel alloc]init];
    });
    return publicKeyModel;
}

-(instancetype)init{
    if (self==[super init]) {
        //Returns an empty string.估计是起到分配内存的作用(通过打印确实是起到内存分配的作用，如果不使用这个方法，那么指针指向的地址是0x0（即是指向的内容没有内存分配，这里是单例设计模式，数据将会一直共享，除非程序关闭，所以我们在初始化的时候给予一个内存分配的地址）)
        self.publicKey=[NSString string];
    }
    
    return self;
}

-(void)fetchAppPublicKey:(NSDictionary *)params
                callBack:(void (^)(BOOL, id))completion
{
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,TMX_AppPublickey];
    
    [[KBHttpTool shareKBHttpToolManager]get:Url params:nil success:^(id response) {

        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code==ResponseSuccess) {
            completion(YES,[NSObject returnJson:baseModel.content][@"publicKey"]);
        }else{
            completion(NO,@"网络连接失败");
        }
        
    } failure:^(NSError *error) {
        completion(NO,@"服务器出错啦!");
    }];
}

-(NSDictionary *)fetchEncryptParams
{
    NSDictionary *encryptDic = @{@"userId":[FetchAppPublicKeyModel shareAppPublicKeyManager].infoModel.userId,@"token":[FetchAppPublicKeyModel shareAppPublicKeyManager].infoModel.token};
    NSString *postencryString =  [NSObject jsonTypeStringWithData:encryptDic];
    NSString *string = [KBRSA encryptString:postencryString publicKey:[FetchAppPublicKeyModel shareAppPublicKeyManager].publicKey];
    
    NSMutableDictionary *needParams=[NSMutableDictionary dictionary];
    needParams[@"userId"]=[FetchAppPublicKeyModel shareAppPublicKeyManager].infoModel.userId;
//    needParams[@"timestamp"]=[FetchAppPublicKeyModel shareAppPublicKeyManager].infoModel.token;
    needParams[@"body"]=string;

    return needParams;
}
@end
