//
//  MTARichLabel.m
//  Pods
//
//  Created by 余卓 on 2017/9/13.
//
//

#import "MTARichLabel.h"
#import "MTARichLabelTextMode.h"
#import "MTARichStyleMode.h"
#import "UIColor+mtauitls.h"

@interface MTARichLabel()

@end

@implementation MTARichLabel

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        
    }
    return self;
}

- (void)setText:(NSString *)text {
    if(text.length == 0) {
        return;
    }
    MTARichLabelTextMode * secondAd = [self flattenHTML:text trimWhiteSpace:YES];
    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle1 setLineSpacing:4];
    NSMutableAttributedString *attributedStr02 = [[NSMutableAttributedString alloc] initWithString: secondAd.desc];
    
    [attributedStr02 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [secondAd.desc length])];
    //添加属性
    //分段控制，最开始4个字符颜色设置成颜色
    for(int i = 0;i<secondAd.styleArray.count;i++){
        NSInteger targetLength02 = secondAd.styleArray[i].target.length;
        if(secondAd.styleArray[i].color !=nil && targetLength02 >0){
            [attributedStr02 addAttribute: NSForegroundColorAttributeName value: [UIColor nvColorWithHexString:secondAd.styleArray[i].color] range: [secondAd.desc rangeOfString:secondAd.styleArray[i].target]];
        }
        if(secondAd.styleArray[i].bold && targetLength02 >0){
            [attributedStr02 addAttribute:NSStrokeWidthAttributeName value:@(-3) range:[secondAd.desc rangeOfString:secondAd.styleArray[i].target]];
        }
        
    }
    
    self.attributedText = attributedStr02;
    self.lineBreakMode = NSLineBreakByTruncatingTail;
}

//"近七天收到<font color='#ff0000'><b>七圣诞节费拉达斯</b></font>条好评,,,,近七天收到<font color='#ff0000'><b>七圣诞节费拉达斯</b></font>条好评"

- (MTARichLabelTextMode *)flattenHTML:(NSString *)html trimWhiteSpace:(BOOL)trim
{
    
    NSScanner *theScanner = [NSScanner scannerWithString:html];
    NSString *text = nil;
    NSMutableArray<MTARichStyleMode *> *richArray = [NSMutableArray new];
    MTARichLabelTextMode *richLabelMode = [MTARichLabelTextMode new];
    NSArray<NSString*> *tarArray = [self targetStr:html];
    while ([theScanner isAtEnd] == NO) {
        MTARichStyleMode *stylemode = [MTARichStyleMode new];
        // find start of tag
        [theScanner scanUpToString:@"<" intoString:NULL] ;
        // find end of tag
        [theScanner scanUpToString:@"/" intoString:&text] ;
        
        if([text containsString:@"color"]){
            stylemode.color = [self tarStrHTML:text reg:@"['](.*)[']" repStr:@"'"];
        }
        if([text containsString:@"<b"]){
            stylemode.bold = YES;
        }
        text = nil;
        if(stylemode.color.length>0||stylemode.bold){
            [richArray addObject:stylemode];
        }
    }
    
    for (NSUInteger i =0; i< tarArray.count; i++) {
        richArray[i].target = tarArray[i];
    }
    richLabelMode.desc = [self getDesc:html];
    richLabelMode.styleArray = richArray;
    return  richLabelMode;
}

//获取富文本的目标文字
- (NSArray<NSString*> *)targetStr:(NSString *)html
{
    NSScanner *theScanner = [NSScanner scannerWithString:html];
    NSString *text = nil;
    NSMutableArray<NSString *> *tarArray = [NSMutableArray new];
    while ([theScanner isAtEnd] == NO) {
        // find start of tag
        [theScanner scanUpToString:@">" intoString:NULL] ;
        // find end of tag
        
        [theScanner scanUpToString:@"/" intoString:&text] ;
        // replace the found tag with a space
        //(you can filter multi-spaces out later if you wish)
        if([text containsString:@">"] && [text containsString:@"<"]){
            text = [self getSynax:text];
        
            if(text!=nil){
                text = [text stringByReplacingOccurrencesOfString:@">"
                                                       withString:@""];
                if(text.length>0)
                    [tarArray addObject:text];
            }
        }
        text = nil;
        
    }
    
    return  tarArray;
}

//去掉多余标签
- (NSString *)getSynax:(NSString *) html
{
    NSScanner *theScanner = [NSScanner scannerWithString:html];
    NSString *text = nil;
    while ([theScanner isAtEnd] == NO) {
        // find start of tag
        [theScanner scanUpToString:@">" intoString:NULL] ;
        // find end of tag
        [theScanner scanUpToString:@"<" intoString:&text] ;
        if(text!=nil){
            text = [text stringByReplacingOccurrencesOfString:@">"
                                                   withString:@""];
        }
    }
    
    return text;
}

//过滤掉富文本标签返回一个纯文本
- (NSString *)getDesc:(NSString *) html
{
    NSScanner *theScanner = [NSScanner scannerWithString:html];
    NSString *text = nil;
    while ([theScanner isAtEnd] == NO) {
        // find start of tag
        [theScanner scanUpToString:@"<" intoString:NULL] ;
        // find end of tag
        [theScanner scanUpToString:@">" intoString:&text] ;
        html = [html stringByReplacingOccurrencesOfString:
                [ NSString stringWithFormat:@"%@>", text]
                                               withString:@""];
    }
    
    return [html stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}


- (NSString *)tarStrHTML:(NSString *)html reg:(NSString *)regStr repStr:(NSString*) rpStr
{
    NSString *result = nil;
    NSRange range = [html rangeOfString:regStr options:NSRegularExpressionSearch];
    if (range.location != NSNotFound) {
        NSLog(@"%@", [html substringWithRange:range]);
        result = [html substringWithRange:range];
        result = [result stringByReplacingOccurrencesOfString:rpStr withString:@""];
    }
    return result;
}


@end
