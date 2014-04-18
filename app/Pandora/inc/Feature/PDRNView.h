//
//  PDRNView.h
//  Pandora
//
//  Created by Pro_C Mac on 13-4-7.
//
//

#import "PGMethod.h"
#import "PGPlugin.h"

@interface PDRJSContext : PGPlugin

@end

/**
 NView基类所有扩展出的NView插件都应该从该类继承
 */
@interface PDRNView : UIView {
    NSMutableDictionary *_viewOptions;
}

/// @brief JavaScript执行环境
@property (nonatomic, retain)PDRJSContext *JSContext;
/// @brief NView插件类别名称
/**  
 @brief 使用JS NViewOption创建NView 子类应该重写该方法实现初始化
 @param options NViewOption
 @return id NView对象
 */

@property (nonatomic, copy) NSString *mTypeIdentity;
@property (nonatomic, copy) NSString *mID;
@property (nonatomic, copy) NSString *mUUID;
@property (nonatomic, copy) NSString *mCallbackId;
//@property (nonatomic, strong)UIWebView* webView;
@property (nonatomic, strong)UIViewController*  viewController;
@property (nonatomic, assign)NSDictionary* mOptions;

- (id)initWithOptions:(NSDictionary*)options;
- (void)onRemoveFormSuperView;
- (NSData*)getMettics:( PGMethod*) pMethod;
// 返回当前控件最小尺寸，可以是%，或者PX值，或者Auto
- (NSDictionary*)GetMiniControllerSize:(int)nOri;
- (void)CreateView:(PGMethod*)pMethod;
- (NSString*)getObjectString;

@end
