//
//  UIImage+Tint.h
//  sticker
//
//  Created by iT on 9/18/15.
//  Copyright (c) 2015 LiuZiyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Tint)

- (UIImage *)tintedGradientImageWithColor:(UIColor *)tintColor;
- (UIImage *)tintedImageWithColor:(UIColor *)tintColor;

@end
