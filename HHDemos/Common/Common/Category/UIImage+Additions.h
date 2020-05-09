//
//  UIImage+Additions.h
//  ZKFramework
//
//  Created by kyori.hu on 12-10-10.
//  Copyright (c) 2012 Vanke.com All rights reserved.
//

@interface UIImage (ZK)

typedef NS_ENUM(NSUInteger, ImageType) {
    ImageTypeUnknow = 0,
    ImageTypeJPEG,
    ImageTypeJPEG2000,
    ImageTypeTIFF,
    ImageTypeBMP,
    ImageTypeICO,
    ImageTypeICNS,
    ImageTypeGIF,
    ImageTypePNG,
    ImageTypeWebP,
    ImageTypeOther,
};


+ (UIImage *)imageWithZKNamed:(NSString *)path;

+ (UIImage *)imageWithBase64:(NSString *)base64Str;

+ (UIImage *)ct_imageFromImage:(UIImage *)sourceImage inRect:(CGSize)size;

@end
