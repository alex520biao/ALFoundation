//
//  ALFImage.h
//  Pods
//
//  Created by alex520biao on 15/11/19.
//
//

#ifndef ALFImage_h
#define ALFImage_h
#import <ALFoundation/UIImage+ALLocal.h>

//顺风车图片bundle名
#define ALFBundleName @"ALFoundation"

/*!
 *  @brief  获取ALFoundation包中的图片,ALFImage会给imagePath添加ALFBundleName包名
 *
 *  @param bundelImagePath 图片在bundle中的相对路径(包含图片名称)
 *  @return 图片对象
 */
#define ALFImage(relativePath)     [UIImage imageWithBundleName:@"ALFoundation" relativePath:relativePath]



#endif
