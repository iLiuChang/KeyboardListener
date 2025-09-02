//
//  UIView+LCKeyboardListener.m
//  KeyboardListener (https://github.com/iLiuChang/KeyboardListener)
//
//  Created by 刘畅 on 2019/4/29.
//  Copyright © 2019 LiuChang. All rights reserved.
//

#import "UIView+LCKeyboardListener.h"
#import <objc/runtime.h>

@interface LCKeyboardListener : NSObject

@property (nonatomic, assign) CGFloat keyboardSpacing;

@property(nonatomic, weak) UIView *transformView;

@property(nonatomic, assign) BOOL isCurrentTextInput;

@property (nonatomic, strong) NSDictionary *userInfo;

@end

@implementation LCKeyboardListener

- (instancetype)initWithTransformView:(UIView *)transformView
{
    self = [super init];
    if (self) {
        self.transformView = transformView;
        [self addKeyboardObserver];
    }
    return self;
}

- (void)addKeyboardObserver {
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [center addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [center addObserver:self selector:@selector(textInputDidBeginEditing:) name:UITextFieldTextDidBeginEditingNotification object:nil];
    [center addObserver:self selector:@selector(textInputDidEndEditing:) name:UITextFieldTextDidEndEditingNotification object:nil];
    [center addObserver:self selector:@selector(textInputDidBeginEditing:) name:UITextViewTextDidBeginEditingNotification object:nil];
    [center addObserver:self selector:@selector(textInputDidEndEditing:) name:UITextViewTextDidEndEditingNotification object:nil];
}

- (void)makeKeyboardWillShow {
    if (!self.transformView.window || !self.transformView.window.isKeyWindow) {
        return;
    }

    if (!self.isCurrentTextInput || !self.userInfo) {
        return;
    }
    
    CGRect convertRect = [self.transformView convertRect:self.transformView.bounds toView:self.transformView.window];

    CGFloat telMaxY = CGRectGetMaxY(convertRect);
    CGFloat keyboardH = [self.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    CGFloat keyboardY = self.transformView.window.bounds.size.height - keyboardH;
    double duration = [self.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    if (duration <= 0.0){
        duration = 0.25;
    }
    
    NSInteger curve = [self.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    UIViewAnimationOptions options = (curve << 16) | UIViewAnimationOptionBeginFromCurrentState;

    if (telMaxY > keyboardY) {
        [UIView animateWithDuration:duration
                                  delay:0
                                options:options
                             animations:^{
            self.transformView.transform = CGAffineTransformMakeTranslation(0,  keyboardY - telMaxY - self.keyboardSpacing);
        } completion:nil];
    }
}

-(void)keyboardWillShow:(NSNotification *)note{
    self.userInfo = note.userInfo;
    [self makeKeyboardWillShow];
}

-(void)keyboardWillHide:(NSNotification *)note{
    if (CGAffineTransformEqualToTransform(self.transformView.transform, CGAffineTransformIdentity)) {
        return;
    }
    double duration  = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    if (duration <= 0.0) {
        duration = 0.25;
    };
    
    NSInteger curve = [note.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    UIViewAnimationOptions options = (curve << 16) | UIViewAnimationOptionBeginFromCurrentState;

    [UIView animateWithDuration:duration
                              delay:0
                            options:options
                         animations:^{
        self.transformView.transform = CGAffineTransformIdentity;
    } completion:nil];
}

-(void)textInputDidBeginEditing:(NSNotification *)note {
    if ([note.object isKindOfClass:UIView.class] && ((UIView *)note.object).window.isKeyWindow) {
        UIView *view = (UIView *)note.object;
        if (view == self.transformView) {
            self.isCurrentTextInput = YES;
        } else {
            self.isCurrentTextInput = [view isDescendantOfView:self.transformView];
        }
        [self makeKeyboardWillShow];
    }
}

-(void)textInputDidEndEditing:(NSNotification *)note {
    if ([note.object isKindOfClass:UIView.class] && ((UIView *)note.object).window.isKeyWindow) {
        UIView *view = (UIView *)note.object;
        if (view == self.transformView || [view isDescendantOfView:self.transformView]) {
            self.isCurrentTextInput = NO;
        }
    }
}

- (void)dealloc {
    [self removeObserver];
}

-(void)removeObserver {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end

@implementation UIView (LCKeyboardListener)
static const char LCKeyboardObserverKey = '\0';

- (void)lc_addKeyboardListener {
    [self lc_addKeyboardListenerWithSpacing:0];
}

- (void)lc_addKeyboardListenerWithSpacing:(CGFloat)keyboardSpacing {
    LCKeyboardListener *observer = [[LCKeyboardListener alloc] initWithTransformView:self];
    observer.keyboardSpacing = keyboardSpacing;
    objc_setAssociatedObject(self, &LCKeyboardObserverKey,
                             observer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)lc_removeKeyboardListener {
    objc_setAssociatedObject(self, &LCKeyboardObserverKey,
                             nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end


