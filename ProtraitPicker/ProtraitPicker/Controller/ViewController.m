//
//  ViewController.m
//  testDemo
//
//  Created by maple on 16/8/22.
//  Copyright © 2016年 maple. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+scale.h"
#import "PhotoPickerController.h"
#import "ImagePickerController.h"
#import "ImageManager.h"
#import <Photos/Photos.h>


@interface ViewController ()<ImagePickerControllerDelgate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation ViewController

static NSString *ID = @"cell";
- (void)viewDidLoad {
    [super viewDidLoad];
}

/**
 *  弹出图片选择器
 */
- (IBAction)showPicker {
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        if (status == PHAuthorizationStatusAuthorized) {
            ImagePickerController *alubmPicker = [[ImagePickerController alloc] initWithDelegate:self];
            [self presentViewController:alubmPicker animated:YES completion:nil];
        }else {
            [self showSetting];
        }
    }];
}

- (void)showSetting {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"请在系统设置中打开“允许访问图片”，否则将无法获取相机的图片" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"去开启" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    }];
    [alertVC addAction:cancle];
    [alertVC addAction:confirm];
    [self presentViewController:alertVC animated:YES completion:nil];
}

#pragma mark - ImagePickerControllerDelgate
- (void)imagePickerController:(PhotoPickerController *)imagePickerController didFinished:(UIImage *)editedImage {
    self.imageView.image = nil;
    self.imageView.image = [editedImage scaleImage];
//    self.imageView.image = editedImage;
    NSLog(@"vc--%@", self.imageView.image);
    [imagePickerController dismissViewControllerAnimated:YES completion:nil];
}



@end
