#import "TGNavigationBar.h"

@interface TGNavigationBarLayer : CALayer

@end

@implementation TGNavigationBarLayer

@end

#pragma mark -

@interface TGFixView : UIActivityIndicatorView

@end

@implementation TGFixView

- (void)setAlpha:(CGFloat)__unused alpha
{
    [super setAlpha:0.02f];
}

@end

@implementation TGBlackNavigationBar

@end

@implementation TGWhiteNavigationBar

@end

@implementation TGTransparentNavigationBar

@end

@interface TGNavigationBar () <UIGestureRecognizerDelegate>
{
    bool _shouldAddBackgdropBackgroundInitialized;
    bool _shouldAddBackgdropBackground;
}

@property (nonatomic, strong) UIView *backgroundContainerView;
@property (nonatomic, strong) UIView *statusBarBackgroundView;

@property (nonatomic, strong) UIView *stripeView;

@property (nonatomic) bool contractBackgroundContainer;

@end

@implementation TGNavigationBar

+ (Class)layerClass
{
    return [TGNavigationBarLayer class];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self != nil)
    {
        [self commonInit:UIBarStyleDefault];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self commonInit:[self isKindOfClass:[TGBlackNavigationBar class]] ? UIBarStyleBlackTranslucent : UIBarStyleDefault];
    }
    return self;
}

- (void)commonInit:(UIBarStyle)barStyle
{

    CGFloat backgroundOverflow = 20.0f ;

    _backgroundContainerView = [[UIView alloc] initWithFrame:CGRectMake(0, -backgroundOverflow, self.bounds.size.width, backgroundOverflow + self.bounds.size.height)];
    _backgroundContainerView.userInteractionEnabled = false;
    [super insertSubview:_backgroundContainerView atIndex:0];

    

    [self setBackgroundColor:[UIColor clearColor]];
}

- (void)layoutSubviews
{
    if (_backgroundContainerView != nil)
    {
        CGFloat backgroundOverflow =  20.0f ;
        _backgroundContainerView.frame = CGRectMake(0, -backgroundOverflow, self.bounds.size.width, backgroundOverflow + self.bounds.size.height);
        
    }
    
    if (_stripeView != nil)
    {
        float stripeHeight = 0.5f ;
        _stripeView.frame = CGRectMake(0, _backgroundContainerView.bounds.size.height - stripeHeight, _backgroundContainerView.bounds.size.width, stripeHeight);
    }
    
    [super layoutSubviews];
}

- (void)setBarStyle:(UIBarStyle)barStyle
{
    [self setBarStyle:barStyle animated:false];
}

- (void)setBarStyle:(UIBarStyle)__unused barStyle animated:(bool)__unused animated
{
    [super setBarStyle:barStyle];
}


- (UIView *)findBackground:(UIView *)view
{
    if (view == nil)
        return nil;
    
    if ([NSStringFromClass([view class]) isEqualToString:@"_UINavigationBarBackground"])
        return view;
    
    for (UIView *subview in view.subviews)
    {
        UIView *result = [self findBackground:subview];
        if (result != nil)
            return result;
    }
    
    return nil;
}

- (void)setHidden:(BOOL)hidden
{
    [super setHidden:hidden];
    
    if (!hidden)
    {
        if ([self isKindOfClass:[TGTransparentNavigationBar class]])
        {
            UIView *backgroundView = [self findBackground:self];
            [backgroundView removeFromSuperview];
            
            //TGDumpViews(self, @"");
        }
    }
}

- (void)insertSubview:(UIView *)view atIndex:(NSInteger)index
{
    [super insertSubview:view atIndex:MIN((int)self.subviews.count, MAX(index, 2))];
}

- (bool)shouldAddBackdropBackground
{
    if (!_shouldAddBackgdropBackgroundInitialized)
    {
        _shouldAddBackgdropBackground = ![self isKindOfClass:[TGTransparentNavigationBar class]];
        _shouldAddBackgdropBackgroundInitialized = true;
    }
    
    return _shouldAddBackgdropBackground;
}

@end
