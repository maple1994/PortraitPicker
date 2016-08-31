//
//  Album.m
//  testDemo
//
//  Created by maple on 16/8/23.
//  Copyright © 2016年 maple. All rights reserved.
//

#import "AlbumModel.h"
#import "AssetModel.h"
#import <Photos/Photos.h>


@implementation AlbumModel

+ (instancetype)albumModelWithName:(NSString *)name result:(PHFetchResult *)result{
    NSMutableArray *assetArr = [NSMutableArray array];
    for (PHAsset *asset in result) {
        AssetModel *as = [[AssetModel alloc] initWithAsset:asset];
        [assetArr addObject:as];
    }
    AlbumModel *album = [[AlbumModel alloc] init];
    album.name = name;
    album.models = assetArr;
    album.count = assetArr.count;
    return album;
}

@end
