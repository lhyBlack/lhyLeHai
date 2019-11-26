//
//  NSString+Utils.h
//  DLB
//
//  Created by 战明 on 15/10/25.
//  Copyright © 2015年 dalvbang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (Utils)


#pragma mark -- 验证方法
/**加密后的身份证号
 规则：前1，后q1，中间*号
 */
- (NSString *)sd_encryptedIdCardNum;
/**加密后的手机号*/
- (NSString *)sd_encryptedPhoneNum;


/**每4位分隔*/
- (NSString *)sd_formatedBankCardNum;

/**格式化手机号前三位，后四位分隔*/
- (NSString *)sd_formatedPhoneNum;

- (BOOL)judgeUserName;

- (BOOL)isNumberBegin;


/**
 手机号码验证

 @return 验证成功返回YES，失败返回NO
 */
- (BOOL)validateMobile;

/**
 邮箱验证

 @return 验证成功返回YES，失败返回NO
 */
- (BOOL)validateEmail;

/**
 昵称验证

 @return 验证成功返回YES，失败返回NO
 */
- (BOOL)validateNickName;

/**
 密码验证

 @return 验证成功返回YES，失败返回NO
 */
-(BOOL)isValidPassword;

/**
 身份证验证

 @return 验证成功返回YES，失败返回NO
 */
- (BOOL)validateIdentityCard;


/**
 验证身份证号

 @return 验证成功返回YES，失败返回NO
 */
- (BOOL)validIDCardNumber;

/**
 验证是否是数字

 @return 验证成功返回YES，失败返回NO
 */
- (BOOL)validateNum;

/**
 判断是否为整形

 @return 验证成功返回YES，失败返回NO
 */
- (BOOL)sd_isPureInt;

/**
 判断是否为浮点形

 @return 验证成功返回YES，失败返回NO
 */
- (BOOL)sd_isPureFloat;

/**
 判断是金额
 
 @return 是返回YES，不是返回NO
 */

- (BOOL)isMoeny;


/**
 判断是否包含Emoji

 @return 验证成功返回YES，失败返回NO
 */
- (BOOL)stringContainsEmoji;

/**
 判断是否是平台名称
 
 @return 验证成功返回YES，失败返回NO
 */
- (BOOL)validatePlatformName;

/**
 判断是否是期数
 
 @return 验证成功返回YES，失败返回NO
 */
- (BOOL)validatePeriods;

/**
 是否包含emoji，并判断emoji位置

 @param result 判断成功和位置
 */
- (void)stringContainsEmojiWithResult:(void(^)(BOOL returnValue, NSRange substringRange))result;


#pragma mark -- 加密和转换方法

/**
 进行MD5加密

 @return 加密后字符串
 */
- (NSString *)md5String;

/**
 进行sha1加密

 @return 加密后字符串
 */
- (NSString *)sha1;

/**
 进行base64 编码

 @param str 需要编码字符串
 @return 编码后字符串
 */
+ (NSString *)enCodeBase64WithStr:(NSString *)str;

/**
 进行base64 解码

 @param str 需要编码字符串
 @return 解码后字符串
 */
+ (NSString *)unEnCodeBase64WithStr:(NSString *)str;

/**
 将NSString转换成十六进制的字符串
 
 @param str 需要转换的字符串
 @return 转换后字符串
 */
+ (NSString *)convertStringToHexStr:(NSString *)str;

/**
 UFT-8转换
 
 @param enString 需要转换的字符串
 @return 转换后的字符串
 */
+ (NSString *)stringForChineseToEN:(NSString *)enString;

#pragma mark -- 字符串大小相关方法

/**
 *  获得字符串的size
 *
 *  @param font 字符串的字体
 *  @param maxW 最大宽度
 *
 *  @return 字符串的size
 */
- (CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW;

/**
 *  获得字符串的size
 *
 *  @param font 字符串的字体
 *
 *  @return 字符串的size
 */
-(CGFloat)sizeWithFont:(UIFont*)font maxW:(CGFloat)maxW lineSpacing:(CGFloat)lineSpacing;

/**
 获得字符串的size

 @param font 字符串的字体
 @return 字符串的size
 */
- (CGSize)sizeWithFont:(UIFont *)font;



#pragma mark -- 时间相关方法

/**
 将时间戳转换成标准时间

 @param timeStr 时间戳
 @param ishour 是否有小时
 @return 标准时间
 */
+ (NSString *)creatStringTimeWithStr:(NSString *)timeStr andIshour:(BOOL)ishour;



#pragma mark -- 其他功能型方法

/**
 去除字符串的空格
 
 @return 返回空格去除后的字符串
 */
- (NSString *)removeSpace;

/**
 判断字节个数
 
 @return 返回字节个数
 */
- (NSUInteger)unicodeLengthOfString;

/**
 获取随机数字符串
 
 @return 随机数字符串
 */
+ (NSString *)getTimeAndRandom;


/**
 获取主路径：NSDocumentDirectory

 @param path 文件名字
 @return 拼接后的路径
 */
+ (NSString *)stringToPath:(NSString *)path;

/**
 改变字符中某一段的字体颜色和大小

 @param range NSRange
 @param color 修改后的颜色
 @param font  修改后的字体大小
 @return NSMutableAttributedString
 */
- (NSMutableAttributedString *)cm_changeTextRange:(NSRange)range Color:(UIColor *)color Font:(UIFont *)font;


/**
 将不合法的字符串转换为空字符串
 
 @return 转化后的字符串
 */
- (NSString *)sd_validString;


/**
 字符串是否合法
 
 @return 是否合法
 */
- (BOOL )sd_isValid;



@end
