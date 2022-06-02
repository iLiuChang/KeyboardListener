//
//  UIView+LCKeyboardListener.h
//  KeyboardListener (https://github.com/iLiuChang/KeyboardListener)
//
//  Created by 刘畅 on 2019/4/29.
//  Copyright © 2019 LiuChang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (LCKeyboardListener)

- (void)lc_addKeyboardListener;

- (void)lc_addKeyboardListenerWithSpacing:(CGFloat)keyboardSpacing;

- (void)lc_removeKeyboardListener;

@end

NS_ASSUME_NONNULL_END
