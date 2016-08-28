#import <UIKit/UIKit.h>

@class HPSideMenu;

@interface UIViewController (HPSideMenu)

@property (strong, readonly, nonatomic) HPSideMenu *sideMenuViewController;

- (IBAction)presentLeftMenuViewController:(id)sender;
@end
