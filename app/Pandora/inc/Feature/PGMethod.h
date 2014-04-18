//
//  PGMethod.h
//  MSC_Pandora
//
//  Created by Pro_C Mac on 12-12-24.
//
//

#ifndef MSC_Pandora_PGMethod_h
#define MSC_Pandora_PGMethod_h
#import <Foundation/Foundation.h>

/** JavaScript 调用参数
 */
@interface PGMethod : NSObject

+ (PGMethod*)commandFromJson:(NSArray*)pJsonEntry;
- (void) legacyArguments:(NSMutableArray**)legacyArguments andDict:(NSMutableDictionary**)legacyDict ;

@property (nonatomic, assign)NSString*   htmlID;
@property (nonatomic, assign)NSString*   featureName;
@property (nonatomic, assign)NSString*   functionName;
@property (nonatomic, assign)NSString*   callBackID;
/// @brief JavaScirpt调用参数数组
@property (nonatomic, assign)NSArray*    arguments;

@end

#endif
