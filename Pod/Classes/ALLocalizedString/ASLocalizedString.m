//
//  ASLocalizedString.m
//  Pods
//
//  Created by alex on 2016/12/27.
//
//

#import "ASLocalizedString.h"
static NSString *appLanguageKey = @"appLanguageKey";



@interface ALLanguage ()

/**
 从iOS系统得到的原始语言字符串
 */
@property (nonatomic, copy,readwrite) ALLanguageStr *languageStr;

/**
 语言大分类: 如en、zh等,必须小写
 */
@property (nonatomic, copy,readwrite) NSString *firstType;

/**
 语言子分类: 如中文: Hans(简体)、Hant(繁体)，首字母大写其余小写
 中文等特殊语言有子分类
 */
@property (nonatomic, copy,readwrite) NSString *subType;

/**
 语言国家/地区代码: CN(大陆)、HK(香港)、TW(台湾)、SG(新加坡)等
 */
@property (nonatomic, copy,readwrite) NSString *region;

@end


@implementation ALLanguage

- (instancetype)initWithALLanguageStr:(ALLanguageStr*)languageStr
{
    self = [super init];
    if (self) {
        if(languageStr){
            //保留原始字符串
            self.languageStr = languageStr;
            
            NSArray<NSString *> *components = [languageStr componentsSeparatedByString:@"-"];
            //一位
            if (components.count==1) {
                //如: zh
                self.firstType = [components objectAtIndex:0];
            }

            //两位
            if (components.count==2) {
                self.firstType = [components objectAtIndex:0];
                if([self.firstType isEqualToString:@"zh"] && [[components objectAtIndex:1] hasPrefix:@"Han"]){
                    //如： zh-Hans
                    self.subType = [components objectAtIndex:1] ;
                }else{
                    //如: zh-CN 非iOS标准格式
                    self.region = [components objectAtIndex:1];
                }
            }
            
            //三位及以上
            if (components.count>2) {
                //如: zh-Hant-HK
                self.firstType = [components objectAtIndex:0];
                self.subType = [components objectAtIndex:1];
                self.region = [components objectAtIndex:2];
            }
        }
    }
    return self;
}

/**
 ALLanguage对象转换为ALLanguageStr
 firstType+subType+region，如:zh-Hans-HK
 
 @return
 */
-(ALLanguageStr*)languageStrForAll{
    NSString *str = [NSString stringWithFormat:@"%@",self.firstType];
    if (self.subType) {
        str =[NSString stringWithFormat:@"%@-%@",str,self.subType];
    }
    if (self.region) {
        str =[NSString stringWithFormat:@"%@-%@",str,self.region];
    }
    return str;
}

/**
 firstType+subType，如: zh-Hans
 如果subType不存在则只返回firstType
 
 @return
 */
-(ALLanguageStr*)languageStrForFirstAndSubType{
    NSString *str = [NSString stringWithFormat:@"%@",self.firstType];
    if (self.subType) {
        str =[NSString stringWithFormat:@"%@-%@",str,self.subType];
    }
    return str;
}

@end


@implementation ASLocalizedString

/**
 MainBundle+app包名中的国际化文本
 
 @param key
 
 @return
 */
-(NSString*)localizedStringForKey:(NSString*)key{
    //应用内语言
    NSString *appLanguage = [[NSUserDefaults standardUserDefaults] objectForKey:@"appLanguageKey"];
    NSBundle *appLanguageBundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:appLanguage ofType:@"lproj"]];
    
    //操作系统语言
    NSArray *languages = [NSLocale preferredLanguages];
    NSString *currentLanguage = [languages objectAtIndex:0];
    //lproj目录
    NSString *lprojName = [NSString stringWithFormat:@"%@.lproj",currentLanguage];
    
    //app包名
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *appBundleName = [infoDictionary objectForKey:@"CFBundleName"];
    
    //读取mianBundle下appBundleName.string中的国际化文案
    NSString *localizedString = [appLanguageBundle localizedStringForKey:key value:nil table:appBundleName];

    return localizedString;
}

/**
 获取指定pod包bundleName+当前语言包appLanguage.lproj+指定文件table.strings+指定key对应的文案
 
 @param key        文案key
 @param bundleName pod的包名
 @param table      国际化文件名 table.lproj
 
 @return
 */
+(NSString*)localizedStringForKey:(NSString*)key bundleName:(NSString*)bundleName table:(NSString*)table{
    //当前语言 需要判断appLanguage为空的情况设置默认语言
    NSString *appLanguage = [[NSUserDefaults standardUserDefaults] objectForKey:appLanguageKey];
#warning appLanguage需要设置默认值
    appLanguage = @"zh-Hans-HK";
    ALLanguage *lang = [[ALLanguage alloc] initWithALLanguageStr:appLanguage];
    
    //当前操作系统语言
    NSArray *languages = [NSLocale preferredLanguages];// app所支持的语言
    NSString *currentOSLanguage = [languages objectAtIndex:0];
    
    
    //语言包 appLanguage为nil则默认读取en.lproj
    NSString *podBundlePath = [[NSBundle mainBundle] pathForResource:bundleName ofType:@"bundle"];
    NSBundle *podBundle = [NSBundle bundleWithPath:podBundlePath];
    
    //使用zh-Hans-HK字符串逐级递减查找对应的lproj包
    NSBundle *appLanguageBundle = [NSBundle bundleWithPath:[podBundle pathForResource:lang.languageStr ofType:@"lproj"]];
    if(!appLanguageBundle){
        //查找zh-Hans-HK.lproj
        appLanguageBundle = [NSBundle bundleWithPath:[podBundle pathForResource:lang.languageStrForAll ofType:@"lproj"]];
    }
    if(!appLanguageBundle){
        //查找zh-Hans.lproj
        appLanguageBundle = [NSBundle bundleWithPath:[podBundle pathForResource:lang.languageStrForFirstAndSubType ofType:@"lproj"]];
    }
    if(!appLanguageBundle){
        //查找zh.lproj
        appLanguageBundle = [NSBundle bundleWithPath:[podBundle pathForResource:lang.firstType ofType:@"lproj"]];
    }
    
    //读取mianBundle下appBundleName.string中的国际化文案
    NSString *localizedString = [appLanguageBundle localizedStringForKey:key value:nil table:table];
    
    return localizedString;
}


#pragma mark - 管理应用内语言
/**
 修改应用内语言

 @param sender
 */
+ (IBAction)changeLanguage:(UIButton *)sender {
    
    switch (sender.tag) {
        case 101: {
            //中文简体
            [[NSUserDefaults standardUserDefaults] setObject:@"zh-Hans" forKey:appLanguageKey];
            //zh-Hans-CN
            //zh-Hans-SG
        }
            break;
        case 102: {
            //中文繁体
            [[NSUserDefaults standardUserDefaults] setObject:@"zh-Hant" forKey:appLanguageKey];
            //zh-Hans-HK
            //zh-Hant-TW
        }
            break;
        case 103: {
            //英文
            [[NSUserDefaults standardUserDefaults] setObject:@"en" forKey:appLanguageKey];
            //en-CN  中式英语
        }
            break;
        default:
            break;
    }
}

@end
