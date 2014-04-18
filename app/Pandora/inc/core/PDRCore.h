//
//  PDRCore.h
//  Pandora Project
//
//  Created by Mac on 12-12-25.
//  Copyright (c) 2012年 DCloud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import <netinet/in.h>

#import "PDRCoreDefs.h"
#import "PDRCoreSettings.h"

@class PDRCoreWindowManager;
@class PDRCoreAppManager;

/// H5+核心类负责H5+runtime的启动关闭
@interface PDRCore : NSObject

/// @brief Runtime应用管理对象
@property(nonatomic, readonly)PDRCoreAppManager *appManager;
/// @brief Runtime根视图管理对象
@property(nonatomic, readonly)PDRCoreWindowManager *coreWindow;
/// @brief Runtime设置对象,保存设置信息
@property(nonatomic, readonly)PDRCoreSettings *settings;

/// @brief 获取Core单例对象
+ (PDRCore*)Instance;
/// @brief 获取PandoraApi.bundle的路径
- (NSString*)mainBundlePath;
- (id)handleSysEvent:(PDRCoreSysEvent)evt withObject:(id)object;
/// @brief 设置应用运行时目录<br/>
/// 当应用 runmode为liberate时将把资源拷贝到该目录<br/>
/// 应用运行时产生的文件在该目录下生成<br/>
- (int)setAppsRunPath:(NSString*)workPath;
/// @brief 设置runtime应用的安装目录<br/>
/// @brief 该地址为安装包中携带的应用资源位置
- (int)setAppsInstallPath:(NSString*)installPath;
- (void)setInnerVersion:(NSString*)innerVersion;
/// @brief 设置runtime文档目录.
- (int)setDocumethPath:(NSString*)documentPath;
/// @brief 设置runtime下载目录
- (int)setDownloadPath:(NSString*)downlaodPath;
/// @brief 设置runtiem启动时自动运行的APP
- (int)setAutoStartAppid:(NSString*)appid;
/// @brief 设置runtime根视图的父亲View
- (int)setContainerView:(UIView*)containerView;
/**
 @brief 设置指定app的文档目录
 @param appid 要设置的appid
 @param doucmentPath 要设置的路径
 @return int 0 成功
 */
- (int)setApp:(NSString*)appid documentPath:(NSString*)doucmentPath;
/**
 @brief 注册第三方扩展的插件
 @param pluginName 插件名称JS文件中定义的名字
 @param impClassName 插件对应的实现类名
 @param pluginType 插件类型 详情: `PDRExendPluginType`
 @see PDRExendPluginType
 @param javaScript js实现 为javascript文本
 @return int 0 成功
 */
- (int)regPluginWithName:(NSString*)pluginName
             impClassName:(NSString*)impClassName
                    type:(PDRExendPluginType)pluginType
               javaScript:(NSString*)javaScript;
/**
 @brief 注册第三方扩展的插件
 @param pluginName 插件名称JS文件中定义的名字
 @param impClassName 插件对应的实现类名
 @param pluginType 插件类型 详情: `PDRExendPluginType`
 @see PDRExendPluginType
 @param javaScript js实现 为javascript文件 该文件为同步加载
 @return int 0 成功
 */
- (int)regPluginWithName:(NSString*)pluginName
            impClassName:(NSString*)impClassName
                    type:(PDRExendPluginType)pluginType
              javaScriptPath:(NSString*)javaScript;
/**
 @brief 正常启动runtime
        使用改方法启动runtime具有全部功能
        包括具有应用管理、窗口管理、插件管理、权限管理、资源管理等功能
 @see startAsWebClient
 @return int
*/
- (int)start;
/**
 @brief 启动runtime 
        使用该方法启动的runtime不具有应用管理窗口管理功能
        当需要显示页面时,需要自己创建PDRCoreAppFrame
 @see start
 @return int
 */
- (int)startAsWebClient;
/// @brief 关闭runtime 不会清除setting信息
- (int)end;
@end