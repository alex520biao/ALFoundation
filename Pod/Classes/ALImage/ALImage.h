//
//  ALImage.h
//  Pods
//
//  Created by alex on 2016/11/30.
//
//

#ifndef ALImage_h
#define ALImage_h

/*!
 *  ALImage是对UIImage功能扩展。此头文件基本上满足了iOS应用程序开发所需的全部图片加载需求,也可以按照需要单独引入
 *
 *  按照图片位置划分UIImage+ALAsset(Asset资源)、UIImage+ALBundle(程序包)、UIImage+ALSandbox(沙盒)、SDWebImage(网络)
 *
 *  按照图片格式划分png、jpg、gif、webp等
 *
 */

//加载应用Asset中launch及icon
#import "UIImage+ALAsset.h"

//加载程序包中的图片
#import "UIImage+ALBundle.h"

//加载本地sandbox中的图片
#import "UIImage+ALSandbox.h"

//加载本地webp图片
#import "UIImage+ALWebP.h"

//加载网络png、jpg、webp、gif均使用SDWebImage即可
#import "UIImageView+WebCache.h"

#endif /* ALImage_h */
