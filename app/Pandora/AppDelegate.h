//
//  AppDelegate.h
//  Pandora
//
//  Created by Mac Pro_C on 12-12-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PDRCore;

#ifdef PDR_PLUS_DHPUSH
#import "MKeyPush.h"
#endif

#ifdef PDR_PLUS_MAP
#import "BMKMapManager.h"
#import "BMKGeneralDelegate.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate, BMKGeneralDelegate>{
    BMKMapManager *_mapManager;
#else
    @interface AppDelegate : UIResponder <UIApplicationDelegate>{
#endif
    
#ifdef PDR_PLUS_DHPUSH
     MKeyPush *_pushServer;
#endif
}
@property (strong, nonatomic) UIWindow *window;
    
@end
