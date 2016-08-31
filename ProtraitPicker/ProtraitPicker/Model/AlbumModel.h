//
//  Album.h
//  testDemo
//
//  Created by maple on 16/8/23.
//  Copyright © 2016年 maple. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PHFetchResult;

/// 相册模型
@interface AlbumModel : NSObject

/// 相册名
@property (nonatomic, copy) NSString *name;
/// 相册数
@property (nonatomic, assign) NSInteger count;
/// 图片模型数组，存储图片资源模型
@property (nonatomic, strong) NSArray *models;

+ (instancetype)albumModelWithName:(NSString *)name result:(PHFetchResult *)result;

@end
