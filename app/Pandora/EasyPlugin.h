//
//  EasyPlugin.h
//  PandoraDev
//
//  Created by Moor Wu on 4/18/14.
//
//

#import "PGPlugin.h"
#import "PGMethod.h"

@interface EasyPlugin : PGPlugin<UIAlertViewDelegate>
@property(nonatomic, retain)NSString *cbID;
@property(nonatomic, assign)BOOL isShow;
- (void)show:(PGMethod*)command;
- (NSData*)getString:(PGMethod*)command;
@end

