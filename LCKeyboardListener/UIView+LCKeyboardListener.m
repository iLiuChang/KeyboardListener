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

@property(nonatomic, weak) UIView *currentTextInput;

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
    UIView *observerView = self.currentTextInput;
    if (!observerView || !self.userInfo) {
        return;
    }

    CGRect convertRect = [observerView convertRect:observerView.bounds toView:self.transformView.window];

    CGFloat telMaxY = CGRectGetMaxY(convertRect);
    CGFloat keyboardH = [self.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    CGFloat keyboardY = [UIScreen mainScreen].bounds.size.height - keyboardH;
    double duration = [self.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    if (duration <= 0.0){
        duration = 0.25;
    }
    if (telMaxY > keyboardY) {
        [UIView animateWithDuration:duration animations:^{
            self.transformView.transform = CGAffineTransformMakeTranslation(0,  keyboardY - telMaxY - self.keyboardSpacing);
        }];
    }
    self.currentTextInput = nil;
    self.userInfo = nil;
}

-(void)keyboardWillShow:(NSNotification *)note{
    if (!self.transformView.window) {
        return;
    }
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
    [UIView animateWithDuration:duration animations:^{
        self.transformView.transform = CGAffineTransformIdentity;
    }];
}

-(void)textInputDidBeginEditing:(NSNotification *)note {
    if (!self.transformView.window) {
        return;
    }
    self.currentTextInput = note.object;
    [self makeKeyboardWillShow];
}

-(void)textInputDidEndEditing:(NSNotification *)note {
    self.currentTextInput = nil;
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


