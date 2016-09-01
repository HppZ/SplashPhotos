//
//  UserProfileViewController.m
//  SplashPhotos
//
//  Created by HaoPeng on 16/8/30.
//  Copyright © 2016年 HaoPeng. All rights reserved.
//

#import "UserProfileViewController.h"
#import "PhotoService.h"
#import "ProfileImage.h"
#import "UserProfile.h"
#import "SystemServiceHelper.h"
#import "ToastService.h"

@interface UserProfileViewController ()
{
    PhotoService * _photoservice;
}
@property (weak, nonatomic) IBOutlet UIImageView *avatarElement;
@property (weak, nonatomic) IBOutlet UILabel *nameElement;
@property (weak, nonatomic) IBOutlet UILabel *locationElement;
@property (weak, nonatomic) IBOutlet UILabel *portfolioUrlElement;
@property (weak, nonatomic) IBOutlet UILabel *bioElement;

@property (weak, nonatomic) IBOutlet UIStackView *locationStack;
@property (weak, nonatomic) IBOutlet UIStackView *portfolioStack;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingElement;
@property (weak, nonatomic) IBOutlet UIButton *reloadElement;
@end

@implementation UserProfileViewController

#pragma mark init
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setup];
    [self loadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setup
{
    _photoservice = [[PhotoService alloc] init];
    
    [self navBarTitle:_userName];
    [self.portfolioUrlElement addTapGestureWithTarget: self selector:@selector(portfolioUrlTouchDown:)];
}

#pragma mark data
-(void)loadData
{
    self.reloadElement.hidden = true;
    [self loadingState: true];
    [_photoservice loadUserPublicProfile: _userName
                                callback:^(UserProfile *profile, NSString *errormsg)
    {
        [self loadingState: false];
        if(!errormsg)
        {
            [self update:profile];
        }
        else
        {
            [self topBarMsg: errormsg];
            self.reloadElement.hidden = false;
        }
    }];
}

-(void)update: (UserProfile *) profile
{
    [self.avatarElement sd_setImageWithURL:[NSURL URLWithString: profile.profile_image.large] placeholderImage: nil];
    self.nameElement.text = profile.name;
    
    BOOL locationFlag = [NSString stringIsNilOrEmpty: profile.location];
    [self.locationElement setHidden:locationFlag];
    [self.locationStack setHidden:locationFlag];
    self.locationElement.text = profile.location;

    BOOL portfolioFlag = [NSString stringIsNilOrEmpty: profile.portfolio_url];
    [self.portfolioUrlElement setHidden: portfolioFlag];
    [self.portfolioStack setHidden:portfolioFlag];
    self.portfolioUrlElement.text = profile.portfolio_url;

    self.bioElement.text = profile.bio;
    
    [UIView animateWithDuration: 0.7 animations:
     ^{
         self.avatarElement.alpha = 1;
         self.locationStack.alpha = 1;
         self.portfolioStack.alpha = 1;
         self.nameElement.alpha = 1;
         self.bioElement.alpha = 1;
     }];
 }

#pragma mark interactions
- (void)portfolioUrlTouchDown:(id)sender
{
    [SystemServiceHelper openWithUrl: self.portfolioUrlElement.text];
}

- (IBAction)reloadClicked:(id)sender
{
    [self loadData];
}

#pragma mark UI helper
-(void)navBarTitle:(NSString*)title
{
    self.navigationItem.title = title;
}

-(void)loadingState:(BOOL) loading
{
    if(loading)
    {
        [self.loadingElement startAnimating];
    }
    else
    {
        [self.loadingElement stopAnimating];
    }
}

-(void)topBarMsg:(NSString*)text
{
    [ToastService showToastWithStatus:text];
}

@end
