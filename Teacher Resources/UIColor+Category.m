//
//  UIColor+UIColorCategory.m
//  ColorCategory
//
//  Created by Parker Rushton on 2/19/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "UIColor+Category.h"

@implementation UIColor (UIColorCategory)

+ (UIColor *)randomColorHue {
    CGFloat hue = ( arc4random() % 256 / 256.0 );               //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
    return color;
}

+ (UIColor *)randomColorSimple {
    float red = (arc4random() % 100) / 100.0;
    float green = (arc4random() % 100) / 100.0;
    float blue = (arc4random() % 100) / 100.0;
    float alpha = (arc4random() % 100) / 100.0;
    
    UIColor *randomColor = [UIColor colorWithRed:red
                                           green:green
                                            blue:blue
                                           alpha:alpha];
    return randomColor;
}

+(UIColor *)trBlueColor {
   UIColor *wasatchBlue = [UIColor colorWithRed:0.000 green:0.200 blue:0.584 alpha:1.000];
    return wasatchBlue;
}

+(UIColor *)slateColor {
    UIColor *slate = [UIColor colorWithRed:0.451 green:0.639 blue:0.757 alpha:1];
    return slate;
}

+(UIColor *)trBlueColor2 {
    UIColor *trBlueColor2 = [UIColor colorWithRed:0.179 green:0.472 blue:0.757 alpha:1.000];
    return trBlueColor2;
}

+ (UIColor *)fern {
    UIColor *fern =[UIColor colorWithRed:0.22 green:0.502 blue:0.141 alpha:1];
    return fern;
}

@end
