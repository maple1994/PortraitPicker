//
//  ImagePickerViewController.h
//  testDemo
//
//  Created by maple on 16/8/23.
//  Copyright © 2016年 maple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PhotoPickerController;
@protocol ImagePickerControllerDelgate <NSObject>

/// 返回裁剪后的图片
- (void)imagePickerController:(PhotoPickerController *)imagePickerController didFinished:(UIImage *)editedImage;

@end

@interface PhotoPickerController : UIViewController


///是否显示相机胶卷内容
@property (nonatomic, assign, getter=isShowCameraRoll) BOOL showCameraRoll;
@property (nonatomic, weak) id<ImagePickerControllerDelgate> delegate;
/// 图片模型数组
@property (nonatomic, strong) NSArray *assetModelArray;

@end
