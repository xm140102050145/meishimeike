//
//  AFNetworkingClient.h
//  AFNetworkingClient
//
//  Created by zhenglong duan on 20/03/2017.
//  Copyright © 2017 zhenglong duan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

typedef void (^DlRequireDataBlock)(_Nonnull id data); //请求数据回调

@interface AFNetworkingClient : NSObject
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

/**
 上传图片文件:通过data形式

 @param path 请求数据地址
 @param params 请求参数
 @param imagesArray 存放图片的数组
 @param requireDataBlock 回调上传成功后的状态
 */
+ (void)uploadImagesWithPath:(NSString *)path Params:(nullable NSDictionary *)params imagesArray:(NSArray *)imagesArray requrieDataBack:(DlRequireDataBlock)requireDataBlock;


/**
 通过路径上传某个文件

 @param path 请求数据地址
 @param params 请求参数
 @param urlPath 要上传的文件地址
 @param fileName 文件名称
 @param requireDataBlock 回调上传成功后的状态
 */
+ (void)uploadFileWithPath:(NSString *)path Params:(nullable NSDictionary *)params fileUrlPath:(NSString *)urlPath fileName:(NSString *)fileName requrieDataBack:(DlRequireDataBlock)requireDataBlock;

NS_ASSUME_NONNULL_END

/*** 网络监听 ***/
+ (nonnull NSString *)AFNetworkStatus;
@end
