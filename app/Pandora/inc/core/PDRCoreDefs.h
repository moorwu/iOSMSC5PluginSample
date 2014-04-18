//
//  PDRCoreDefs.h
//  PDRCore
//
//  Created by X on 14-2-11.
//  Copyright (c) 2014年 io.dcloud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

UIKIT_EXTERN NSString *const PDRCoreOpenUrlNotification;
UIKIT_EXTERN NSString *const PDRNeedEnterFullScreenNotification;

/// 系统事件类型定义
typedef NS_ENUM(NSInteger, PDRCoreSysEvent) {
    /// 网络状态改变事件 Reserved
    PDRCoreSysEventNetChange = 0,
    /// 程序进入后台事件
    PDRCoreSysEventEnterBackground = 1,
    /// 程序进入前台事件
    PDRCoreSysEventEnterForeGround = 2,
    /// 打开URL事件
    PDRCoreSysEventOpenURL = 3,
    /// 本地自定义消息提醒
    PDRCoreSysEventRevLocalNotification = 4,
    /// APNS事件
    PDRCoreSysEventRevRemoteNotification = 5,
    /// 获取到APNS DeviceToken事件
    PDRCoreSysEventRevDeviceToken = 6,
    /// 屏幕旋转事件 Reserved
    PDRCoreSysEventInterfaceOrientation = 7
};

/// runtime错误码定义
enum {
    PDRCoreSuccess = 0,
    PDRCoreNetObserverCreateError = 1,
    PDRCoreInvalidParamError,
    PDRCoreFileNotExistError,
    PDRCorePandoraApibundleMiss,
    /// 资源管理器启动失败
    PDRCoreErrorResManagerBase = 10000,
    /// 应用管理类错误
    PDRCoreErrorAppManagerBase = 20000,
    PDRCoreInvalidMainpageError,
    /// 无效的mainfest文件
    PDRCoreAppInvalidMainfestError
};
