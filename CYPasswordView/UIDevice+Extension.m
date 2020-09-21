//
//  UIDevice+Extension.m
//  CYPasswordViewDemo
//
//  Created by yong.chen on 2020/9/21.
//  Copyright © 2020 zhssit. All rights reserved.
//

#import "UIDevice+Extension.h"

@implementation UIDevice (Extension)
+ (UIEdgeInsets)safeAreaInsets {
    if (@available(iOS 11.0, *)) {
        return UIApplication.sharedApplication.keyWindow.safeAreaInsets;
    }
    return UIEdgeInsetsZero;
}


@end
