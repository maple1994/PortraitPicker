//
//  AlbumPickerController.m
//  testDemo
//
//  Created by maple on 16/8/24.
//  Copyright © 2016年 maple. All rights reserved.
//

#import "AlbumPickerController.h"
#import "PhotoPickerController.h"
#import "AssetModel.h"
#import "AlbumModel.h"
#import "ImagePickerController.h"
#import "ImageManager.h"
#import "AlbumPickerCell.h"
#import <Photos/Photos.h>

@interface AlbumPickerController ()
///相册数组
@property (nonatomic, strong) NSArray *alubmArray;

@end

@implementation AlbumPickerController

static NSString *ID = @"album";
- (void)viewDidLoad {
    [super viewDidLoad];
    //注册cell
    [self.tableView registerClass:[AlbumPickerCell class] forCellReuseIdentifier:ID];
    self.tableView.rowHeight = 70;
    
    //加载相册模型数组
//    [[ImageManager sharedManager] getAllAlbumCompletion:^(NSArray<AlbumModel *> *albumModelArray) {
//        self.alubmArray = albumModelArray;
//        [self.tableView reloadData];
//    }];
    self.alubmArray = [ImageManager sharedManager].albumModelArray;
    self.title = @"相册";
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.alubmArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AlbumPickerCell *cell = (AlbumPickerCell *)[tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    
    AlbumModel *model = self.alubmArray[indexPath.row];
    cell.albumModel = model;
    return cell;
}

#pragma mark - tableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    AlbumModel *model = self.alubmArray[indexPath.row];
    PhotoPickerController *photoPicker = [[PhotoPickerController alloc] init];
    ImagePickerController *pickerNav = (ImagePickerController *)self.navigationController;
    photoPicker.delegate = pickerNav.imagePickerDelegate;
    photoPicker.assetModelArray = model.models;
    photoPicker.title = model.name;
    [self.navigationController pushViewController:photoPicker animated:YES];
}





@end
