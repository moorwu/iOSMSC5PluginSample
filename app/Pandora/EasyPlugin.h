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
- (NSData*)getString:(PGMethod*)command;
@end

