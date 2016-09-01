//
//  ImageManager.m
//  testDemo
//
//  Created by maple on 16/8/25.
//  Copyright © 2016年 maple. All rights reserved.
//

#import "ImageManager.h"
#import <Photos/Photos.h>
#import "AlbumModel.h"
#import "AssetModel.h"

@implementation ImageManager

static id instance;
+ (instancetype)sharedManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [super allocWithZone:zone];
    });
    return instance;
}

///获得相机胶卷
- (void)getCameraRollAlbumCompletion:(void (^)(AlbumModel *model))completion {
    for (AlbumModel *model in self.albumModelArray) {
        if ([model.name isEqualToString:@"Camera Roll"] || [model.name isEqualToString:@"相机胶卷"] ||  [model.name isEqualToString:@"所有照片"] || [model.name isEqualToString:@"All Photos"]) {
            if (completion) {
                completion(model);
                break;
            }
        }
    }
}

///获得所有相册
- (void)getAllAlbumCompletion:(void (^)(NSArray<AlbumModel *> *albumModelArray))completion {
    NSMutableArray *albumModelArray = [NSMutableArray array];
    PHFetchOptions *option = [[PHFetchOptions alloc] init];
    option.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"modificationDate" ascending:NO]];
    option.predicate = [NSPredicate predicateWithFormat:@"mediaType == %ld", PHAssetMediaTypeImage];
    // 获得所有的自定义相簿
    PHFetchResult *smartAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    // 遍历所有的自定义相簿
    for (PHAssetCollection *assetCollection in smartAlbums) {
        PHFetchResult<PHAsset *> *result = [PHAsset fetchAssetsInAssetCollection:assetCollection options:option];
        //若该相册没有图片，则不显示
        if (result.count < 1 || [assetCollection.localizedTitle isEqualToString:@"视频"]) continue;
        AlbumModel *album = [AlbumModel albumModelWithName:assetCollection.localizedTitle result:result];
        [albumModelArray addObject:album];
    }
    if (completion) {
        completion(albumModelArray);
    }
}

///获得原始图片
- (UIImage *)getOriginalImageWithAsset:(PHAsset *)asset;{
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    // 同步获得图片, 只会返回1张图片
    options.synchronous = YES;
    options.deliveryMode = PHImageRequestOptionsDeliveryModeOpportunistic;
    __block UIImage *image = [[UIImage alloc] init];
    //获得原始图
    [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:CGSizeMake(asset.pixelWidth, asset.pixelHeight) contentMode:PHImageContentModeDefault options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        image = result;
    }];
    return image;
}

- (NSArray<AlbumModel *> *)albumModelArray {
    if (_albumModelArray == nil) {
        [self getAllAlbumCompletion:^(NSArray<AlbumModel *> *albumModelArray) {
            _albumModelArray = albumModelArray;
        }];
    }
    return _albumModelArray;
}

- (AlbumModel *)cameraRollAlbumModel {
    if (_cameraRollAlbumModel == nil) {
        [self getCameraRollAlbumCompletion:^(AlbumModel *model) {
            _cameraRollAlbumModel = model;
        }];
    }
    return _cameraRollAlbumModel;
}


@end











