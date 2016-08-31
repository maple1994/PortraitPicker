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
    ImagePickerController *alubmPicker = [[ImagePickerController alloc] initWithDelegate:self];
    [self presentViewController:alubmPicker animated:YES completion:nil];
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
