//
//  ToastUtil.m
//  EnvDetection
//
//  Created by 小七 on 2023/3/2.
//

#import "ToastUtil.h"
 
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_7_0
#define MultilineTextSize(text, font, maxSize) [text length] > 0 ? [text \
boundingRectWithSize:maxSize options:(NSStringDrawingUsesLineFragmentOrigin) \
attributes:@{NSFontAttributeName:font} context:nil].size : CGSizeZero;
#else
#define MultilineTextSize(text, font, maxSize) [text length] > 0 ? [text \
sizeWithFont:font constrainedToSize:maxSize] : CGSizeZero;
#endif
 
// 获取屏幕的宽度和高度
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
 
// 文字视图间距
const CGFloat toast_padding = 12;
// 视图圆角半径
const CGFloat toast_cornerRadius = 4;
// 字体大小
const CGFloat toast_fontSize = 12;
 
// Toast显示透明度动画时间
const NSTimeInterval ANIM_DURATION = 0.2;
// 默认Toast显示时间
const NSTimeInterval Toast_DEFAULT_DURATION = 2.5;
 
@interface ToastUtil()
 
@property (strong, nonatomic) UIView *toastView;
@property (nonatomic, strong) NSTimer *toastTimer;
@property (nonatomic, strong) NSTimer *dismissTimer;
@property (nonatomic, copy) dispatch_block_t finishHandler;
 
@end
 
@implementation ToastUtil
 
@synthesize toastView;
@synthesize toastTimer;
@synthesize dismissTimer;
@synthesize finishHandler;
 
+ (instancetype)toast{
    static ToastUtil *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[ToastUtil alloc] init];
    });
    return instance;
}
 
- (int)showToast:(NSString *)msg{
    [self toastShow:msg duration:Toast_DEFAULT_DURATION gravity:BOTTOM finishHandler:^{
        NSLog(@"Toast消失：msg：%@",msg);
    }];
    
    return 1;
}
 
- (void)showToast:(NSString *)msg duration:(NSTimeInterval)duration{
    [self toastShow:msg duration:duration gravity:BOTTOM finishHandler:^{
        NSLog(@"Toast消失：msg：%@",msg);
    }];
}
 
- (void)showToast:(NSString *)msg duration:(NSTimeInterval)duration gravity:(Gravity)gravity{
    [self toastShow:msg duration:duration gravity:gravity finishHandler:^{
        NSLog(@"Toast消失：msg：%@",msg);
    }];
}
 
- (void)showToast:(NSString *)msg duration:(NSTimeInterval)duration gravity:(Gravity)gravity finishHandler:(dispatch_block_t)finishHandler{
    [self toastShow:msg duration:duration gravity:gravity finishHandler:finishHandler];
}
 
-(void)toastShow:(NSString *)msg duration:(NSTimeInterval)duration gravity:(Gravity)gravity finishHandler:(dispatch_block_t)finishHandler{
    self.finishHandler = finishHandler;
    if (toastView || toastView.superview) {
        [self removeToast];
    }
    
    [self initToastView:msg gravity:gravity];
    if (toastView) {
        toastView.alpha = 0;
        [[[UIApplication sharedApplication].windows firstObject] addSubview:toastView];
        [[[UIApplication sharedApplication].windows firstObject] bringSubviewToFront:toastView];
    }
    
    [UIView animateWithDuration:ANIM_DURATION animations:^{
        if (self->toastView) {
            self->toastView.alpha = 1;
        }
    }];
    
    toastTimer = [NSTimer scheduledTimerWithTimeInterval:duration target:self selector:@selector(finishDismiss) userInfo:nil repeats:NO];
}
 
- (void)initToastView:(NSString *)msg gravity:(Gravity)gravity{
    CGSize toastSize = [self getToastSizeWithMessage:msg];
    CGFloat toastWidth = toastSize.width;
    CGFloat toastHeight = toastSize.height;
    CGFloat x = (SCREEN_WIDTH - toastWidth) / 2;
    CGFloat y = (SCREEN_HEIGHT - toastHeight) * 5 / 6;
    switch (gravity) {
        case TOP:
            y = (SCREEN_HEIGHT - toastHeight) * 1 / 6;
            break;
        case CENTRE:
            y = (SCREEN_HEIGHT - toastHeight) / 2;
            break;
        case BOTTOM:
            y = (SCREEN_HEIGHT - toastHeight) * 5 / 6;
            break;
    }
    
    toastView = [[UIView alloc] init];
    toastView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
    toastView.layer.cornerRadius = toast_cornerRadius;
    toastView.frame = CGRectMake(x, y, toastWidth, toastHeight);
    UILabel *messageLabel = [[UILabel alloc] initWithFrame:toastView.bounds];
    messageLabel.text = msg;
    messageLabel.textColor = [UIColor whiteColor];
    messageLabel.font = [UIFont systemFontOfSize:toast_fontSize];
    messageLabel.numberOfLines = 0;
    messageLabel.textAlignment = NSTextAlignmentCenter;
    // 文字自适应宽高
    CGSize expectSize = [messageLabel sizeThatFits:CGSizeMake(toastWidth, SCREEN_HEIGHT)];
    messageLabel.frame = CGRectMake((toastWidth - expectSize.width) / 2, (toastHeight - expectSize.height) / 2, expectSize.width, expectSize.height);
    [toastView addSubview:messageLabel];
    [toastView addSubview:messageLabel];
}
 
- (void)finishDismiss {
    [UIView animateWithDuration:ANIM_DURATION animations:^{
        if (self->toastView) {
            self->toastView.alpha = 0;
        }
    }];
    dismissTimer = [NSTimer scheduledTimerWithTimeInterval:ANIM_DURATION target:self selector:@selector(dismiss) userInfo:nil repeats:NO];
}
 
- (void) dismiss{
    [self removeToast];
    if (self->finishHandler) { self->finishHandler(); }
}
 
- (void)removeToast {
    if (toastView) {
        [toastView removeFromSuperview];
        toastView = nil;
    }
}
 
- (void)dealloc {
    if (toastTimer) {
        [toastTimer invalidate];
        toastTimer = nil;
    }
    if (dismissTimer) {
        [dismissTimer invalidate];
        dismissTimer = nil;
    }
}
 
- (CGSize)getToastSizeWithMessage:(NSString *)msg{
    UIFont *font = [UIFont systemFontOfSize:toast_fontSize];
    CGSize textSize = MultilineTextSize(msg, font, CGSizeMake(SCREEN_WIDTH - 60, SCREEN_HEIGHT ));
    CGFloat labelWidth = textSize.width + 1;
    CGFloat labelHeight = textSize.height + 1;
    CGFloat heightPadding = 2 * toast_padding;
    CGFloat toastHeight = labelHeight + heightPadding;
    CGFloat toastWidth = labelWidth + heightPadding;
    return CGSizeMake(toastWidth, toastHeight);
}
 
@end

