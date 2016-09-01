//
//  ImageManager.h
//  testDemo
//
//  Created by maple on 16/8/25.
//  Copyright © 2016年 maple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AlbumModel;
@class PHAsset;
@interface ImageManager : NSObject

///相册模型数组
@property (nonatomic, strong) NSArray<AlbumModel *> *albumModelArray;
///相机胶卷相册模型
@property (nonatomic, strong) AlbumModel *cameraRollAlbumModel;

+ (instancetype)sharedManager;

///获得原始图片
- (UIImage *)getOriginalImageWithAsset:(PHAsset *)asset;


@end
