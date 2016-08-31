//
//  Asset.m
//  testDemo
//
//  Created by maple on 16/8/24.
//  Copyright © 2016年 maple. All rights reserved.
//

#import "AssetModel.h"
#import "ImageManager.h"

@implementation AssetModel

- (instancetype)initWithAsset:(PHAsset *)asset {
    if (self = [super init]) {
        PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
        // 同步获得图片, 只会返回1张图片
        options.synchronous = YES;
        options.deliveryMode = PHImageRequestOptionsDeliveryModeOpportunistic;
        
        //获得缩略图
        [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:CGSizeMake(200, 200) contentMode:PHImageContentModeDefault options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            self.thumbnailImage = result;
        }];
        self.asset = asset;
    }
    return self;
}

- (UIImage *)originalImage {
//    _originalImage = ;
    return [[ImageManager sharedManager] getOriginalImageWithAsset:self.asset];
}

@end
