//
//  PDR_Manager_Feature.h
//  MSC_Pandora
//
//  Created by Mac Pro_C on 12-12-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "PDRCore.h"
#import "PDRNView.h"

@class PDRCoreAppFrame;
@class PDRCoreApp;
@class PDRCoreAppWindow;
@class PGMethod;
@class PDRCoreAppFrameFeature;

///页面加载完成通知
extern NSString *const PDRCoreAppFrameDidLoadNotificationKey;
///页面关闭通知
extern NSString *const PDRCoreAppFrameDidCloseNotificationKey;
///页面将要加载通知
extern NSString *const PDRCoreAppFrameWillLoadNotificationKey;
///页面开始加载通知
extern NSString *const PDRCoreAppFrameStartLoadNotificationKey;
///页面加载失败通知
extern NSString *const PDRCoreAppFrameLoadFailedNotificationKey;

/// H5+应用页面
@interface PDRCoreAppFrame : PDRNView
/**
 @brief 创建runtime页面
 @param frameID 页面标示
 @param pagePath 页面地址 支持http:// file:// 本地地址
 @param frame 页面位置
 @return PDRCoreAppFrame* 
 */
- (PDRCoreAppFrame*)initWithId:(NSString*)frameID
                       loadURL:(NSString*)pagePath
                         frame:(CGRect)frame;
/// 页面唯一标识
@property(nonatomic, copy)NSString *frameID;
/// 页面名字
@property(nonatomic, copy)NSString *frameName;
/// HTML CSS渲染View
@property(nonatomic, readonly)UIWebView *webView;
/**
 @brief 在当前页面同步执行Javascript
 @param js javasrcipt 脚本
 @return NSString* 执行结果
 */
- (NSString*)stringByEvaluatingJavaScriptFromString:(NSString*)js;

@end