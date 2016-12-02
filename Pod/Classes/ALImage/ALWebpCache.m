//
//  ALWebpCache.m
//  Pods
//
//  Created by alex on 2016/12/1.
//
//

#import "ALWebpCache.h"

@interface ALWebpCache ()

/**
    内存缓存管理器
 */
@property (nonatomic, strong) NSCache<NSString*, UIImage*> *cacheObject;

@end

@implementation ALWebpCache

+ (nonnull instancetype)sharedCache {
    static dispatch_once_t onceToken;
    static id instance;
    dispatch_once(&onceToken, ^{
        instance = [self new];
    });
    return instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _cacheObject = [NSCache new];
        _cacheObject.totalCostLimit = 100 * 1024 * 1024; //最大体积100M
        _cacheObject.countLimit = 15;   //最大个数
        _cacheObject.name = @"com.alex.webp.cache";
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(clearMemoryCache)
                                                     name:UIApplicationDidReceiveMemoryWarningNotification
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(clearMemoryCache)
                                                     name:UIApplicationDidEnterBackgroundNotification
                                                   object:nil];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setImage:(UIImage*)image forKey:(NSString*)key {
    NSCParameterAssert(image && key);
    NSCParameterAssert(key);
    if (image && key) {
        // ref: https://github.com/rs/SDWebImage/blob/master/SDWebImage/SDImageCache.m
        NSInteger cost = image.size.height * image.size.width * image.scale * image.scale;
        [self.cacheObject setObject:image forKey:key cost:cost];
    }
}

- (void)removeImageForKey:(NSString*)key {
    [self.cacheObject removeObjectForKey:key];
}

- (nullable UIImage*)imageForKey:(NSString*)key {
    return [self.cacheObject objectForKey:key];
}

- (void)clearMemoryCache {
    [self.cacheObject removeAllObjects];
}


@end
