//
//  ALLocalizedString.h
//  Pods
//
//  Created by alex on 2016/12/27.
//
//

#import <Foundation/Foundation.h>


/**
 获取指定pod包bundleName+当前语言包appLanguage.lproj+指定文件table.strings+指定key对应的文案

 @param key        文案key
 @param bundleName pod的包名
 @param table      国际化文件名 table.lproj
 
 */
#define ALLocalizedStringFromTableInBundle(key, tbl, bundle, comment) [ALLocalizedString localizedStringForKey:key bundleName:bundle table:tbl]

//苹果本地化语言格式字符串
typedef NSString ALLanguageStr;

/**
 ALLanguageStr
 iOS系统本地化语言对象: zh-Hans-HK(中文-繁体-香港)、en-CN(英文-中国)
 */
@interface ALLanguage : NSObject

/**
 iOS系统标准本地化语言类型字符串: 从iOS系统得到的原始语言字符串
 典型格式如: zh-Hans-HK(中文-繁体-香港)、en-CN(英文-中国)
 */
@property (nonatomic, copy,readonly) ALLanguageStr *languageStr;

/**
 语言大分类: 如en、zh等,必须小写
 */
@property (nonatomic, copy,readonly) NSString *firstclassification;

/**
 语言子分类: 如中文: Hans(简体)、Hant(繁体)，首字母大写其余小写
 中文等特殊语言有子分类
 */
@property (nonatomic, copy,readonly) NSString *subclassification;

/**
 语言国家/地区代码: CN(大陆)、HK(香港)、TW(台湾)、SG(新加坡)等
 */
@property (nonatomic, copy,readonly) NSString *region;

/**
 使用iOS系统标准语言格式字符串得到ALLanguage

 @param languageStr

 @return
 */
- (instancetype)initWithALLanguageStr:(ALLanguageStr*)languageStr;

/**
 firstClass+subClass，如: zh-Hans
 如果subClass不存在则只返回firstClass
 
 @return
 */
-(ALLanguageStr*)languageStrForFirstAndSubClass;

/**
 ALLanguage对象转换为ALLanguageStr
 firstClass+subClass+region，如:zh-Hans-HK
 
 @return
 */
-(ALLanguageStr*)languageStrForAll;


@end

@interface ALLocalizedString : NSObject

/**
 本地化文案
 */
@property (nonatomic, copy) NSString *localizedString;

@property (nonatomic, copy) NSString *localizedKey;
@property (nonatomic, copy) NSString *bundleName;
@property (nonatomic, copy) NSString *table;

/**
 所属语言
 */
@property (nonatomic, copy) ALLanguageStr *language;

/**
 读取文案的最终语言包
 */
@property (nonatomic, copy) ALLanguageStr *finalLanguage;



/**
 MainBundle+app包名中的国际化文本

 @param key

 @return
 */
-(NSString*)localizedStringForKey:(NSString*)key;

/**
 获取指定pod包bundleName+当前语言包appLanguage.lproj+指定文件table.strings+指定key对应的文案
 
 @param key        文案key
 @param bundleName pod的包名
 @param table      国际化文件名 table.lproj
 
 @return
 */
+(NSString*)localizedStringForKey:(NSString*)key bundleName:(NSString*)bundleName table:(NSString*)table;

/**
 获取指定pod包bundleName+当前语言包appLanguage.lproj+指定文件table.strings+指定key对应的文案
 
 @param key        文案key
 @param language   语言类型，格式如:zh-Hans-HK
 @param bundleName pod的包名
 @param table      国际化文件名 table.lproj
 
 @return
 */
+(ALLocalizedString*)localizedStringForKey:(NSString*)key language:(ALLanguageStr*)language bundleName:(NSString*)bundleName table:(NSString*)table;


/**
 根据xxxx.app中资源路径来获取国际化文案
 格式: @"bundleName(.bunndle文件名)/language(.lproj文件名)/table(.string文件名)/key(文案名)"
 实例: @"ALFoundation/zh-Hans/user/TName"
 
 @param path
 @return
 */
+(ALLocalizedString*)localizedStringForPath:(NSString*)path;

#pragma mark - 管理应用内语言
/**
 修改应用内语言
 
 @param sender
 */
+ (IBAction)changeLanguage:(UIButton *)sender;

/**
 获取应用内语言设置
 */
+(ALLanguageStr*)appLanguage;

@end
