
//
//  Created by Evan on 14-8-21.
//  Copyright (c) 2014年 XXXX. All rights reserved.
//

#import "NSString+ContentSize.h"

@implementation NSString (ContentSize)
// self 就是调用当前成员方法的NSString对象
- (CGRect)textRectWithSize:(CGSize)size attributes:(NSDictionary *)attributes
{
    CAAnimationGroup *group = nil;
    return [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
}


- (CGFloat)paba_heightWithFont:(UIFont *)font constrainedToWidth:(CGFloat)width {
    
    UIFont *textFont = font ? font : [UIFont systemFontOfSize:[UIFont systemFontSize]];
    CGSize textSize;
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{
                                 NSFontAttributeName : textFont,
                                 NSParagraphStyleAttributeName: paragraph
                                 };
    textSize = [self boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                  options:(NSStringDrawingUsesLineFragmentOrigin |
                                           NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine)
                               attributes:attributes
                                  context:nil].size;
    return ceil(textSize.height);
}

- (CGFloat)paba_widthWithFont:(UIFont *)font constrainedToHeight:(CGFloat)height {
    
    UIFont *textFont = font ? font : [UIFont systemFontOfSize:[UIFont systemFontSize]];
    CGSize textSize;
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{
                                 NSFontAttributeName: textFont,
                                 NSParagraphStyleAttributeName: paragraph
                                 };
    textSize = [self boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, height)
                                  options:(NSStringDrawingUsesLineFragmentOrigin |
                                           NSStringDrawingTruncatesLastVisibleLine)
                               attributes:attributes
                                  context:nil].size;

    return ceil(textSize.width);
}
@end
