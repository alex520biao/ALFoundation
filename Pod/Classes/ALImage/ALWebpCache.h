//
//  ALWebpCache.h
//  Pods
//
//  Created by alex on 2016/12/1.
//
//

#import <Foundation/Foundation.h>

@interface ALWebpCache : NSObject

+ (nonnull instancetype)sharedCache;

/**
 获取指定图片

 @param key

 */
- (nullable UIImage*)imageForKey:(NSString*)key;


/**
 添加/更新指定图片

 @param image
 @param key
 */
- (void)setImage:(UIImage*)image forKey:(NSString*)key;


/**
 删除指定图片

 @param key
 */
- (void)removeImageForKey:(NSString*)key;


/**
 清空内存缓存的webp图片
 */
- (void)clearMemoryCache;

@end
