

#import "UINavigationBar+Awesome.h"
#import <objc/runtime.h>

@implementation UINavigationBar (Awesome)

static char overlayKey;

/**
 *  获取关联对象
 *
 *  @return UIView
 */
- (UIView *)overlay
{
    //获取关联对象
    return objc_getAssociatedObject(self, &overlayKey);
}

/**
 *  设置关联对象
 *
 *  @param overlay 关联对象是（UIView）
 */
- (void)setOverlay:(UIView *)overlay
{
    
    //设置关联对象
    objc_setAssociatedObject(self, &overlayKey, overlay, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

/**
 *  设置导航栏的背景色
 *
 *  @param backgroundColor 颜色
 */
- (void)lt_setBackgroundColor:(UIColor *)backgroundColor
{
    if (!self.overlay) {
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        
        if ([[[UIDevice currentDevice]systemVersion]floatValue]>=10.0) {
            
            self.overlay = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) + 20)];
            self.overlay.userInteractionEnabled = NO;
            self.overlay.autoresizingMask = UIViewAutoresizingFlexibleWidth;    // Should not set `UIViewAutoresizingFlexibleHeight`
            [[self.subviews firstObject] insertSubview:self.overlay atIndex:0];
            
        }else{
            self.overlay = [[UIView alloc] initWithFrame:CGRectMake(0, -20, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds)+20)];
            self.overlay.userInteractionEnabled = NO;
            self.overlay.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
            [self insertSubview:self.overlay atIndex:0];
        }
    }
    self.overlay.backgroundColor = backgroundColor;
}

/**
 *  设置图片的颜色
 *
 *  @param backgroundColor 颜色
 */
-(void)setredcolor:(UIColor *)backgroundColor{
    for (id imagetype in [self subviews]) {
        if ([imagetype isKindOfClass:[UIImageView class]]) {
            if (((UIImageView*)imagetype).frame.size.width==320) {
                if (((UIImageView*)imagetype).tag==99) {
                    [imagetype removeFromSuperview];
                }
                
            }
            
        }
    }
    UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, -20, self.frame.size.width, 64)];
    imageView.image=nil;
    imageView.backgroundColor = backgroundColor;
    imageView.tag = 99;
    [self insertSubview:imageView atIndex:0];
    
    
    
}

/**
 *  设置导航栏旋转的角度
 *
 *  @param translationY 角度
 */
- (void)lt_setTranslationY:(CGFloat)translationY
{
    self.transform = CGAffineTransformMakeTranslation(0, translationY);
}

/**
 *  设置元素的透明度
 *
 *  @param alpha 浮点类型
 */
- (void)lt_setElementsAlpha:(CGFloat)alpha
{
    //KVC
    [[self valueForKey:@"_leftViews"] enumerateObjectsUsingBlock:^(UIView *view, NSUInteger i, BOOL *stop) {
        view.alpha = alpha;
    }];
    
    [[self valueForKey:@"_rightViews"] enumerateObjectsUsingBlock:^(UIView *view, NSUInteger i, BOOL *stop) {
        view.alpha = alpha;
    }];
    
    UIView *titleView = [self valueForKey:@"_titleView"];
    titleView.alpha = alpha;
}

/**
 *  清空遮盖层
 */
- (void)lt_reset
{
    [self setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.overlay removeFromSuperview];
    self.overlay = nil;
}

@end
