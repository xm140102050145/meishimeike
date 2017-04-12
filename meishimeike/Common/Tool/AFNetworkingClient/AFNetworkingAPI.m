//
//  AFNetworkingAPI.m
//  AFNetworkingClient
//
//  Created by zhenglong duan on 20/03/2017.
//  Copyright © 2017 zhenglong duan. All rights reserved.
//

#import "AFNetworkingAPI.h"

@implementation AFNetworkingAPI
/*** get请求 ***/
+ (void)getWithPath:(NSString *)path Params:(nullable NSDictionary *)params requrieDataBack:(DlRequireDataBlock)requireDataBlock {
    [AFNetworkingClient getWithPath:path Params:params requrieDataBack:^(id data) {
        if ([data isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dic = data;
            if ([dic[@"code"] intValue] == 200) {
                id arr = dic[@"result"];
                requireDataBlock(arr);  //只考虑获取成功后的数据 
            }else {
                requireDataBlock(dic[@"message"]);
            }
        }
    }];
}

/*** post请求 ***/
+ (void)postWithPath:(NSString *)path Params:(nullable NSDictionary *)params requrieDataBack:(DlRequireDataBlock)requireDataBlock {
    [AFNetworkingClient postWithPath:path Params:params requrieDataBack:^(id data) {
        if ([data isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dic = data;
            if ([dic[@"code"] intValue] == 200) {
                id arr = dic[@"result"];
                requireDataBlock(arr);  //只考虑获取成功后的数据
            }else {
                requireDataBlock(dic[@"message"]);
            }
        }
    }];
}

/*** 上传图片文件:通过data形式 ***/
+ (void)uploadImagesWithPath:(NSString *)path Params:(nullable NSDictionary *)params imagesArray:(NSArray *)imagesArray requrieDataBack:(DlRequireDataBlock)requireDataBlock {
    [AFNetworkingClient uploadImagesWithPath:path Params:params imagesArray:imagesArray requrieDataBack:^(id  _Nonnull data) {
        if ([data isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dic = data;
            if ([dic[@"code"] intValue] == 200) {
                id arr = dic[@"result"];
                requireDataBlock(arr);  //只考虑获取成功后的数据
            }else {
                requireDataBlock(dic[@"message"]);
            }
        }
    }];
}
@end
