
//
//  Created by Evan on 14-8-21.
//  Copyright (c) 2014年 Vanke. All rights reserved.
//

#import "NSString+ContentSize.h"

@implementation NSString (ContentSize)

// self 就是调用当前成员方法的NSString对象
- (CGRect)textRectWithSize:(CGSize)size attributes:(NSDictionary *)attributes
{
    return [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
}

@end
