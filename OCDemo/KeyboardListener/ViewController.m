//
//  ViewController.m
//  KeyboardListener
//
//  Created by 刘畅 on 2022/6/2.
//

#import "ViewController.h"
#import "UIView+LCKeyboardListener.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITextField *t = [[UITextField alloc] init];
    t.frame = CGRectMake(100, self.view.frame.size.height - 300, 100, 50);
    t.backgroundColor = [UIColor redColor];
    [self.view addSubview:t];

    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 200, self.view.frame.size.width, 50)];
    contentView.backgroundColor = UIColor.yellowColor;
    [self.view addSubview:contentView];
    UITextView *t2 = [[UITextView alloc] init];
    t2.frame = CGRectMake(100, 0, 100, 50);
    t2.backgroundColor = [UIColor grayColor];
    [contentView addSubview:t2];
    [contentView lc_addKeyboardListener];
    [t lc_addKeyboardListener];

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end
