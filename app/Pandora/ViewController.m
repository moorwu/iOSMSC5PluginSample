//
//  ViewController.m
//  Pandora
//
//  Created by Mac Pro_C on 12-12-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//
#import "ViewController.h"
#import "PDRToolSystem.h"
#import "PDRToolSystemEx.h"
#import "PDRCore.h"

@implementation ViewController

- (void)viewDidLoad
{
    _isFullScreen = FALSE;
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleNeedEnterFullScreenNotification:)
                                                 name:PDRNeedEnterFullScreenNotification
                                               object:nil];
    CGRect newRect = self.view.bounds;
	// Do any additional setup after loading the view, typically from a nib.
    if ( IOS_DEV_GROUP_IPAD == DHA_Tool_GetDeviceModle()  ) {
        UIInterfaceOrientation interfaceOrientation = [UIApplication sharedApplication].statusBarOrientation;
        if ( ![[PDRCore Instance].settings supportsOrientation:interfaceOrientation] ) {
            interfaceOrientation = UIInterfaceOrientationPortrait;
        }
        //[self resizeWithOrientation:interfaceOrientation];
        if ( UIDeviceOrientationLandscapeLeft == interfaceOrientation
            || interfaceOrientation == UIDeviceOrientationLandscapeRight ) {
            CGFloat temp = newRect.size.width;
            newRect.size.width = newRect.size.height;
            newRect.size.height = temp;
        } else {
        }
    }
    
    if ( [PTDeviceOSInfo systemVersion] > PTSystemVersion6Series ) {
        newRect.origin.y += 20;
        newRect.size.height -= 20;
    }
    
    _containerView = [[UIView alloc] initWithFrame:newRect];
    [self.view addSubview:_containerView];
    ///1113
    [[PDRCore Instance] setContainerView:_containerView];
    //[[PDRCore Instance] setContainerView:self.view];
    [[PDRCore Instance] start];
}

- (void)resizeWithOrientation:(UIInterfaceOrientation)interfaceOrientation {
    CGRect winBounds = [UIScreen mainScreen].applicationFrame;
    if ( UIDeviceOrientationLandscapeLeft == interfaceOrientation
        || interfaceOrientation == UIDeviceOrientationLandscapeRight ) {
        winBounds = CGRectMake(0, 0, winBounds.size.height, winBounds.size.width);
    } else {
        winBounds = CGRectMake(0, 0, winBounds.size.width, winBounds.size.height );
    }
    self.view.bounds = winBounds;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:PDRNeedEnterFullScreenNotification object:nil];
     // Release any retained subviews of the main view.
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                         duration:(NSTimeInterval)duration
{
  //  [self resizeWithOrientation:toInterfaceOrientation];
    CGRect newRect = self.view.bounds;
    if ( [PTDeviceOSInfo systemVersion] > PTSystemVersion6Series && !_isFullScreen ) {
        newRect.origin.y += 20;
        newRect.size.height -= 20;
    }
    _containerView.frame = newRect;
    [[PDRCore Instance] handleSysEvent:PDRCoreSysEventInterfaceOrientation
                        withObject:[NSNumber numberWithInt:toInterfaceOrientation]];
}

- (BOOL)shouldAutorotate
{
    return TRUE;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return [[PDRCore Instance].settings supportedInterfaceOrientations];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ( [PDRCore Instance].settings ) {
        return [[PDRCore Instance].settings supportsOrientation:interfaceOrientation];
    }
    return UIInterfaceOrientationPortrait == interfaceOrientation;
}

- (BOOL)prefersStatusBarHidden
{
    return _isFullScreen;
    NSString *model = [UIDevice currentDevice].model;
    if (UIUserInterfaceIdiomPhone == UI_USER_INTERFACE_IDIOM()
        && (NSOrderedSame == [@"iPad" caseInsensitiveCompare:model]
            || NSOrderedSame == [@"iPad Simulator" caseInsensitiveCompare:model])) {
            return YES;
        }
    return NO;
}

- (void)handleNeedEnterFullScreenNotification:(NSNotification*)notification
{
    NSNumber *isHidden = [notification object];
    if ( [PTDeviceOSInfo systemVersion] > PTSystemVersion6Series ) {
        _isFullScreen = [isHidden boolValue];
        [self setNeedsStatusBarAppearanceUpdate];
    } else {
        [[UIApplication sharedApplication] setStatusBarHidden:[isHidden boolValue] withAnimation:YES];
    }
    _isFullScreen1 = [isHidden boolValue];
    [self performSelector:@selector(resizeScreen) withObject:nil afterDelay:0.1];
}

-(void)resizeScreen {
    CGRect newRect = self.view.bounds;
    if ( [PTDeviceOSInfo systemVersion] > PTSystemVersion6Series && !_isFullScreen ) {
        newRect.origin.y += 20;
        newRect.size.height -= 20;
    }
    if ( [PTDeviceOSInfo systemVersion] <= PTSystemVersion6Series ) {
        if ( _isFullScreen1 ) {
            newRect.origin.y -= 20;
        }
    }
    _containerView.frame = newRect;
    [[PDRCore Instance] handleSysEvent:PDRCoreSysEventInterfaceOrientation
                            withObject:[NSNumber numberWithInt:0]];
}

- (void)dealloc {
//    [_containerView release];
//    [super dealloc];
}

@end
