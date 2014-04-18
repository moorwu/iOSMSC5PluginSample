//
//  UIPlugin.h
//  PandoraDev
//
//  Created by Moor Wu on 4/17/14.
//
//

#import "PGPlugin.h"
#import "PGMethod.h"

@interface UIPlugin : PGPlugin

- (NSData*)drawPie:(PGMethod*)command;

@end
