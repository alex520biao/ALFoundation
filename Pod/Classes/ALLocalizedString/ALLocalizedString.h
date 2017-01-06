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
 从iOS系统得到的原始语言字符串
 */
@property (nonatomic, copy,readonly) ALLanguageStr *languageStr;

/**
 语言大分类: 如en、zh等,必须小写
 */
@property (nonatomic, copy,readonly) NSString *firstType;

/**
 语言子分类: 如中文: Hans(简体)、Hant(繁体)，首字母大写其余小写
 中文等特殊语言有子分类
 */
@property (nonatomic, copy,readonly) NSString *subType;

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
 firstType+subType，如: zh-Hans
 如果subType不存在则只返回firstType
 
 @return
 */
-(ALLanguageStr*)languageStrForFirstAndSubType;

/**
 ALLanguage对象转换为ALLanguageStr
 firstType+subType+region，如:zh-Hans-HK
 
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
+(ALLocalizedString*)localizedStringForKey:(NSString*)key language:(ALLanguage*)language bundleName:(NSString*)bundleName table:(NSString*)table;


#pragma mark - 管理应用内语言
/**
 修改应用内语言
 
 @param sender
 */
+ (IBAction)changeLanguage:(UIButton *)sender;

@end
