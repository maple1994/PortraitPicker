# PortraitPicker
这是我用于头像上传的一个demo，可以从相册选择图片并裁剪，详情可看gif

##效果图：
![image](https://github.com/maple1994/PortraitPicker/blob/master/ProtraitPicker/gif/imagePicker.gif)

##实现步骤
###一、获取相册列表
获取相册这里，我参考了[TZImagePickerController](https://github.com/banchichen/TZImagePickerController)的源码，获取相册列表，相机内容。在这里有三个主要的类：

* ImagePickerController, 导航控制器的子类，由于相册选择的页面是modal出来的，为了方便push，pop，弄了这个导航控制器
* PhotoPickerController，UICollectionViewController的子类，用于显示相册的图片
* AlbumPickerController，UITableviewController的子类，用于显示相册列表

还有一个工具类ImageManager，关于图片的一些操作可以通过这个类进行获取，属性以及方法如下

```objc
#import <UIKit/UIKit.h>
@class AlbumModel;
@class PHAsset;
@interface ImageManager : NSObject
///相册模型数组
@property (nonatomic, strong) NSArray<AlbumModel *> *albumModelArray;
///相机胶卷相册模型
@property (nonatomic, strong) AlbumModel *cameraRollAlbumModel;
+ (instancetype)sharedManager;
///获得原始图片
- (UIImage *)getOriginalImageWithAsset:(PHAsset *)asset;
///用户是否授权获取图片
- (BOOL)authorizationStatusAuthorized;
```

楼主将模型数组存储在单例对象中，有个好处就是只需获取一次相册。坏处就是不能实时更新相册里的内容，所以大家自己权衡吧。

###二、裁剪
在裁剪这里，我使用了VPImageCropper第三方框架。具体使用方法，[点我](https://github.com/windshg/VPImageCropper)
