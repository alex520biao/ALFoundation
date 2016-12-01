//
//  UIImage+ALSandbox.h
//  Pods
//
//  Created by alex520biao on 16/9/19.
//
//

#import <UIKit/UIKit.h>

/*!
 iOS沙盒中一般存放文件都在这三个子目录下
 */
typedef enum : NSUInteger {
    //Documents:应用中用户数据可以放在这里，iTunes备份和恢复的时候会包括此目录
    ALSandboxDocument,
    
    //Library/Caches：存放缓存文件，iTunes不会备份此目录，此目录下文件不会在应用退出删除
    ALSandboxCache,
    
    //tmp：存放临时文件，iTunes不会备份和恢复此目录，此目录下文件可能会在应用退出后删除
    ALSandboxTmp,
} ALSandboxType;

/*!
 *  @brief 应用加载本地sandbox中的图片
 *  @note  支持沙盒中的png、jpg、webp图片格式
 */
@interface UIImage (ALSandbox)

#pragma mark -- 加载ALSandbox沙盒中的图片

/*!
 *  @brief 获取Sandbox中的图片
 *
 *  @param type         沙盒目录类型
 *  @param relativePath 目录中的相对路径. 如, activity/activity_loading
 *  @note  relativePath支持png、jpg、webp格式
 *
 *  @return
 */
+(UIImage*)imageWithSandboxType:(ALSandboxType)type relativePath:(NSString*)relativePath;

/*!
 *  @brief 读取SandboxDocuments目录中的图片
 *
 *  @param relativePath 图片在SandboxDocuments目录的相对录几个
 *  @note  如relativePath为newImage/pin.png，则最后图片本地绝对路径为/Users/apple/Library/Application Support/iPhone Simulator/4.3/Applications/550AF26D-174B-42E6-881B-B7499FAA32B7/Documents/newImage/pin.png
 *  @note  relativePath支持png、jpg、webp格式
 *
 *  @return
 */
+ (UIImage*)imageInSandboxDocumentsWithRelativePath:(NSString*)relativePath;

#pragma mark - other
/*!
 *  @brief 判断fielPath路径指向文件是否存在
 *
 *  @param fielPath
 *
 *  @return
 */
+(BOOL)fileExistsAtPath:(NSString*)fielPath;

/*!
 *  @brief 获取Sandbox图片本地绝对路径
 *
 *  @param type         沙盒目录类型
 *  @param relativePath 图片在沙盒目录中的相对路径. 如, activity/activity_loading
 *  @note  relativePath支持png、jpg、webp格式
 *
 *  @return 图片文件在沙盒中的绝对路径
 */
+(NSString*)imagePathInSandboxWithType:(ALSandboxType)type relativePath:(NSString*)relativePath;

/*!
 *  @brief 将图片保存到sandbox沙盒中
 *
 *  @param sandboxImgPath 图片在沙盒中的绝对路径，包含文件必须是有后缀名。如image.png、newImage/image.png、xxxx@2x.webp等
 */
-(void)saveToSandboxWithAbsolutePath:(NSString*)sandboxImgPath;

/*!
 *  @brief 将图片保存到sandbox沙盒中
 *
 *  @param type         沙盒目录类型
 *  @param relativePath 图片在沙盒目录内部的相对路径,包含文件必须是有后缀名。如image.png、newImage/image.png、xxxx@2x.webp等
 */
-(void)saveToSandboxWithSanboxType:(ALSandboxType)type  relativePath:(NSString*)relativePath;

@end
