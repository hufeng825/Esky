//
//  NSString+Additions.h
//  Pluto
//
//  Created by jason on 12-10-21.
//
//

#import <Foundation/Foundation.h>
@interface NSString (HF)

+ (NSString*) base64StringFromData: (NSData*)data;

+ (id)stringWithFormat:(NSString *)format array:(NSArray*) arguments;

+ (id)stringWithDate:(NSDate*)date format:(NSString *)format;

+ (NSString *)getIPAddress;

+ (NSString*)fenStringWithDecimalNumber:(NSDecimalNumber*)number;

- (NSString*)URLencodeWithEncoding:(NSStringEncoding)stringEncoding;

- (NSString*)URLencodeWithEncodingUTF8;

- (NSString *)stringFromMD5;

- (NSString*)dateStringWithFormat:(NSString*)format;

- (NSString*)ymdString;

- (NSString*)ymdStringWithSeperator:(NSString*)seperator;

- (NSString*)ymString;

- (NSString*)mdString;

- (NSString*)mdStringWithSeperator:(NSString*)seperator;

- (NSString*)hmString;

- (NSString*)nextMonth;

- (NSString*)amountStringWithSymbol:(NSString*)symbol;

-(NSUInteger)lengthToInt;//得到字符串长度 中英文混合情况下

-(NSUInteger)gotChineseCount;//得到字符串中含有的中文和全角支付个数

-(BOOL)validateContainsString:(NSString *)findStr;

-(BOOL)validatePersonCard;

-(BOOL)validateNumberStr;

-(BOOL)validateNameStr;//只准有字母和英文

-(BOOL)validatePassWord;

-(BOOL)validateEmailAddress;

-(BOOL)validateCellPhone;

@end
