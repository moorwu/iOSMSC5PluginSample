//
//  PDR_Application.h
//  Pandora
//
//  Created by Mac Pro on 12-12-22.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "PDRCoreAppFrame.h"
#import "PDRCoreApp.h"

@interface PDRCoreAppWindow : UIView

/**
 @brief 注册appframe
 @param appFrame
 @return BOOL TRUE 成功 重复注册同一窗口为失败
 */
- (BOOL)registerFrame:(PDRCoreAppFrame*)appFrame;
/**
 @brief 从window中删除appframe
 @param appFrame
 @return BOOL TRUE 成功 重复注册同一窗口为失败
 */
- (BOOL)unRegisterFrame:(PDRCoreAppFrame*)appFrame;
/**
 @brief 根据指定的ID获取appframe
 @param uuid
 @return PDRCoreAppFrame*
 */
- (PDRCoreAppFrame*)getFrameByID:(NSString*)uuid;
/**
 @brief 根据指定的name获取appframe
 @param name
 @return PDRCoreAppFrame*
 */
- (PDRCoreAppFrame*)getFrameByName:(NSString*)name;
/**
 @brief 获取所有frame
 @return NSArray*
 */
- (NSArray*)allFrames;
@end