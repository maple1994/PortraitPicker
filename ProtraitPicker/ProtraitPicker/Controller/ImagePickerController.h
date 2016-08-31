//
//  ImagePickerController.h
//  testDemo
//
//  Created by maple on 16/8/24.
//  Copyright © 2016年 maple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoPickerController.h"


@interface ImagePickerController : UINavigationController

///保存代理对象，在下次创建图片选择控制器时传入
@property (nonatomic, weak) id<ImagePickerControllerDelgate> imagePickerDelegate;
- (instancetype)initWithDelegate:(id<ImagePickerControllerDelgate>)delegate;

@end
