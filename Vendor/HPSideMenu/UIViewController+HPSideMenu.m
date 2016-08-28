#import "UIViewController+HPSideMenu.h"
#import "HPSideMenu.h"

@implementation UIViewController (HPSideMenu)

- (HPSideMenu *)sideMenuViewController
{
    UIViewController *iter = self.parentViewController;
    while (iter) {
        if ([iter isKindOfClass:[HPSideMenu class]]) {
            return (HPSideMenu *)iter;
        } else if (iter.parentViewController && iter.parentViewController != iter) {
            iter = iter.parentViewController;
        } else {
            iter = nil;
        }
    }
    return nil;
}

- (IBAction)presentLeftMenuViewController:(id)sender
{
    [self.sideMenuViewController presentLeftMenuViewController];
}

@end
