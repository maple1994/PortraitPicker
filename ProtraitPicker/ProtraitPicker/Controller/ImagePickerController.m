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
#import <Photos/Photos.h>


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
    [self pushPhotoPicker];
    return self;
}

- (void)pushPhotoPicker {
    PhotoPickerController *photoPicker = [[PhotoPickerController alloc] init];
    photoPicker.delegate = self.imagePickerDelegate;
    //默认显示相机胶卷
    photoPicker.showCameraRoll = YES;
    photoPicker.title = @"相机胶卷";
    [self pushViewController:photoPicker animated:YES];
}





@end
