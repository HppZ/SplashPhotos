
#import "HPSideMenu.h"

@interface HPSideMenu ()
{
    float _originalMenuViewOffset;
    float _menuViewTotalDistance;
}

@property (strong, readwrite, nonatomic) UIImageView *backgroundImageView;
@property (assign, readwrite, nonatomic) BOOL visible;
@property (assign, readwrite, nonatomic) float originalTransformX;
@property (strong, readwrite, nonatomic) UIButton *contentButton;
@property (strong, readwrite, nonatomic) UIView *menuViewContainer;
@property (strong, readwrite, nonatomic) UIView *contentViewContainer;

@end

@implementation HPSideMenu

#pragma mark
- (id)init
{
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super initWithCoder:decoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)awakeFromNib
{
    if (self.contentViewStoryboardID) {
        self.contentViewController = [self.storyboard instantiateViewControllerWithIdentifier:self.contentViewStoryboardID];
    }
    if (self.leftMenuViewStoryboardID) {
        self.leftMenuViewController = [self.storyboard instantiateViewControllerWithIdentifier:self.leftMenuViewStoryboardID];
    }
}

- (void)commonInit
{
    _menuViewContainer = [[UIView alloc] init];
    _contentViewContainer = [[UIView alloc] init];
    
    _animationDuration = 0.25f;
    _panGestureEnabled = YES;
    _panFromEdge = YES;
    _panMinimumOpenThreshold = 60.0;
    _contentViewInLandscapeOffsetCenterX = 70.f;
    _menuViewInLandscapeOffsetCenterX = 10.f;
    _originalMenuViewOffset = -50;
    _menuViewTotalDistance = _menuViewInLandscapeOffsetCenterX - _originalMenuViewOffset;
}

#pragma mark
- (id)initWithContentViewController:(UIViewController *)contentViewController leftMenuViewController:(UIViewController *)leftMenuViewController
{
    self = [self init];
    if (self) {
        _contentViewController = contentViewController;
        _leftMenuViewController = leftMenuViewController;
    }
    return self;
}

- (void)presentLeftMenuViewController
{
    [self showLeftMenuViewController];
}

- (void)hideMenuViewController
{
    [self hideMenuViewControllerAnimated:YES];
}

- (void)setContentViewController:(UIViewController *)contentViewController animated:(BOOL)animated
{
    if (_contentViewController == contentViewController)
    {
        return;
    }
    
    if (!animated) {
        [self setContentViewController:contentViewController];
    } else {
        [self addChildViewController:contentViewController];
        contentViewController.view.alpha = 0;
        contentViewController.view.frame = self.contentViewContainer.bounds;
        [self.contentViewContainer addSubview:contentViewController.view];
        [UIView animateWithDuration:self.animationDuration animations:^{
            contentViewController.view.alpha = 1;
        } completion:^(BOOL finished) {
            [self hideViewController:self.contentViewController];
            [contentViewController didMoveToParentViewController:self];
            _contentViewController = contentViewController;
        }];
    }
}

#pragma mark

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.backgroundImageView = ({
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
        imageView.image = self.backgroundImage;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        imageView;
    });
    self.contentButton = ({
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectNull];
        [button addTarget:self action:@selector(hideMenuViewController) forControlEvents:UIControlEventTouchUpInside];
        button;
    });
    
    [self.view addSubview:self.backgroundImageView];
    [self.view addSubview:self.menuViewContainer];
    [self.view addSubview:self.contentViewContainer];
    
    self.menuViewContainer.frame = self.view.bounds;
    self.menuViewContainer.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    if (self.leftMenuViewController) {
        [self addChildViewController:self.leftMenuViewController];
        self.leftMenuViewController.view.frame = self.view.bounds;
        self.leftMenuViewController.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self.menuViewContainer addSubview:self.leftMenuViewController.view];
        [self.leftMenuViewController didMoveToParentViewController:self];
    }
    self.contentViewContainer.frame = self.view.bounds;
    self.contentViewContainer.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [self addChildViewController:self.contentViewController];
    self.contentViewController.view.frame = self.view.bounds;
    [self.contentViewContainer addSubview:self.contentViewController.view];
    [self.contentViewController didMoveToParentViewController:self];
    
    if (self.panGestureEnabled) {
        self.view.multipleTouchEnabled = NO;
        UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognized:)];
        panGestureRecognizer.delegate = self;
        [self.view addGestureRecognizer:panGestureRecognizer];
    }
    
    [self setState:false];
}

#pragma mark
- (void)resetState
{
    CGRect frame = self.contentViewContainer.frame;
    self.contentViewContainer.transform = CGAffineTransformIdentity;
    self.contentViewContainer.frame = frame;
    
    CGRect frame2 = self.menuViewContainer.frame;
    self.menuViewContainer.transform = CGAffineTransformIdentity;
    self.menuViewContainer.frame = frame2;
    
}

-(void)setState: (BOOL) show
{
    if(show)
    {
        self.contentViewContainer.center = [self contentViewMaxCenter];
        self.menuViewContainer.center = [self menuViewMaxCenter];
    }
    else
    {
        self.contentViewContainer.transform = CGAffineTransformIdentity;
        self.contentViewContainer.frame = self.view.bounds;
        self.contentViewContainer.center = self.view.center;
        
        self.menuViewContainer.frame = self.view.bounds;
        self.menuViewContainer.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, _originalMenuViewOffset, 0);
        self.menuViewContainer.center = self.view.center;
    }
}

- (void)showLeftMenuViewController
{
    if (!self.leftMenuViewController)
    {
        return;
    }
    
    [self.leftMenuViewController beginAppearanceTransition:YES animated:YES];
    self.leftMenuViewController.view.hidden = NO;
    
    [self.view.window endEditing:YES];
    [self addContentButton];
    [self resetState];
    
    [UIView animateWithDuration:self.animationDuration animations:
     ^{
         [self  setState:true];
     }
                     completion:^(BOOL finished) {
                         
                         [self.leftMenuViewController endAppearanceTransition];
                         self.visible = YES;
                     }];
}

- (void)hideViewController:(UIViewController *)viewController
{
    [viewController willMoveToParentViewController:nil];
    [viewController.view removeFromSuperview];
    [viewController removeFromParentViewController];
}

- (void)hideMenuViewControllerAnimated:(BOOL)animated
{
    UIViewController *visibleMenuViewController =  self.leftMenuViewController;
    [visibleMenuViewController beginAppearanceTransition:NO animated:animated];
    
    self.visible = NO;
    [self.contentButton removeFromSuperview];
    
    __typeof (self) __weak weakSelf = self;
    void (^animationBlock)(void) =
    ^{
        __typeof (weakSelf) __strong strongSelf = weakSelf;
        
        if (!strongSelf)
        {
            return;
        }
        [strongSelf  setState:false];
    };
    void (^completionBlock)(void) =
    ^{
        __typeof (weakSelf) __strong strongSelf = weakSelf;
        if (!strongSelf) {
            return;
        }
        
        [visibleMenuViewController endAppearanceTransition];
    };
    
    if (animated) {
        [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
        [UIView animateWithDuration:self.animationDuration animations:
         ^{
             animationBlock();
         }
                         completion:^(BOOL finished)
         {
             [[UIApplication sharedApplication] endIgnoringInteractionEvents];
             completionBlock();
         }];
    } else
    {
        animationBlock();
        completionBlock();
    }
    
}

- (void)addContentButton
{
    if (self.contentButton.superview)
        return;
    
    self.contentButton.autoresizingMask = UIViewAutoresizingNone;
    self.contentButton.frame = self.contentViewContainer.bounds;
    self.contentButton.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.contentViewContainer addSubview:self.contentButton];
}

#pragma mark
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ( [self.contentViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navigationController = (UINavigationController *)self.contentViewController;
        if (navigationController.viewControllers.count > 1 && navigationController.interactivePopGestureRecognizer.enabled) {
            return NO;
        }
    }
    
    if (self.panFromEdge && [gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]] && !self.visible)
    {
        CGPoint point = [touch locationInView:gestureRecognizer.view];
        if (point.x < 20.0)
        {
            return YES;
        }
        else
        {
            return NO;
        }
    }
    
    return YES;
}

#pragma mark
- (void)panGestureRecognized:(UIPanGestureRecognizer *)recognizer
{
    if (!self.panGestureEnabled)
    {
        return;
    }
    
    CGPoint point = [recognizer translationInView:self.view];
    if (recognizer.state == UIGestureRecognizerStateBegan)
    {
        self.originalTransformX = self.menuViewContainer.transform.tx;
        
        [self addContentButton];
        [self.view.window endEditing:YES];
    }
    
    if (recognizer.state == UIGestureRecognizerStateChanged)
    {
        float maxCenterX = [self  contentViewMaxCenter].x;
        
        if (point.x < 0)
        {
            point.x = MAX(point.x, -[UIScreen mainScreen].bounds.size.height);
        }
        else
        {
            float pos =   point.x + self.contentViewContainer.center.x ;
            if(pos >= maxCenterX )
            {
                float t = maxCenterX - self.contentViewContainer.center.x;
                self.contentViewContainer.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, t, 0);
                
                float t1 = self.menuViewMaxCenter.x - self.menuViewContainer.center.x;
                self.menuViewContainer.transform = CGAffineTransformTranslate(CGAffineTransformIdentity,  t1  , 0);
                return;
            }
            point.x = MIN(point.x, [UIScreen mainScreen].bounds.size.height);
        }
        [recognizer setTranslation:point inView:self.view];
        
        self.contentViewContainer.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, point.x, 0);
        
        float maxMenuCenterX = maxCenterX - self.contentViewContainer.bounds.size.width/2;
        float menuTransformX = _menuViewTotalDistance * point.x / maxMenuCenterX  + self.originalTransformX;
        self.menuViewContainer.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, MIN(_menuViewInLandscapeOffsetCenterX,  menuTransformX) , 0);
        
        if(self.contentViewContainer.frame.origin.x < 0)
        {
            self.contentViewContainer.transform = CGAffineTransformIdentity;
            self.contentViewContainer.frame = self.view.bounds;
            self.visible = NO;
        }
    }
    
    if (recognizer.state == UIGestureRecognizerStateEnded)
    {
        
        if (self.panMinimumOpenThreshold > 0
            &&((self.contentViewContainer.frame.origin.x < 0 && self.contentViewContainer.frame.origin.x > -((NSInteger)self.panMinimumOpenThreshold))
               ||(self.contentViewContainer.frame.origin.x > 0 && self.contentViewContainer.frame.origin.x < self.panMinimumOpenThreshold)))
        {
            [self hideMenuViewController];
        }
        else if (self.contentViewContainer.frame.origin.x == 0)
        {
            [self hideMenuViewControllerAnimated:NO];
        }
        else
        {
            if ([recognizer velocityInView:self.view].x > 0)
            {
                if (self.contentViewContainer.frame.origin.x < 0)
                {
                    [self hideMenuViewController];
                }
                else
                {
                    if (self.leftMenuViewController)
                    {
                        [self showLeftMenuViewController];
                    }
                }
            }
            else
            {
                [self hideMenuViewController];
            }
        }
    }
}

-(CGPoint)contentViewMaxCenter
{
    return CGPointMake(self.contentViewInLandscapeOffsetCenterX + CGRectGetWidth(self.view.frame)
                       , self.contentViewContainer.center.y);
}

-(CGPoint)menuViewMaxCenter
{
    return CGPointMake(_menuViewInLandscapeOffsetCenterX + self.menuViewContainer.bounds.size.width / 2,
                       self.menuViewContainer.center.y);
}

#pragma mark
- (void)setBackgroundImage:(UIImage *)backgroundImage
{
    _backgroundImage = backgroundImage;
    if (self.backgroundImageView)
        self.backgroundImageView.image = backgroundImage;
}

- (void)setContentViewController:(UIViewController *)contentViewController
{
    if (!_contentViewController) {
        _contentViewController = contentViewController;
        return;
    }
    [self hideViewController:_contentViewController];
    _contentViewController = contentViewController;
    
    [self addChildViewController:self.contentViewController];
    self.contentViewController.view.frame = self.view.bounds;
    [self.contentViewContainer addSubview:self.contentViewController.view];
    [self.contentViewController didMoveToParentViewController:self];
}

- (void)setLeftMenuViewController:(UIViewController *)leftMenuViewController
{
    if (!_leftMenuViewController) {
        _leftMenuViewController = leftMenuViewController;
        return;
    }
    [self hideViewController:_leftMenuViewController];
    _leftMenuViewController = leftMenuViewController;
    
    [self addChildViewController:self.leftMenuViewController];
    self.leftMenuViewController.view.frame = self.view.bounds;
    self.leftMenuViewController.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.menuViewContainer addSubview:self.leftMenuViewController.view];
    [self.leftMenuViewController didMoveToParentViewController:self];
    
    [self.view bringSubviewToFront:self.contentViewContainer];
}

#pragma mark
- (BOOL)shouldAutorotate
{
    return NO;
}

@end
