# PortraitPicker
这是我用于头像上传的一个demo，可以从相册选择图片并裁剪，详情可看gif

##效果图：
![image](https://github.com/maple1994/PortraitPicker/blob/master/ProtraitPicker/gif/imagePicker.gif)

##实现步骤
###一、获取相册列表
获取相册这里，我参考了[TZImagePickerController](https://github.com/banchichen/TZImagePickerController)的源码，获取相册列表，相机内容。在这里有三个主要的类
* ImagePickerController，导航控制器的子类，由于相册选择的页面是modal出来的，为了方便push，pop，弄了这个导航控制器
* PhotoPickerController，UICollectionViewController的子类，用于显示相册的图片
* AlbumPickerController，UITableviewController的子类，用于显示相册

###二、裁剪
在裁剪这里，我使用了VPImageCropper第三方框架。具体使用方法，[点我](https://github.com/windshg/VPImageCropper)
