//
//  DCLocalImageUtils.h
//  Pods
//
//  Created by alex520biao on 15/11/19.
//
//

#ifndef DCLocalImageUtils_h
#define DCLocalImageUtils_h
#import "UIImage+ALLocal.h"

/*
 图片加载哪家强？不同的口味,总有一款适合你！
 
 //都需要#import "DCLocalImageUtils.h"
 UIImage *image = [UIImage imageNamed:DCImagePath(@"bts_homepage_button")];
 
 UIImage *image = DCImage(@"bts_homepage_button")
 
 //如果pod有多个pod建议使用此方法,模块自己可以根据此方法封装
 UIImage *image = [UIImage imageNamed:@"bts_homepage_button" inBundleName:DCBundleName];
 */


//顺风车图片bundle名
#define DCBundleName @"ALFoundation"

/*!
 *  @brief  获取顺风车ALFoundation包中的图片,DCImage会给imagePath添加DCBundleName包名
 *
 *  @param imagePath 图片在bundle中的相对路径(包含图片名称)
 *  @note  读取bundle图片: UIImage *image = DCImage(@"bts_homepage_button")
 *  @note  读取bundle子目录图片: UIImage *image = DCImage(@"new/dcpay_icon_alipay");
 *
 *  @return 图片对象
 */
#define DCImage(bundelImagePath)     [UIImage imageWithBundleName:DCBundleName relativePath:bundelImagePath]



#endif /* DCLocalImageUtils_h */
