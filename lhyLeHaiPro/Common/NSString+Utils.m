//
//  NSString+Utils.m
//  DLB
//
//  Created by 战明 on 15/10/25.
//  Copyright © 2015年 dalvbang. All rights reserved.
//

#import "NSString+Utils.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonHMAC.h>




@implementation NSString (Utils)

- (NSString *)sd_encryptedIdCardNum {

    if (self.length >= 15) {
        return [NSString stringWithFormat:@"%@****************%@",[self substringToIndex:1],[self substringFromIndex:self.length - 1]];
    }
    
    return self;
    
}
- (NSString *)sd_encryptedPhoneNum {
    
   
    if (self.length == 11) {
        return [NSString stringWithFormat:@"%@****%@",[self substringToIndex:3],[self substringFromIndex:7]];
    }
    
    return self;
    
}

/**格式化手机号前三位，后四位分隔*/
- (NSString *)sd_formatedBankCardNum {
    
    NSMutableString *mString = [self mutableCopy];
    NSUInteger count = mString.length / 4;
    count = (mString.length % 4 )?:(count - 1);
    for (NSUInteger i = 0; i < count; i ++) {
        [mString insertString:@" " atIndex: (i+1)*4 + i];
    }
    
    return [mString copy];
}

- (NSString *)sd_formatedPhoneNum {
    
    if (self.length == 11) {
        NSMutableString *mString = [self mutableCopy];
        [mString insertString:@" " atIndex:3];
        [mString insertString:@" " atIndex:mString.length - 3];
        
        return [mString copy];
    }

    return self;
    
    
}

- (BOOL)judgeUserName {
    
//    NSString *nickNameRegex = @"^[-A-Za-z\u4e00-\u9fa5][-A-Za-z0-9\u4e00-\u9fa5]{0,15}$";
    NSString *nickNameRegex = @"^[-A-Za-z0-9\u4e00-\u9fa5]{0,20}$";
    NSPredicate *nickNameTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", nickNameRegex];
    return [nickNameTest evaluateWithObject:self];
}

- (BOOL)isNumberBegin {
    
    NSString *regex = @"^[0-9]+";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:self];
}



- (NSString *)md5String
{
    const char *string = self.UTF8String;
    int length = (int)strlen(string);
    unsigned char bytes[CC_MD5_DIGEST_LENGTH];
    CC_MD5(string, length, bytes);
    return [self stringFromBytes:bytes length:CC_MD5_DIGEST_LENGTH];
}


- (NSString *)stringFromBytes:(unsigned char *)bytes length:(int)length
{
    NSMutableString *mutableString = @"".mutableCopy;
    for (int i = 0; i < length; i++)
        [mutableString appendFormat:@"%02x", bytes[i]];
    return [NSString stringWithString:mutableString];
}

- (BOOL)validateMobile
{
    //手机号以1开头，十个 \d 数字字符
    NSString *phoneRegex = @"^1[3|4|5|6|7|8|9]\\d{9}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    return [phoneTest evaluateWithObject:self];
}

- (BOOL)validateEmail
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

- (BOOL)validateNickName {
    
    if ([self unicodeLengthOfString] > 20 || [self unicodeLengthOfString] < 6) {
        return NO;
    }
    
    NSString *nickNameRegex = @"^[-A-Za-z0-9_\u4e00-\u9fa5]{3,20}$";
    NSPredicate *nickNameTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", nickNameRegex];
    return [nickNameTest evaluateWithObject:self];
}

// 判断位数
- (NSUInteger) unicodeLengthOfString {
    NSUInteger asciiLength = 0;
    for (NSUInteger i = 0; i < self.length; i++) {
        unichar uc = [self characterAtIndex: i];
        asciiLength += isascii(uc) ? 1 : 2;
    }
    
    return asciiLength;
}


//判断是否有emoji
-(BOOL)stringContainsEmoji
{
    __block BOOL returnValue = NO;
    
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length])
                             options:NSStringEnumerationByComposedCharacterSequences
                          usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                              const unichar high = [substring characterAtIndex: 0];
                              
                              // Surrogate pair (U+1D000-1F9FF)
                              if (0xD800 <= high && high <= 0xDBFF) {
                                  const unichar low = [substring characterAtIndex: 1];
                                  const int codepoint = ((high - 0xD800) * 0x400) + (low - 0xDC00) + 0x10000;
                                  
                                  if (0x1D000 <= codepoint && codepoint <= 0x1F9FF){
                                      returnValue = YES;
                                  }
                                  
                                  // Not surrogate pair (U+2100-27BF)
                              } else {
                                  if (0x2100 <= high && high <= 0x27BF){
                                      returnValue = YES;
                                  }
                              }
                          }];
    
    return returnValue;
}



//判断是否有emoji
- (void)stringContainsEmojiWithResult:(void(^)(BOOL returnValue, NSRange substringRange))result
{
    __block BOOL returnValue = NO;
    
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length])
                             options:NSStringEnumerationByComposedCharacterSequences
                          usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                              const unichar high = [substring characterAtIndex: 0];
                              
                              // Surrogate pair (U+1D000-1F9FF)
                              if (0xD800 <= high && high <= 0xDBFF) {
                                  const unichar low = [substring characterAtIndex: 1];
                                  const int codepoint = ((high - 0xD800) * 0x400) + (low - 0xDC00) + 0x10000;
                                  
                                  if (0x1D000 <= codepoint && codepoint <= 0x1F9FF){
                                    
                                      returnValue = YES;
                                      
                                      *stop = YES;
                                      result(returnValue, substringRange);
                                  }
                                  
                                  // Not surrogate pair (U+2100-27BF)
                              } else {
                                  if (0x2100 <= high && high <= 0x27BF){
                                      returnValue = YES;
                                      *stop = YES;
                                      
                                      result(returnValue, substringRange);
                                  }
                              }
                              
                              
                              
                          }];
    

}





- (BOOL)isValidPassword {
    //以字母开头，只能包含“字母”，“数字”，“下划线”，长度6~20
    NSString *regex = @"^([a-zA-Z]|[a-zA-Z0-9_]|[0-9]){6,20}$";
    return [self isValidateByRegex:regex];
}

- (BOOL)isValidateByRegex:(NSString *)regex {
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [pre evaluateWithObject:self];
}

- (BOOL)validateNum
{
    NSString *emailRegex = @"^[0-9]\\d*$";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

- (BOOL)isMoeny
{
    NSString *emailRegex = @"^([1-9]\\d{0,9}|0)([.]?|(\\.\\d{1,9})?)$";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}



// 判断是否为整形：
- (BOOL)sd_isPureInt{
    NSScanner* scan = [NSScanner scannerWithString:self];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

// 判断是否为浮点形：
- (BOOL)sd_isPureFloat{
    NSScanner* scan = [NSScanner scannerWithString:self];
    float val;
    return[scan scanFloat:&val] && [scan isAtEnd];
}

- (NSString *)removeSpace{
    
    NSString *str = self;
    
    //1. 去除掉首尾的空白字符和换行字符
    str = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    //2. 去除掉其它位置的空白字符和换行字符
    str = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    return  str;
}






- (CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW
{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

- (CGSize)sizeWithFont:(UIFont *)font
{
    return [self sizeWithFont:font maxW:MAXFLOAT];
}

-(CGFloat)sizeWithFont:(UIFont*)font maxW:(CGFloat)maxW lineSpacing:(CGFloat)lineSpacing{
    
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = NSTextAlignmentLeft;
    paraStyle.lineSpacing = lineSpacing;
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle};
    
    CGSize size = [self boundingRectWithSize:CGSizeMake(maxW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return size.height;
}




+(NSString *)enCodeBase64WithStr:(NSString *)str
{
    
    NSData* originData = [str dataUsingEncoding:NSASCIIStringEncoding];
    
    NSString* encodeResult = [originData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    
    return encodeResult;
}

+(NSString *)unEnCodeBase64WithStr:(NSString *)str
{
    
    NSData* decodeData = [[NSData alloc] initWithBase64EncodedString:str options:0];
    
    NSString* decodeStr = [[NSString alloc] initWithData:decodeData encoding:NSASCIIStringEncoding];
    
    return decodeStr;
    
}

+ (NSString *)stringForChineseToEN:(NSString *)enString {
    
    NSString *string = [[self stringWithFormat:@"%@", enString] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    
    return string;
}

+ (NSString *)getTimeAndRandom{
    int iRandom = arc4random();
    if (iRandom < 0) {
        iRandom = -iRandom;
    }
    NSDateFormatter *tFormat = [[NSDateFormatter alloc] init];
    [tFormat setDateFormat:@"yyyyMMddHHmmss"];
    NSString *tResult=[NSString stringWithFormat:@"%@%d", [tFormat stringFromDate:[NSDate date]], iRandom];
    return tResult;
}


+ (NSString *)creatStringTimeWithStr:(NSString *)timeStr andIshour:(BOOL)ishour
{
    // 时间戳转换成标准时间
    NSDateFormatter *fm = [[NSDateFormatter alloc] init];
    if(ishour)
    {
       [fm setDateFormat:@"yyyy-MM-dd HH:mm"];
        
    }
    else
    {
        [fm setDateFormat:@"yyyy-MM-dd"];
    }
    NSTimeInterval timeInterval = [timeStr doubleValue]/1000;
    //long long int date1 = (long long int)[timeStr intValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSString *dateStr = [fm stringFromDate:date];
    return dateStr;
}



//身份证号
- (BOOL)validateIdentityCard {
    BOOL flag;
    if (self.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 =  @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:self];
    
}

//平台名称
- (BOOL)validatePlatformName{
    BOOL flag;
    if (self.length < 3 && self.length >15) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"[\u4e00-\u9fa5_a-zA-Z0-9]{3,15}";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:self];
}

//期数
- (BOOL)validatePeriods{
    BOOL flag;
    if ( self.length > 2) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"(^(1|[1-9][0-9]*)$){1,2}";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:self];
}



+(NSString *)convertStringToHexStr:(NSString *)str {
    if (!str || [str length] == 0) {
        return @"";
    }
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableString *string = [[NSMutableString alloc] initWithCapacity:[data length]];
    
    [data enumerateByteRangesUsingBlock:^(const void *bytes, NSRange byteRange, BOOL *stop) {
        unsigned char *dataBytes = (unsigned char*)bytes;
        for (NSInteger i = 0; i < byteRange.length; i++) {
            NSString *hexStr = [NSString stringWithFormat:@"%x", (dataBytes[i]) & 0xff];
            if ([hexStr length] == 2) {
                [string appendString:hexStr];
            } else {
                [string appendFormat:@"0%@", hexStr];
            }
        }
    }];
    
    return string;
}


- (NSString*)sha1
{
//    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
//    
//    NSData *data = [NSData dataWithBytes:cstr length:[self unicodeLengthOfString]];
    
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    //使用对应的CC_SHA1,CC_SHA256,CC_SHA384,CC_SHA512的长度分别是20,32,48,64
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    //使用对应的CC_SHA256,CC_SHA384,CC_SHA512
    CC_SHA1(data.bytes, data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}


#pragma mark -- 路径
+ (NSString *)stringToPath:(NSString *)path {
    return [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:path];
}


#pragma mark 验证身份证号码
- (BOOL)validIDCardNumber {
    NSString *regex = @"(^\\d{15}$)|(^\\d{17}([0-9]|X)$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if (![predicate evaluateWithObject:self]) return NO;
    // 省份代码。如果需要更精确的话，可以把六位行政区划代码都列举出来比较。
    NSString *provinceCode = [self substringToIndex:2];
    NSArray *proviceCodes = @[@"11", @"12", @"13", @"14", @"15",
                              @"21", @"22", @"23",
                              @"31", @"32", @"33", @"34", @"35", @"36", @"37",
                              @"41", @"42", @"43", @"44", @"45", @"46",
                              @"50", @"51", @"52", @"53", @"54",
                              @"61", @"62", @"63", @"64", @"65",
                              @"71", @"81", @"82", @"91"];
    if (![proviceCodes containsObject:provinceCode]) return NO;
    
    if (self.length == 15) {
        return [self validate15DigitsIDCardNumber];
    } else {
        return [self validate18DigitsIDCardNumber];
    }
}

// Helpers
/// 15位身份证号码验证。6位行政区划代码 + 6位出生日期码(yyMMdd) + 3位顺序码
- (BOOL)validate15DigitsIDCardNumber {
    NSString *birthday = [NSString stringWithFormat:@"19%@", [self substringWithRange:NSMakeRange(6, 6)]]; // 00后都是18位的身份证号
    
    return [birthday validateBirthDate];
}

/// 18位身份证号码验证。6位行政区划代码 + 8位出生日期码(yyyyMMdd) + 3位顺序码 + 1位校验码
- (BOOL)validate18DigitsIDCardNumber {
    NSString *birthday = [self substringWithRange:NSMakeRange(6, 8)];
    if (![birthday validateBirthDate]) return NO;
    
    // 验证校验码
    int weight[] = {7,9,10,5,8,4,2,1,6,3,7,9,10,5,8,4,2};
    
    int sum = 0;
    for (int i = 0; i < 17; i ++) {
        sum += [self substringWithRange:NSMakeRange(i, 1)].intValue * weight[i];
    }
    int mod11 = sum % 11;
    NSArray<NSString *> *validationCodes = [@"1 0 X 9 8 7 6 5 4 3 2" componentsSeparatedByString:@" "];
    NSString *validationCode = validationCodes[mod11];
    
    return [self hasSuffix:validationCode];
}

/// 验证出生年月日(yyyyMMdd)
- (BOOL)validateBirthDate {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyyMMdd";
    NSDate *date = [dateFormatter dateFromString:self];
    return date != nil;
}




- (NSMutableAttributedString *)cm_changeTextRange:(NSRange)range Color:(UIColor *)color Font:(UIFont *)font {
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:self];
    [str addAttribute:NSForegroundColorAttributeName value:color range:range];
    
    [str addAttribute:NSFontAttributeName value:font range:range];
    return str;
    
}

- (NSString *)sd_validString {
    
    if ([self sd_isValid]) {
        return self;
    }
    
    return @"";
    
}


-(BOOL)sd_isValid {
    
    
    return (self == nil || [self isKindOfClass:[NSNull class]] || [self isEqualToString:@"(null)"] || [self isEqualToString:@"<null>"] || [self isEqualToString:@"null"] ) ? NO :YES;
}


@end
