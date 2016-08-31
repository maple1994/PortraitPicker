//
//  ImagePickerController.m
//  testDemo
//
//  Created by maple on 16/8/24.
//  Copyright © 2016年 maple. All rights reserved.
//

#import "ImagePickerController.h"
#import "PhotoPickerController.h"
#import "AlbumPickerController.h"
#import "ImageManager.h"
#import "AlbumModel.h"


@interface ImagePickerController ()

@end

@implementation ImagePickerController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (instancetype)initWithDelegate:(id<ImagePickerControllerDelgate>)delegate; {
    AlbumPickerController *albumPicker = [[AlbumPickerController alloc] init];
    self = [super initWithRootViewController:albumPicker];
    _imagePickerDelegate = delegate;
    PhotoPickerController *photoPicker = [[PhotoPickerController alloc] init];
    photoPicker.delegate = delegate;
    //默认显示相机胶卷
    photoPicker.showCameraRoll = YES;
    photoPicker.title = @"相机胶卷";
    [self pushViewController:photoPicker animated:YES];
    return self;
}





@end
