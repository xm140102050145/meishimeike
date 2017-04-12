//
//  AFNetworkingAPI.h
//  AFNetworkingClient
//
//  Created by zhenglong duan on 20/03/2017.
//  Copyright © 2017 zhenglong duan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworkingClient.h"

typedef void (^DlRequireDataBlock)(_Nonnull id data); //请求数据回调

@interface AFNetworkingAPI : NSObject
NS_ASSUME_NONNULL_BEGIN
/**
 post 请求
 
 @param path 请求数据地址
 @param params 请求参数
 @param requireDataBlock 回调请求成功后的数据
 */
+ (void)postWithPath:(NSString *)path Params:(nullable NSDictionary *)params requrieDataBack:(DlRequireDataBlock)requireDataBlock;

/**
 get 请求
 
 @param path 请求数据地址
 @param params 请求参数
 @param requireDataBlock 回调请求成功后的数据
 */
+ (void)getWithPath:(NSString *)path Params:(nullable NSDictionary *)params requrieDataBack:(DlRequireDataBlock)requireDataBlock;

/*** 上传图片文件:通过data形式 ***/
+ (void)uploadImagesWithPath:(NSString *)path Params:(nullable NSDictionary *)params imagesArray:(NSArray *)imagesArray requrieDataBack:(DlRequireDataBlock)requireDataBlock;

NS_ASSUME_NONNULL_END
@end
