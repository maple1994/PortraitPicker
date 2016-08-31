//
//  ImagePickerViewController.m
//  testDemo
//
//  Created by maple on 16/8/23.
//  Copyright © 2016年 maple. All rights reserved.
//

#import "PhotoPickerController.h"
#import "PhotoCollectionViewCell.h"
#import "VPImageCropperViewController.h"
#import "UIImage+scale.h"
#import "AssetModel.h"
#import "AlbumModel.h"
#import "ImageManager.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
#import <SVProgressHUD.h>

///cell间距
#define kMargin 5
///一行显示几个cell
#define kCount 3
///缩放比率
#define kScaleRatio 3.0

@interface PhotoPickerController () <UICollectionViewDelegate, UICollectionViewDataSource, VPImageCropperDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>
///图片资源数组
@property (nonatomic, strong) NSMutableArray *assetArray;
@property (nonatomic, weak) UICollectionView *collectionView;
@end

@implementation PhotoPickerController

- (void)setAssetModelArray:(NSArray *)assetModelArray {
    _assetModelArray = assetModelArray;
    [self.collectionView reloadData];
}

static NSString *ID = @"cell";
- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self setupNavgationBar];
    //显示相机胶卷相册内容
    if(self.isShowCameraRoll) {
        [self showCameraRollContent];
    }
}

///显示相机胶卷相册内容
- (void)showCameraRollContent {
    [SVProgressHUD showWithStatus:@"加载中..."];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        self.assetModelArray = [ImageManager sharedManager].cameraRollAlbumModel.models;
        [SVProgressHUD dismiss];
        //要在主线程刷新UI
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
        });
    });

}

- (void)setupNavgationBar {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancle)];
}

- (void)cancle {
    [self dismissViewControllerAnimated:YES completion:nil];
}


/**
 *  显示图片编辑界面
 */
- (void)showEditImageController:(UIImage *)image {
    CGFloat y = (self.view.bounds.size.height - self.view.bounds.size.width) / 2.0;
    VPImageCropperViewController *imageCropper = [[VPImageCropperViewController alloc] initWithImage:image cropFrame:CGRectMake(0, y, self.view.bounds.size.width, self.view.bounds.size.width) limitScaleRatio:kScaleRatio];
    imageCropper.delegate = self;
    [self.navigationController pushViewController:imageCropper animated:YES];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.assetModelArray.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PhotoCollectionViewCell *cell = (PhotoCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    if (indexPath.row == 0) {
        cell.image = [UIImage imageNamed:@"takePicture"];
        return cell;
    }
    AssetModel *asset = self.assetModelArray[indexPath.row - 1];
    cell.asset = asset;
    
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    //处理点击相机的事件
    if (indexPath.row == 0) {
        NSLog(@"点击了相机");
        UIImagePickerController *imgPicker = [[UIImagePickerController alloc] init];
        imgPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        imgPicker.delegate = self;
        [self presentViewController:imgPicker animated:YES completion:nil];
        return;
    }
    //显示编辑界面
    PhotoCollectionViewCell *cell = (PhotoCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [self showEditImageController:cell.asset.originalImage];
}

#pragma mark - VPImageCropperDelegate
- (void)imageCropper:(VPImageCropperViewController *)cropperViewController didFinished:(UIImage *)editedImage {
    if ([self.delegate respondsToSelector:@selector(imagePickerController:didFinished:)]) {
        NSLog(@"%@", editedImage);
        [self.delegate imagePickerController:self didFinished:editedImage];
    }
}
- (void)imageCropperDidCancel:(VPImageCropperViewController *)cropperViewController{
    [cropperViewController.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *image = [info[@"UIImagePickerControllerOriginalImage"] scaleImage];
    [picker dismissViewControllerAnimated:YES completion:^{
        [self showEditImageController:image];
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 懒加载
- (NSMutableArray *)assetArray {
    if (_assetArray == nil) {
        _assetArray = [NSMutableArray array];
    }
    return _assetArray;
}

- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        //设置布局属性
        UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
        CGFloat wid = ([UIScreen mainScreen].bounds.size.width - (kCount - 1) * kMargin) / kCount;
        flow.itemSize = CGSizeMake(wid, wid);
        flow.minimumLineSpacing = kMargin;
        flow.minimumInteritemSpacing = kMargin;
        
        //添加collectionView
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) collectionViewLayout:flow];
        self.collectionView = collectionView;
        self.collectionView.backgroundColor = [UIColor whiteColor];
        //设置代理
        self.collectionView.dataSource = self;
        self.collectionView.delegate = self;
        //注册
        [self.collectionView registerClass:[PhotoCollectionViewCell class] forCellWithReuseIdentifier:ID];
        [self.view addSubview:collectionView];
    }
    return _collectionView;
}


@end
