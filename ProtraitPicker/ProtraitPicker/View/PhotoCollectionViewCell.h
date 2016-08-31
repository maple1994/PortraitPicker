//
//  PhotoCollectionViewCell.h
//  testDemo
//
//  Created by maple on 16/8/23.
//  Copyright © 2016年 maple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>
@class AssetModel;
@interface PhotoCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) AssetModel *asset;

@end
