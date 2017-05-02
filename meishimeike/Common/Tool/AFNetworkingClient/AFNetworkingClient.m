//
//  AFNetworkingClient.m
//  AFNetworkingClient
//
//  Created by zhenglong duan on 20/03/2017.
//  Copyright © 2017 zhenglong duan. All rights reserved.
//

#import "AFNetworkingClient.h"

@implementation AFNetworkingClient
/*** post 请求 ***/
+ (void)postWithPath:(NSString *)path Params:(nullable NSDictionary *)params requrieDataBack:(DlRequireDataBlock)requireDataBlock {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager setResponseSerializer:[AFHTTPResponseSerializer serializer]];//响应的数据格式 默认json
    [manager POST:path parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        requireDataBlock(uploadProgress); //返回进度
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        requireDataBlock(dictionary); //返回数据字典
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        requireDataBlock(error); //返回错误信息
    }];
}

/*** get请求 ***/
+ (void)getWithPath:(NSString *)path Params:(nullable NSDictionary *)params requrieDataBack:(DlRequireDataBlock)requireDataBlock {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager setResponseSerializer:[AFHTTPResponseSerializer serializer]];//响应的数据格式 默认json
    [manager GET:path parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        requireDataBlock(downloadProgress); //返回进度
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        requireDataBlock(dictionary); //返回数据字典
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        requireDataBlock(error); //返回错误信息
    }];
}

/*** 上传图片文件:通过data形式 ***/
+ (void)uploadImagesWithPath:(NSString *)path Params:(nullable NSDictionary *)params imagesArray:(NSArray *)imagesArray requrieDataBack:(DlRequireDataBlock)requireDataBlock {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager setResponseSerializer:[AFHTTPResponseSerializer serializer]];//响应的数据格式 默认json
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"]; //网络请求只支持text/json，application/json，text/javascript
    [manager POST:path parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        //获取图片参数,MultipartFormData:html的上传图片格式
        for (int i = 0; i < imagesArray.count; i++) {
            NSData *fileData = UIImagePNGRepresentation(imagesArray[i]);
            NSString *fileName = [NSString stringWithFormat:@"image%d.jpg",i + 1];
            //name:对应的是php中的$info["image"]的“image”
            [formData appendPartWithFileData:fileData name:@"image[]" fileName:fileName mimeType:@"image/jpg"];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        requireDataBlock(uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        requireDataBlock(dictionary); //返回数据字典
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        requireDataBlock(error); //返回错误信息
    }];
}

/*** 通过路径上传某个文件 ***/
+ (void)uploadFileWithPath:(NSString *)path Params:(nullable NSDictionary *)params fileUrlPath:(NSString *)urlPath fileName:(NSString *)fileName requrieDataBack:(DlRequireDataBlock)requireDataBlock {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager setResponseSerializer:[AFHTTPResponseSerializer serializer]];//响应的数据格式 默认json
    [manager POST:path parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        /*** 通过URL来获取文件路径 ***/
        [formData appendPartWithFileURL:[NSURL URLWithString:urlPath] name:@"file" fileName:fileName mimeType:@"application/json" error:nil];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        requireDataBlock(uploadProgress); //返回进度
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        requireDataBlock(dictionary); //返回数据字典
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        requireDataBlock(error); //返回错误信息
    }];
}


/*** 网络监听 ***/
+ (NSString *)AFNetworkStatus {
    __block NSString *statusStr = nil;
    //创建网络监测者
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        //这里是监测到网络改变的block  可以写成switch方便
        //在里面可以随便写事件
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                statusStr = @"未知网络状态!";
                break;
            case AFNetworkReachabilityStatusNotReachable:
                statusStr = @"当前无网络!";
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                statusStr = @"当前是蜂窝网络!";
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                statusStr = @"wifi网络!";
                break;
            default:
                break;
        }
    }] ;
    return statusStr;
}

@end
