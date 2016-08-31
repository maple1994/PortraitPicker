//
//  Asset.h
//  testDemo
//
//  Created by maple on 16/8/24.
//  Copyright © 2016年 maple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

///图片资源模型
@interface AssetModel : NSObject
///图片资源
@property (nonatomic, strong) PHAsset *asset;
///缩略图
@property (nonatomic, strong) UIImage *thumbnailImage;
///原始图
@property (nonatomic, strong) UIImage *originalImage;

- (instancetype)initWithAsset:(PHAsset *)asset;

@end
